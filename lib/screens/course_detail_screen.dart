import 'package:flutter/material.dart';
import 'package:snack_runner/data/app_data.dart';
import 'package:snack_runner/models/course.dart';
import 'package:snack_runner/screens/mission_screen.dart';

class CourseDetailScreen extends StatefulWidget {
  final Course course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final appData = AppData.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF1E293B),
        elevation: 0,
        title: const Text('Détails de la course'),
      ),
      body: ValueListenableBuilder<List<Course>>(
        valueListenable: appData.publishedCourses,
        builder: (context, courses, _) {
          final currentCourse = courses.firstWhere(
            (item) => item.id == widget.course.id,
            orElse: () => widget.course,
          );
          final isRunner =
              currentCourse.runnerName == appData.currentUser.value;
          final requester = currentCourse.requesterName;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currentCourse.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${currentCourse.category} • ${currentCourse.rewardLabel}',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 24),
                _DetailRow(
                  label: 'Point de retrait',
                  value: currentCourse.pickupLocation,
                ),
                _DetailRow(
                  label: 'Adresse de livraison',
                  value: currentCourse.deliveryLocation,
                ),
                _DetailRow(label: 'Demandeur', value: requester),
                _DetailRow(label: 'Statut', value: currentCourse.status.label),
                if (currentCourse.runnerName.isNotEmpty)
                  _DetailRow(label: 'Runner', value: currentCourse.runnerName),
                const SizedBox(height: 24),
                if (currentCourse.status == CourseStatus.waiting &&
                    currentCourse.requesterName != appData.currentUser.value)
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
                                appData.acceptCourse(currentCourse.id);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MissionScreen(
                                      courseId: currentCourse.id,
                                    ),
                                  ),
                                );
                              }
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1A6B4A),
                        foregroundColor: Colors.white,
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
                              'Accepter cette course',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  ),
                if ((currentCourse.status == CourseStatus.accepted ||
                        currentCourse.status == CourseStatus.delivering) &&
                    isRunner)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              setState(() => _isLoading = true);
                              await Future.delayed(
                                const Duration(milliseconds: 300),
                              );
                              if (mounted) {
                                setState(() => _isLoading = false);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => MissionScreen(
                                      courseId: currentCourse.id,
                                    ),
                                  ),
                                );
                              }
                            },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xFF1A6B4A),
                        side: const BorderSide(
                          color: Color(0xFF1A6B4A),
                          width: 1.5,
                        ),
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
                                  Color(0xFF1A6B4A),
                                ),
                                strokeWidth: 2,
                              ),
                            )
                          : const Text(
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

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xFF1E293B),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
