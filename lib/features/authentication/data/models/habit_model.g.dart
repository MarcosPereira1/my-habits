// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HabitModel _$HabitModelFromJson(Map<String, dynamic> json) => HabitModel(
      id: json['id'] as String?,
      habitName: json['habitName'] as String,
      progress: (json['progress'] as num).toDouble(),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$HabitModelToJson(HabitModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'habitName': instance.habitName,
      'progress': instance.progress,
      'endDate': instance.endDate?.toIso8601String(),
    };
