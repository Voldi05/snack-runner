# SnackRunner

A Flutter-based delivery and task management application that connects delivery runners with customers for quick pickup and delivery services.

## Project Overview

SnackRunner is a mobile application designed to manage delivery jobs and track their status. Users can request deliveries, accept delivery jobs, and monitor their completion in real-time.

## Features

### Core Functionality
- **User Authentication** - Secure login system for runners and requesters
- **Course Management** - Create, browse, and manage delivery tasks
- **Real-time Tracking** - Monitor delivery progress and status
- **Task Status Tracking** - Track deliveries through multiple states (Pending, Accepted, In Delivery, Completed)
- **Reward System** - Incentivize completed deliveries with rewards

### Screens

| Screen | Purpose |
|--------|---------|
| `LoginScreen` | User authentication |
| `DashboardScreen` | Main application hub |
| `CoursesScreen` | Browse available delivery tasks |
| `CourseDetailScreen` | View detailed information about a specific delivery |
| `NouvelleCourseScreen` | Create a new delivery request |
| `InscriptionScreen` | User registration/enrollment |
| `MissionScreen` | View assigned missions/tasks |
| `FinMissionScreen` | Complete and finalize a delivery |
| `SuiviScreen` | Track delivery progress |
| `RecapitulatifScreen` | Summary and recap of activities |

## Technical Stack

- **Framework**: Flutter 3.9.0+
- **Language**: Dart
- **UI**: Material Design 3
- **Theme**: Custom green theme (Primary color: #1A6B4A)

## Project Structure

```
lib/
├── main.dart                 # Application entry point
├── data/
│   └── app_data.dart         # Application data management
├── models/
│   └── course.dart           # Course/delivery task model
├── screens/                  # UI screens
│   ├── login_screen.dart
│   ├── dashboard_screen.dart
│   ├── courses_screen.dart
│   ├── course_detail_screen.dart
│   ├── nouvelle_course_screen.dart
│   ├── inscription_screen.dart
│   ├── mission_screen.dart
│   ├── fin_mission_screen.dart
│   ├── suivi_screen.dart
│   └── recapitulatif_screen.dart
└── widgets/
    └── course_card.dart      # Reusable course card widget
```

## Delivery Status States

- **En attente** (Waiting) - Delivery request created, waiting for acceptance
- **Acceptée** (Accepted) - Runner has accepted the delivery
- **Livraison** (Delivering) - Delivery is in progress
- **Terminée** (Completed) - Delivery has been completed

## Getting Started

### Prerequisites
- Flutter SDK 3.9.0 or higher
- Dart SDK
- Android SDK or iOS development tools

### Installation

1. Clone the repository
```bash
git clone <repository-url>
cd snack-runner
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the application
```bash
flutter run
```

## Dependencies

- `flutter` - Core Flutter framework
- `cupertino_icons` - iOS-style icons
- `flutter_lints` - Code linting rules

## Build Information

- **Version**: 1.0.0
- **Build Number**: 1
- **Minimum SDK**: Dart 3.9.0

## Resources

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Material Design 3](https://m3.material.io/)
