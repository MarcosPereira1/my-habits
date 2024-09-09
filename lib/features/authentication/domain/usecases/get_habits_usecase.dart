import 'package:habits/core/exceptions/base_exception.dart';
import 'package:habits/features/authentication/domain/entities/habit_entity.dart';
import 'package:habits/features/authentication/domain/repository/habit_repository.dart';
import 'package:result_dart/result_dart.dart';

final class GetHabitsUsecase {
  const GetHabitsUsecase({required this.repository});

  final HabitRepository repository;

  Future<Result<List<HabitEntity>, BaseException>> call() async {
    return await repository.getHabits();
  }
}
