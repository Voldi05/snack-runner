import 'package:flutter/material.dart';
import 'package:snack_runner/data/app_data.dart';
import 'package:snack_runner/models/course.dart';
import 'package:snack_runner/screens/recapitulatif_screen.dart';
import 'package:snack_runner/theme/app_colors.dart';

class NouvelleCourseScreen extends StatefulWidget {
  const NouvelleCourseScreen({super.key});

  @override
  State<NouvelleCourseScreen> createState() => _NouvelleCourseScreenState();
}

class _NouvelleCourseScreenState extends State<NouvelleCourseScreen> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController deliveryController = TextEditingController();
  final TextEditingController rewardController = TextEditingController();
  String typeSelectionne = 'Cafétéria';
  String recompenseType = 'Argent';
  bool _isLoading = false;
  String? _descriptionError;
  String? _pickupError;
  String? _deliveryError;
  String? _rewardError;

  bool _validate() {
    setState(() {
      _descriptionError = descriptionController.text.trim().isEmpty
          ? 'Description requise'
          : null;
      _pickupError = pickupController.text.trim().isEmpty
          ? 'Lieu de retrait requis'
          : null;
      _deliveryError = deliveryController.text.trim().isEmpty
          ? 'Lieu de livraison requis'
          : null;
      if (recompenseType == 'Argent') {
        _rewardError = rewardController.text.trim().isEmpty
            ? 'Montant requis'
            : double.tryParse(rewardController.text.trim()) == null
            ? 'Montant invalide'
            : null;
      }
    });
    return _descriptionError == null &&
        _pickupError == null &&
        _deliveryError == null &&
        _rewardError == null;
  }

  @override
  void dispose() {
    descriptionController.dispose();
    pickupController.dispose();
    deliveryController.dispose();
    rewardController.dispose();
    super.dispose();
  }

  Course _buildCourse() {
    final requester = AppData.instance.currentUser.value;
    final rewardValue = double.tryParse(rewardController.text.trim()) ?? 500;
    final title = descriptionController.text.trim().isNotEmpty
        ? descriptionController.text.trim()
        : '$typeSelectionne rapide';

    return Course(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      category: typeSelectionne,
      title: title,
      pickupLocation: pickupController.text.trim().isNotEmpty
          ? pickupController.text.trim()
          : typeSelectionne == 'Cafétéria'
          ? 'Cafét RU B'
          : 'Bureau des étudiants',
      deliveryLocation: deliveryController.text.trim().isNotEmpty
          ? deliveryController.text.trim()
          : 'Amphi 3, Bâtiment B',
      reward: rewardValue,
      rewardType: recompenseType,
      status: CourseStatus.enAttente,
      requesterName: requester,
      runnerName: '',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg0,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Nouvelle course',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
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
                    const Text(
                      'TYPE DE COURSE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textHint,
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
                                    ? AppColors.amber
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: selected
                                      ? AppColors.amber
                                      : AppColors.border,
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
                                      ? AppColors.white
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'DÉCRIS TA COMMANDE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textHint,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        hintText: 'Ex : 2 sandwichs poulet, 1 jus d\'orange...',
                        hintStyle: const TextStyle(
                          color: AppColors.textHint,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: _descriptionError != null
                            ? AppColors.danger.withValues(alpha: 0.1)
                            : AppColors.bg4,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: _descriptionError != null
                              ? const BorderSide(color: Colors.red, width: 1.5)
                              : BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    if (_descriptionError != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        _descriptionError!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                    const SizedBox(height: 20),
                    const Text(
                      'LIEU DE RETRAIT',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textHint,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: pickupController,
                      decoration: InputDecoration(
                        hintText: 'Ex : Cafét RU B',
                        hintStyle: const TextStyle(
                          color: AppColors.textHint,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: _pickupError != null
                            ? AppColors.danger.withValues(alpha: 0.1)
                            : AppColors.bg4,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: _pickupError != null
                              ? const BorderSide(color: Colors.red, width: 1.5)
                              : BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                    if (_pickupError != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        _pickupError!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                    const SizedBox(height: 20),
                    const Text(
                      'LIEU DE LIVRAISON',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textHint,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: deliveryController,
                      decoration: InputDecoration(
                        hintText: 'Ex : Amphi 3, Bâtiment B',
                        hintStyle: const TextStyle(
                          color: AppColors.textHint,
                          fontSize: 13,
                        ),
                        filled: true,
                        fillColor: _deliveryError != null
                            ? AppColors.danger.withValues(alpha: 0.1)
                            : AppColors.bg4,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                          borderSide: _deliveryError != null
                              ? const BorderSide(color: Colors.red, width: 1.5)
                              : BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 16,
                        ),
                      ),
                    ),
                    if (_deliveryError != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        _deliveryError!,
                        style: const TextStyle(color: Colors.red, fontSize: 12),
                      ),
                    ],
                    const SizedBox(height: 20),
                    const Text(
                      'TYPE DE RÉCOMPENSE',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textHint,
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
                                    ? AppColors.amber
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                  color: selected
                                      ? AppColors.amber
                                      : AppColors.border,
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
                                      ? AppColors.white
                                      : AppColors.textSecondary,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    if (recompenseType == 'Argent')
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextField(
                            controller: rewardController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: '500',
                              hintStyle: const TextStyle(
                                color: AppColors.textHint,
                              ),
                              filled: true,
                              fillColor: _rewardError != null
                                  ? AppColors.danger.withValues(alpha: 0.1)
                                  : AppColors.bg4,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(50),
                                borderSide: _rewardError != null
                                    ? const BorderSide(
                                        color: AppColors.danger,
                                        width: 1.5,
                                      )
                                    : BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 16,
                              ),
                              suffixText: 'FCFA',
                              suffixStyle: const TextStyle(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          if (_rewardError != null) ...[
                            const SizedBox(height: 4),
                            Text(
                              _rewardError!,
                              style: const TextStyle(
                                color: AppColors.danger,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ],
                      ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          if (!_validate()) return;
                          setState(() => _isLoading = true);
                          await Future.delayed(
                            const Duration(milliseconds: 600),
                          );
                          if (mounted) {
                            final course = _buildCourse();
                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    RecapitulatifScreen(course: course),
                              ),
                            );
                            setState(() => _isLoading = false);
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
                              AppColors.white,
                            ),
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          'Voir le récapitulatif →',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
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
