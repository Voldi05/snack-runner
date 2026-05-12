import 'package:flutter/foundation.dart';

import '../models/course.dart';

class AppData {
  AppData._();

  static final AppData instance = AppData._();

  final ValueNotifier<String> currentUser = ValueNotifier('Kofi');
  final ValueNotifier<List<Course>> publishedCourses = ValueNotifier([
    const Course(
      id: '1',
      category: 'Cafétéria',
      title: 'Sandwich thon + jus d\'orange',
      pickupLocation: 'Cafét RU B',
      deliveryLocation: 'Amphi 3, Bâtiment B',
      reward: 500,
      rewardType: 'Argent',
      status: CourseStatus.waiting,
      requesterName: 'Kofi',
      runnerName: '',
    ),
    const Course(
      id: '2',
      category: 'Colis',
      title: 'Colis étudiant',
      pickupLocation: 'Bureau des étudiants',
      deliveryLocation: 'Résidence A',
      reward: 700,
      rewardType: 'Argent',
      status: CourseStatus.waiting,
      requesterName: 'Amina',
      runnerName: '',
    ),
    const Course(
      id: '3',
      category: 'Cafétéria',
      title: 'Salade + eau',
      pickupLocation: 'Cafét A',
      deliveryLocation: 'Bibliothèque',
      reward: 300,
      rewardType: 'Argent',
      status: CourseStatus.completed,
      requesterName: 'Kofi',
      runnerName: 'Sam',
    ),
  ]);
  final ValueNotifier<double> totalEarnings = ValueNotifier(0);
  final ValueNotifier<double> totalSpending = ValueNotifier(500);

  void setCurrentUser(String user) {
    currentUser.value = user;
  }

  Course? courseById(String id) {
    final index = publishedCourses.value.indexWhere(
      (course) => course.id == id,
    );
    if (index < 0) {
      return null;
    }
    return publishedCourses.value[index];
  }

  void publishCourse(Course course) {
    final updated = [course, ...publishedCourses.value];
    publishedCourses.value = updated;

    if (course.requesterName == currentUser.value) {
      totalSpending.value += course.reward;
    }
  }

  bool isPublished(String courseId) {
    return publishedCourses.value.any((course) => course.id == courseId);
  }

  void acceptCourse(String courseId) {
    _updateCourse(courseId, (course) {
      return course.copyWith(
        status: CourseStatus.accepted,
        runnerName: currentUser.value,
      );
    });
  }

  void startDelivery(String courseId) {
    _updateCourse(courseId, (course) {
      return course.copyWith(status: CourseStatus.delivering);
    });
  }

  void completeCourse(String courseId) {
    _updateCourse(courseId, (course) {
      final updatedCourse = course.copyWith(status: CourseStatus.completed);
      if (course.runnerName == currentUser.value) {
        totalEarnings.value += course.reward;
      }
      return updatedCourse;
    });
  }

  void _updateCourse(String courseId, Course Function(Course course) update) {
    final index = publishedCourses.value.indexWhere(
      (course) => course.id == courseId,
    );
    if (index < 0) {
      return;
    }
    final updatedCourse = update(publishedCourses.value[index]);
    final updatedCourses = List<Course>.from(publishedCourses.value);
    updatedCourses[index] = updatedCourse;
    publishedCourses.value = updatedCourses;
  }
}
