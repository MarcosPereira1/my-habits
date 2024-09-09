import 'package:equatable/equatable.dart';

class HabitEntity extends Equatable {
  final String id;
  final String habitName;
  final double progress;
  final DateTime? endDate;

  const HabitEntity({
    required this.id,
    required this.habitName,
    required this.progress,
    this.endDate,
  });

  HabitEntity copyWith({
    String? id,
    String? habitName,
    double? progress,
    DateTime? endDate,
  }) {
    return HabitEntity(
      id: id ?? this.id,
      habitName: habitName ?? this.habitName,
      progress: progress ?? this.progress,
      endDate: endDate ?? this.endDate,
    );
  }

  @override
  List<Object?> get props => [id, habitName, progress, endDate];
}
