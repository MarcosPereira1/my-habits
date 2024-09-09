part of 'habit_bloc.dart';

abstract class HabitEvent {
  const HabitEvent();
}

class LoadHabits extends HabitEvent {
  const LoadHabits();
}

class AddHabit extends HabitEvent {
  final String habitName;
  final DateTime? endDate;

  const AddHabit(this.habitName, this.endDate);
}

class UpdateHabit extends HabitEvent {
  final String habitId;
  final String newHabitName;
  final DateTime? newEndDate;

  const UpdateHabit(this.habitId, this.newHabitName, this.newEndDate);
}

class UpdateHabitProgress extends HabitEvent {
  final String habitId;
  final double progress;

  const UpdateHabitProgress(this.habitId, this.progress);
}

class DeleteHabit extends HabitEvent {
  final String habitId;

  const DeleteHabit(this.habitId);
}

class RefreshHabits extends HabitEvent {
  const RefreshHabits();
}
