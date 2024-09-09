import 'package:habits/core/exceptions/base_exception.dart';
import 'package:habits/features/authentication/domain/entities/habit_entity.dart';
import 'package:result_dart/result_dart.dart';


abstract interface class HabitRepository {
  const HabitRepository();

  Future<Result<List<HabitEntity>, BaseException>> getHabits();
  Future<Result<void, BaseException>> saveHabit(HabitEntity habit);
  Future<Result<void, BaseException>> removeHabit(String habitName);
}
