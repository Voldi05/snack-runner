import 'package:flutter/material.dart';
import 'package:snack_runner/data/app_data.dart';
import 'package:snack_runner/models/course.dart';
import 'package:snack_runner/screens/course_detail_screen.dart';
import 'package:snack_runner/theme/app_colors.dart';
import 'package:snack_runner/widgets/course_card.dart';

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appData = AppData.instance;

    return Scaffold(
      backgroundColor: AppColors.bg0,
      appBar: AppBar(
        backgroundColor: AppColors.bg0,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        title: const Text('Courses disponibles'),
      ),
      body: ValueListenableBuilder<String>(
        valueListenable: appData.currentUser,
        builder: (context, currentUser, _) {
          return ValueListenableBuilder<List<Course>>(
            valueListenable: appData.publishedCourses,
            builder: (context, courses, _) {
              final waitingCourses = courses
                  .where(
                    (course) =>
                        course.status == CourseStatus.waiting &&
                        course.requesterName != currentUser,
                  )
                  .toList();

              if (waitingCourses.isEmpty) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: AppColors.bg3,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: AppColors.amber,
                            size: 40,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Aucune course disponible',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Revenez plus tard pour accepter une mission.',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                context,
                                '/dashboard',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.amber,
                              foregroundColor: AppColors.black,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            child: const Text(
                              'Retour au tableau de bord',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: waitingCourses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final course = waitingCourses[index];
                  return CourseCard(
                    course: course,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CourseDetailScreen(course: course),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
