import 'package:habits/core/exceptions/unknown_exception.dart';
import 'package:habits/features/authentication/data/models/habit_model.dart';
import 'package:habits/features/authentication/domain/entities/habit_entity.dart';
import 'package:habits/features/authentication/domain/repository/habit_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:habits/core/exceptions/base_exception.dart';
import 'package:result_dart/result_dart.dart';
import 'dart:convert';

class HabitRepositoryImpl implements HabitRepository {
  const HabitRepositoryImpl();

  @override
  Future<Result<List<HabitEntity>, BaseException>> getHabits() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> savedHabits = prefs.getStringList('habits') ?? [];

      final habits = savedHabits.map((habitJson) {
        try {
          final habitModel = HabitModel.fromJson(jsonDecode(habitJson) as Map<String, dynamic>);
          return habitModel;
        } catch (e) {
          return null;
        }
      }).whereType<HabitModel>().toList();

      return Success(habits);
    } catch (e, s) {
      return Failure(UnknownException(error: e.toString(), stackTrace: s));
    }
  }

  @override
  Future<Result<void, BaseException>> saveHabit(HabitEntity habit) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> savedHabits = prefs.getStringList('habits') ?? [];

      final habitModel = HabitModel(
        id: habit.id,
        habitName: habit.habitName,
        progress: habit.progress,
        endDate: habit.endDate,
      );

      final existingHabitIndex = savedHabits.indexWhere((habitJson) {
        final habitModelExisting = HabitModel.fromJson(jsonDecode(habitJson));
        return habitModelExisting.id == habit.id;
      });

      if (existingHabitIndex != -1) {
        savedHabits[existingHabitIndex] = jsonEncode(habitModel.toJson());
      } else {
        savedHabits.add(jsonEncode(habitModel.toJson()));
      }

      await prefs.setStringList('habits', savedHabits);

      return const Success(Object());
    } catch (e, s) {
      return Failure(UnknownException(error: e.toString(), stackTrace: s));
    }
  }

  @override
  Future<Result<void, BaseException>> removeHabit(String habitId) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String> savedHabits = prefs.getStringList('habits') ?? [];

      savedHabits.removeWhere((habitJson) {
        final habitModel = HabitModel.fromJson(jsonDecode(habitJson));
        return habitModel.id == habitId;
      });

      await prefs.setStringList('habits', savedHabits);


      return const Success(Object());
    } catch (e, s) {
      return Failure(UnknownException(error: e.toString(), stackTrace: s));
    }
  }
}
