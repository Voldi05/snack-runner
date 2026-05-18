import 'package:flutter/material.dart';
import 'package:snack_runner/data/app_data.dart';
import 'package:snack_runner/models/course.dart';
import 'package:snack_runner/screens/mission_screen.dart';
import 'package:snack_runner/theme/app_colors.dart';

class SuiviScreen extends StatelessWidget {
  final String courseId;

  const SuiviScreen({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    final appData = AppData.instance;

    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(
        backgroundColor: AppColors.bg0,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: const Text('Suivi de la course'),
      ),
      body: ValueListenableBuilder<List<Course>>(
        valueListenable: appData.publishedCourses,
        builder: (context, courses, _) {
          final course = appData.courseById(courseId);
          if (course == null) {
            return const Center(
              child: Text(
                'Course introuvable.',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
            );
          }
          final isRunner = course.runnerName == appData.currentUser.value;
          final currentUserIsRequester =
              course.requesterName == appData.currentUser.value;
          final statusLabel = course.status.label;

          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${course.category} • ${course.rewardLabel}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                _StatusChip(
                  status: statusLabel,
                  color: course.status.badgeBackground,
                ),
                const SizedBox(height: 20),
                _InfoRow(label: 'Demandeur', value: course.requesterName),
                _InfoRow(label: 'Retrait', value: course.pickupLocation),
                _InfoRow(label: 'Livraison', value: course.deliveryLocation),
                if (course.runnerName.isNotEmpty)
                  _InfoRow(label: 'Runner', value: course.runnerName),
                const SizedBox(height: 24),
                Text(
                  currentUserIsRequester
                      ? 'Suivi de ta publication'
                      : 'Suivi de la mission',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  course.status == CourseStatus.enAttente
                      ? 'Ta course est publiée et attend un runner.'
                      : course.status == CourseStatus.acceptee
                      ? 'Un runner a accepté la course. Prépare la livraison.'
                      : course.status == CourseStatus.livraison
                      ? 'La course est en cours de livraison.'
                      : 'La course est terminée.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                if (isRunner &&
                    (course.status == CourseStatus.acceptee ||
                        course.status == CourseStatus.livraison))
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MissionScreen(courseId: course.id),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.amber,
                        foregroundColor: AppColors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      child: const Text(
                        'Voir la mission',
                        style: TextStyle(
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

class _StatusChip extends StatelessWidget {
  final String status;
  final Color color;

  const _StatusChip({required this.status, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: AppColors.textHint,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
