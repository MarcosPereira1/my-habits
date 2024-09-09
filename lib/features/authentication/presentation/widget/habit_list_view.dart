import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/features/authentication/domain/entities/habit_entity.dart';
import 'package:habits/features/authentication/presentation/blocs/habit/habit_bloc.dart';
import 'package:habits/theme/palette/palette.dart';
import 'habit_card.dart';

class HabitListView extends StatelessWidget {
  final List<HabitEntity> habits;
  final void Function(HabitEntity habit) onEditHabit;

  const HabitListView({
    Key? key,
    required this.habits,
    required this.onEditHabit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HabitBloc>().add(const RefreshHabits());
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: habits.isEmpty
            ? const Center(
                child: Text(
                  'Adicione seu primeiro hábito!',
                  style: TextStyle(color: Palette.black, fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return HabitCard(
                    habitId: habit.id,
                    habitName: habit.habitName,
                    progress: habit.progress,
                    color: Palette.blue500,
                    endDate: habit.endDate,
                    onProgressUpdated: (newProgress) {
                      context.read<HabitBloc>().add(UpdateHabitProgress(habit.id, newProgress));
                    },
                    onDelete: () {
                      context.read<HabitBloc>().add(DeleteHabit(habit.id));
                      context.read<HabitBloc>().add(const RefreshHabits());
                    },
                    onEdit: () {
                      onEditHabit(habit); // Chamando o callback
                    },
                  );
                },
              ),
      ),
    );
  }
}
