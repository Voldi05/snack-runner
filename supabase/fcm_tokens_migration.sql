-- ============================================================
--  snackrunner_fcm_tokens.sql
--  Complément au schéma principal — à exécuter après
--  snackrunner_schema.sql
-- ============================================================

-- ── Table fcm_tokens ─────────────────────────────────────────
-- Stocke les tokens Firebase Cloud Messaging par appareil.
-- Un utilisateur peut avoir plusieurs appareils (mobile + web).

CREATE TABLE public.fcm_tokens (
    id         UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    user_id    UUID        NOT NULL REFERENCES public.users(id) ON DELETE CASCADE,
    token      TEXT        NOT NULL UNIQUE,
    platform   TEXT        NOT NULL CHECK (platform IN ('android', 'ios', 'web')),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX idx_fcm_tokens_user ON public.fcm_tokens(user_id);

-- Mise à jour automatique de updated_at
CREATE OR REPLACE FUNCTION public.update_fcm_token_timestamp()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$;

CREATE TRIGGER fcm_token_updated
    BEFORE UPDATE ON public.fcm_tokens
    FOR EACH ROW
    EXECUTE FUNCTION public.update_fcm_token_timestamp();

-- ── RLS fcm_tokens ───────────────────────────────────────────

ALTER TABLE public.fcm_tokens ENABLE ROW LEVEL SECURITY;

-- Chaque utilisateur gère ses propres tokens
CREATE POLICY "fcm_tokens_own"
    ON public.fcm_tokens FOR ALL
    TO authenticated
    USING      (auth.uid() = user_id)
    WITH CHECK (auth.uid() = user_id);

-- ── Vue utilitaire : notifications non lues par utilisateur ──

CREATE OR REPLACE VIEW public.unread_notifications AS
SELECT
    n.id,
    n.user_id,
    n.errand_id,
    n.type,
    n.message,
    n.created_at,
    e.titre  AS errand_titre,
    e.status AS errand_status,
    e.lieu   AS errand_lieu
FROM public.notifications n
LEFT JOIN public.errands e ON e.id = n.errand_id
WHERE n.is_read = FALSE
  AND n.created_at <= NOW()
ORDER BY n.created_at DESC;
