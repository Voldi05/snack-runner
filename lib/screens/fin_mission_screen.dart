import 'package:flutter/material.dart';
import 'package:snack_runner/data/app_data.dart';
import 'package:snack_runner/models/course.dart';
import 'package:snack_runner/screens/dashboard_screen.dart';
import 'package:snack_runner/theme/app_colors.dart';

class FinMissionScreen extends StatefulWidget {
  final String courseId;

  const FinMissionScreen({super.key, required this.courseId});

  @override
  State<FinMissionScreen> createState() => _FinMissionScreenState();
}

class _FinMissionScreenState extends State<FinMissionScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appData = AppData.instance;

    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(
        backgroundColor: AppColors.bg0,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: const Text('Fin de mission'),
      ),
      body: ValueListenableBuilder<List<Course>>(
        valueListenable: appData.publishedCourses,
        builder: (context, courses, _) {
          final course = appData.courseById(widget.courseId);

          if (course == null) {
            return const Center(child: Text('Course introuvable.'));
          }

          final isCompleted = course.status == CourseStatus.terminee;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCompleted ? 'Mission terminée' : 'Terminer la livraison',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 16,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.bg4,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Récompense',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        course.rewardLabel,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.amber,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _isLoading
                        ? null
                        : () async {
                            setState(() => _isLoading = true);
                            await Future.delayed(
                              const Duration(milliseconds: 600),
                            );
                            if (mounted) {
                              if (!isCompleted) {
                                appData.completeCourse(course.id);
                              }
                              // ignore: use_build_context_synchronously
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const DashboardScreen(),
                                ),
                                (route) => false,
                              );
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
                        : Text(
                            isCompleted
                                ? 'Retour à l\'accueil'
                                : 'Valider la livraison',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
