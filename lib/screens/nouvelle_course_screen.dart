import 'package:flutter/material.dart';
import 'recapitulatif_screen.dart';

class NouvelleCourseScreen extends StatefulWidget {
  const NouvelleCourseScreen({super.key});

  @override
  State<NouvelleCourseScreen> createState() => _NouvelleCourseScreenState();
}

class _NouvelleCourseScreenState extends State<NouvelleCourseScreen> {
  String typeSelectionne = 'Cafétéria';
  String recompenseType = 'Argent';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Nouvelle course',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),

                    // Type de course
                    const Text(
                      'TYPE DE COURSE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: ['Cafétéria', 'Colis', 'Autre'].map((type) {
                        final selected = typeSelectionne == type;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => typeSelectionne = type),
                            child: Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFF1A6B4A)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: selected
                                      ? const Color(0xFF1A6B4A)
                                      : const Color(0xFFE2E8F0),
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                type,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: selected
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),

                    // Description
                    const Text(
                      'DÉCRIS TA COMMANDE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Ex : 2 sandwichs poulet, 1 jus d\'orange...',
                        hintStyle: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Lieu de livraison
                    const Text(
                      'LIEU DE LIVRAISON',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Ex : Amphi 3, Bâtiment B',
                        hintStyle: const TextStyle(
                          color: Color(0xFF94A3B8),
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF1F5F9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Type de récompense
                    const Text(
                      'TYPE DE RÉCOMPENSE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF94A3B8),
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: ['Argent', 'Nourriture'].map((type) {
                        final selected = recompenseType == type;
                        return Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => recompenseType = type),
                            child: Container(
                              margin: const EdgeInsets.only(right: 6),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: selected
                                    ? const Color(0xFF1A6B4A)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: selected
                                      ? const Color(0xFF1A6B4A)
                                      : const Color(0xFFE2E8F0),
                                  width: 1.5,
                                ),
                              ),
                              child: Text(
                                type,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: selected
                                      ? Colors.white
                                      : const Color(0xFF64748B),
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),

                    // Montant
                    if (recompenseType == 'Argent')
                      TextField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: '500',
                          hintStyle: const TextStyle(color: Color(0xFF94A3B8)),
                          filled: true,
                          fillColor: const Color(0xFFF1F5F9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          suffixText: 'FCFA',
                          suffixStyle: const TextStyle(
                            color: Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),

            // CTA
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const RecapitulatifScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1A6B4A),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                  child: const Text(
                    'Voir le récapitulatif →',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
