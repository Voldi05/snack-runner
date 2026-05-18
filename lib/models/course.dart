import 'package:flutter/material.dart';
import 'package:snack_runner/theme/app_colors.dart';

enum CourseStatus {
  enAttente,
  acceptee,
  livraison,
  terminee;

  bool canTransitionTo(CourseStatus next) {
    const allowed = {
      CourseStatus.enAttente: [CourseStatus.acceptee],
      CourseStatus.acceptee: [CourseStatus.livraison],
      CourseStatus.livraison: [CourseStatus.terminee],
      CourseStatus.terminee: [],
    };
    return allowed[this]!.contains(next);
  }

  String get label => switch (this) {
    CourseStatus.enAttente => 'En attente',
    CourseStatus.acceptee => 'Acceptée',
    CourseStatus.livraison => 'Livraison',
    CourseStatus.terminee => 'Terminée',
  };
}

extension CourseStatusX on CourseStatus {
  Color get badgeBackground {
    switch (this) {
      case CourseStatus.enAttente:
        return AppColors.statusWaitingBg;
      case CourseStatus.acceptee:
        return AppColors.statusAcceptedBg;
      case CourseStatus.livraison:
        return AppColors.statusDeliveringBg;
      case CourseStatus.terminee:
        return AppColors.statusCompletedBg;
    }
  }

  Color get badgeText {
    switch (this) {
      case CourseStatus.enAttente:
        return AppColors.statusWaitingText;
      case CourseStatus.acceptee:
        return AppColors.statusAcceptedText;
      case CourseStatus.livraison:
        return AppColors.statusDeliveringText;
      case CourseStatus.terminee:
        return AppColors.statusCompletedText;
    }
  }
}

class Course {
  final String id;
  final String category;
  final String title;
  final String pickupLocation;
  final String deliveryLocation;
  final double reward;
  final String rewardType;
  final CourseStatus status;
  final String requesterName;
  final String runnerName;

  const Course({
    required this.id,
    required this.category,
    required this.title,
    required this.pickupLocation,
    required this.deliveryLocation,
    required this.reward,
    required this.rewardType,
    required this.status,
    required this.requesterName,
    required this.runnerName,
  });

  String get rewardLabel {
    if (rewardType == 'Argent') {
      return '${reward.toInt()} FCFA';
    }
    return rewardType;
  }

  Course copyWith({
    String? id,
    String? category,
    String? title,
    String? pickupLocation,
    String? deliveryLocation,
    double? reward,
    String? rewardType,
    CourseStatus? status,
    String? requesterName,
    String? runnerName,
  }) {
    return Course(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      deliveryLocation: deliveryLocation ?? this.deliveryLocation,
      reward: reward ?? this.reward,
      rewardType: rewardType ?? this.rewardType,
      status: status ?? this.status,
      requesterName: requesterName ?? this.requesterName,
      runnerName: runnerName ?? this.runnerName,
    );
  }
}
