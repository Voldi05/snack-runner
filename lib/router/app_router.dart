import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:snack_runner/models/course.dart';
import 'package:snack_runner/screens/course_detail_screen.dart';
import 'package:snack_runner/screens/courses_screen.dart';
import 'package:snack_runner/screens/dashboard_screen.dart';
import 'package:snack_runner/screens/fin_mission_screen.dart';
import 'package:snack_runner/screens/inscription_screen.dart';
import 'package:snack_runner/screens/login_screen.dart';
import 'package:snack_runner/screens/mission_screen.dart';
import 'package:snack_runner/screens/nouvelle_course_screen.dart';
import 'package:snack_runner/screens/recapitulatif_screen.dart';
import 'package:snack_runner/screens/suivi_screen.dart';

class AppRouter {
  static final ValueNotifier<bool> authListenable = ValueNotifier(false);

  static void notifyAuthChanged(bool loggedIn) {
    authListenable.value = loggedIn;
  }

  final GoRouter router;

  AppRouter({required bool isLoggedIn})
    : router = GoRouter(
        initialLocation: isLoggedIn ? '/dashboard' : '/login',
        refreshListenable: authListenable,
        redirect: (context, state) {
          final loggedIn = authListenable.value;
          final loggingIn =
              state.location == '/login' || state.location == '/inscription';
          if (!loggedIn && !loggingIn) {
            return '/login';
          }
          if (loggedIn &&
              (state.location == '/login' ||
                  state.location == '/inscription')) {
            return '/dashboard';
          }
          return null;
        },
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) => isLoggedIn ? '/dashboard' : '/login',
          ),
          GoRoute(
            path: '/login',
            name: 'login',
            builder: (context, state) => const LoginScreen(),
          ),
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/courses',
            name: 'courses',
            builder: (context, state) => const CoursesScreen(),
          ),
          GoRoute(
            path: '/course-detail/:id',
            name: 'course-detail',
            builder: (context, state) {
              final course = state.extra as Course;
              return CourseDetailScreen(course: course);
            },
          ),
          GoRoute(
            path: '/nouvelle-course',
            name: 'nouvelle-course',
            builder: (context, state) => const NouvelleCourseScreen(),
          ),
          GoRoute(
            path: '/inscription',
            name: 'inscription',
            builder: (context, state) => const InscriptionScreen(),
          ),
          GoRoute(
            path: '/mission/:id',
            name: 'mission',
            builder: (context, state) {
              final courseId = state.pathParameters['id'] ?? '';
              return MissionScreen(courseId: courseId);
            },
          ),
          GoRoute(
            path: '/fin-mission/:id',
            name: 'fin-mission',
            builder: (context, state) {
              final courseId = state.pathParameters['id'] ?? '';
              return FinMissionScreen(courseId: courseId);
            },
          ),
          GoRoute(
            path: '/suivi/:id',
            name: 'suivi',
            builder: (context, state) {
              final courseId = state.pathParameters['id'] ?? '';
              return SuiviScreen(courseId: courseId);
            },
          ),
          GoRoute(
            path: '/recapitulatif',
            name: 'recapitulatif',
            builder: (context, state) {
              final course = state.extra as Course;
              return RecapitulatifScreen(course: course);
            },
          ),
        ],
      );
}
