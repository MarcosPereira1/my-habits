import 'package:habits/core/exceptions/base_exception.dart';
import 'package:habits/features/authentication/domain/repository/habit_repository.dart';
import 'package:result_dart/result_dart.dart';

final class RemoveHabitUsecase {
  const RemoveHabitUsecase({required this.repository});

  final HabitRepository repository;

  Future<Result<void, BaseException>> call(String habitName) async {
    return await repository.removeHabit(habitName);
  }
}
