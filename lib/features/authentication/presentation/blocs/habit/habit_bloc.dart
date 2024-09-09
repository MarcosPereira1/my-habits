import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/features/authentication/domain/entities/habit_entity.dart';
import 'package:habits/features/authentication/domain/usecases/get_habits_usecase.dart';
import 'package:habits/features/authentication/domain/usecases/save_habit_usecase.dart';
import 'package:habits/features/authentication/domain/usecases/remove_habit_usecase.dart';

part 'habit_event.dart';
part 'habit_state.dart';

class HabitBloc extends Bloc<HabitEvent, HabitState> {
  final GetHabitsUsecase getHabitsUsecase;
  final SaveHabitUsecase saveHabitUsecase;
  final RemoveHabitUsecase removeHabitUsecase;

  HabitBloc({
    required this.getHabitsUsecase,
    required this.saveHabitUsecase,
    required this.removeHabitUsecase,
  }) : super(const HabitInitial()) {
    on<LoadHabits>(_onLoadHabitsHandler);
    on<AddHabit>(_onAddHabitHandler);
    on<UpdateHabit>(_onUpdateHabitHandler);
    on<UpdateHabitProgress>(_onUpdateHabitProgressHandler);
    on<DeleteHabit>(_onDeleteHabitHandler);
    on<RefreshHabits>(_onRefreshHabitsHandler);
  }

  Future<void> _onLoadHabitsHandler(
    LoadHabits event,
    Emitter<HabitState> emit,
  ) async {
    emit(const HabitLoading());

    final result = await getHabitsUsecase();

    result.fold(
      (success) => emit(HabitLoaded(success)),
      (failure) => emit(const HabitFailed()),
    );
  }

  Future<void> _onAddHabitHandler(
    AddHabit event,
    Emitter<HabitState> emit,
  ) async {
    if (state is HabitLoaded) {
      final currentHabits = List<HabitEntity>.from((state as HabitLoaded).habits);

      final newHabit = HabitEntity(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        habitName: event.habitName,
        progress: 0.0,
        endDate: event.endDate,
      );

      final result = await saveHabitUsecase(newHabit);

      result.fold(
        (success) {
          currentHabits.add(newHabit);
          emit(HabitLoaded(currentHabits));
        },
        (failure) => emit(const HabitFailed()),
      );
    }
  }

  Future<void> _onUpdateHabitHandler(
    UpdateHabit event,
    Emitter<HabitState> emit,
  ) async {
    if (state is HabitLoaded) {
      final currentHabits = List<HabitEntity>.from((state as HabitLoaded).habits);

      final index = currentHabits.indexWhere((habit) => habit.id == event.habitId);
      if (index != -1) {
        final updatedHabit = currentHabits[index].copyWith(
          habitName: event.newHabitName,
          endDate: event.newEndDate,
        );
        currentHabits[index] = updatedHabit;

        final result = await saveHabitUsecase(updatedHabit);

        result.fold(
          (success) => emit(HabitLoaded(currentHabits)),
          (failure) => emit(const HabitFailed()),
        );
      }
    }
  }

  Future<void> _onUpdateHabitProgressHandler(
    UpdateHabitProgress event,
    Emitter<HabitState> emit,
  ) async {
    if (state is HabitLoaded) {
      final currentHabits = List<HabitEntity>.from((state as HabitLoaded).habits);

      final index = currentHabits.indexWhere((habit) => habit.id == event.habitId);
      if (index != -1) {
        final updatedHabit = currentHabits[index].copyWith(
          progress: event.progress,
        );

        currentHabits[index] = updatedHabit;

        final result = await saveHabitUsecase(updatedHabit);

        result.fold(
          (success) {
            if (event.progress == 1.0) {
              emit(HabitCompleted(currentHabits, habitName: updatedHabit.habitName));
            } else {
              emit(HabitLoaded(currentHabits));
            }
          },
          (failure) => emit(const HabitFailed()),
        );
      }
    }
  }

  Future<void> _onDeleteHabitHandler(
    DeleteHabit event,
    Emitter<HabitState> emit,
  ) async {
    if (state is HabitLoaded) {
      final currentHabits = List<HabitEntity>.from((state as HabitLoaded).habits);

      currentHabits.removeWhere((habit) => habit.id == event.habitId);

      final result = await removeHabitUsecase(event.habitId);

      result.fold(
        (success) => emit(HabitLoaded(currentHabits)),
        (failure) => emit(const HabitFailed()),
      );
    }
  }

  Future<void> _onRefreshHabitsHandler(
    RefreshHabits event,
    Emitter<HabitState> emit,
  ) async {
    emit(const HabitLoading());

    final result = await getHabitsUsecase();

    result.fold(
      (success) => emit(HabitLoaded(success)),
      (failure) => emit(const HabitFailed()),
    );
  }
}
