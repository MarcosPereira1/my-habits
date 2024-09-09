import 'package:habits/core/exceptions/base_exception.dart';
import 'package:habits/features/authentication/domain/entities/habit_entity.dart';
import 'package:habits/features/authentication/domain/repository/habit_repository.dart';
import 'package:result_dart/result_dart.dart';

final class SaveHabitUsecase {
  const SaveHabitUsecase({required this.repository});

  final HabitRepository repository;

  Future<Result<void, BaseException>> call(HabitEntity habit) async {
    return await repository.saveHabit(habit);
  }
}
