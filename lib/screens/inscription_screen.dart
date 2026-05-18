import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:snack_runner/providers/user_provider.dart';
import 'package:snack_runner/theme/app_colors.dart';

class InscriptionScreen extends ConsumerStatefulWidget {
  const InscriptionScreen({super.key});

  @override
  ConsumerState<InscriptionScreen> createState() => _InscriptionScreenState();
}

class _InscriptionScreenState extends ConsumerState<InscriptionScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String selectedRole = 'Expéditeur';
  bool _isLoading = false;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _roleError;

  bool _validate() {
    setState(() {
      _nameError = nameController.text.trim().isEmpty ? 'Nom requis' : null;
      _emailError = emailController.text.trim().isEmpty ? 'Email requis' : null;
      _passwordError = passwordController.text.trim().isEmpty
          ? 'Mot de passe requis'
          : null;
      _roleError = selectedRole.isEmpty ? 'Rôle requis' : null;
    });
    return _nameError == null &&
        _emailError == null &&
        _passwordError == null &&
        _roleError == null;
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Créer un compte',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Rejoins SnackRunner pour publier ou accepter des courses.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Nom',
                  hintStyle: const TextStyle(color: AppColors.textHint),
                  filled: true,
                  fillColor: _nameError != null
                      ? AppColors.danger.withValues(alpha: 0.1)
                      : AppColors.bg4,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: _nameError != null
                        ? const BorderSide(color: AppColors.danger, width: 1.5)
                        : BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
              if (_nameError != null) ...[
                const SizedBox(height: 4),
                Text(
                  _nameError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  hintText: 'Email universitaire',
                  hintStyle: const TextStyle(color: AppColors.textHint),
                  filled: true,
                  fillColor: _emailError != null
                      ? AppColors.danger.withValues(alpha: 0.1)
                      : AppColors.bg4,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: _emailError != null
                        ? const BorderSide(color: AppColors.danger, width: 1.5)
                        : BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
              if (_emailError != null) ...[
                const SizedBox(height: 4),
                Text(
                  _emailError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 12),
              const Text(
                'TON RÔLE',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textHint,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: ['Expéditeur', 'Runner'].map((role) {
                  final selected = selectedRole == role;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => selectedRole = role),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.amber : AppColors.white,
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                            color: selected
                                ? AppColors.amber
                                : AppColors.border,
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          role,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: selected
                                ? AppColors.white
                                : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Mot de passe',
                  hintStyle: const TextStyle(color: AppColors.textHint),
                  filled: true,
                  fillColor: _passwordError != null
                      ? AppColors.danger.withValues(alpha: 0.1)
                      : AppColors.bg4,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: _passwordError != null
                        ? const BorderSide(color: AppColors.danger, width: 1.5)
                        : BorderSide.none,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                ),
              ),
              if (_passwordError != null) ...[
                const SizedBox(height: 4),
                Text(
                  _passwordError!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ],
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (!_validate()) return;
                          setState(() => _isLoading = true);
                          await Future.delayed(
                            const Duration(milliseconds: 800),
                          );
                          if (mounted) {
                            final name = nameController.text.trim();
                            ref.read(userProvider.notifier).state = name;
                            // ignore: use_build_context_synchronously
                            context.pop();
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.amber,
                    foregroundColor: AppColors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Créer mon compte',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
