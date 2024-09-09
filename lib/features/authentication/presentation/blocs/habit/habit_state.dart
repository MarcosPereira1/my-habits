part of 'habit_bloc.dart';

abstract class HabitState {
  const HabitState();
}

class HabitInitial extends HabitState {
  const HabitInitial();
}

class HabitLoading extends HabitState {
  const HabitLoading();
}

class HabitLoaded extends HabitState {
  final List<HabitEntity> habits;

  const HabitLoaded(this.habits);
}

class HabitCompleted extends HabitLoaded {
  final String habitName;

  const HabitCompleted(List<HabitEntity> habits, {required this.habitName}) : super(habits);
}

class HabitFailed extends HabitState {
  const HabitFailed();
}
