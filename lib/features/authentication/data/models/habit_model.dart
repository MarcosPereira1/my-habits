import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:habits/features/authentication/domain/entities/habit_entity.dart';

part 'habit_model.g.dart';

@JsonSerializable()
class HabitModel extends HabitEntity {
  static const _uuid = Uuid();

  HabitModel({
    String? id,
    required String habitName,
    required double progress,
    DateTime? endDate,
  }) : super(
          id: id ?? _uuid.v4(),
          habitName: habitName,
          progress: progress,
          endDate: endDate,
        );

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return _$HabitModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$HabitModelToJson(this);
}
