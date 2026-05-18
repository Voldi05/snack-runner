import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/course.dart';

final courseProvider = StateNotifierProvider<CourseNotifier, List<Course>>(
  (ref) => CourseNotifier(),
);

class CourseNotifier extends StateNotifier<List<Course>> {
  CourseNotifier() : super(_initialCourses);

  static const _initialCourses = [
    Course(
      id: '1',
      category: 'Cafétéria',
      title: 'Sandwich thon + jus d\'orange',
      pickupLocation: 'Cafét RU B',
      deliveryLocation: 'Amphi 3, Bâtiment B',
      reward: 500,
      rewardType: 'Argent',
      status: CourseStatus.enAttente,
      requesterName: 'Kofi',
      runnerName: '',
    ),
    Course(
      id: '2',
      category: 'Colis',
      title: 'Colis étudiant',
      pickupLocation: 'Bureau des étudiants',
      deliveryLocation: 'Résidence A',
      reward: 700,
      rewardType: 'Argent',
      status: CourseStatus.enAttente,
      requesterName: 'Amina',
      runnerName: '',
    ),
    Course(
      id: '3',
      category: 'Cafétéria',
      title: 'Salade + eau',
      pickupLocation: 'Cafét A',
      deliveryLocation: 'Bibliothèque',
      reward: 300,
      rewardType: 'Argent',
      status: CourseStatus.terminee,
      requesterName: 'Kofi',
      runnerName: 'Sam',
    ),
  ];

  void setCourses(List<Course> courses) => state = courses;

  void addCourse(Course course) => state = [...state, course];

  void updateCourse(Course updated) {
    state = [
      for (final course in state)
        if (course.id == updated.id) updated else course,
    ];
  }

  Course? courseById(String id) {
    for (final course in state) {
      if (course.id == id) {
        return course;
      }
    }
    return null;
  }

  bool isPublished(String courseId) {
    return state.any((course) => course.id == courseId);
  }

  void acceptCourse(String courseId, String runnerName) {
    updateCourse(
      courseById(
            courseId,
          )?.copyWith(status: CourseStatus.acceptee, runnerName: runnerName) ??
          courseById(courseId)!,
    );
  }

  void startDelivery(String courseId) {
    updateCourse(
      courseById(courseId)?.copyWith(status: CourseStatus.livraison) ??
          courseById(courseId)!,
    );
  }

  void completeCourse(String courseId, String runnerName) {
    updateCourse(
      courseById(courseId)?.copyWith(status: CourseStatus.terminee) ??
          courseById(courseId)!,
    );
  }
}
