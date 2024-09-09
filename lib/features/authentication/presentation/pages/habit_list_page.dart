import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/features/authentication/domain/entities/habit_entity.dart';
import 'package:habits/features/authentication/presentation/pages/history_page.dart';
import 'package:habits/features/authentication/presentation/widget/add_habit_modal.dart';
import 'package:habits/features/authentication/presentation/widget/habit_error_view.dart';
import 'package:habits/features/authentication/presentation/widget/habit_list_view.dart';
import 'package:habits/theme/palette/palette.dart';
import 'package:habits/features/authentication/presentation/blocs/habit/habit_bloc.dart';

class HabitListPage extends StatelessWidget {
  const HabitListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<HabitBloc>().add(const LoadHabits());

    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        title: const Text('Meus Hábitos'),
        backgroundColor: Palette.yellow500,
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              final state = context.read<HabitBloc>().state;
              if (state is HabitLoaded) {
                _navigateToHistoryPage(
                  context,
                  state.habits.where((habit) => habit.progress == 1.0).toList(),
                  state.habits,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Hábitos não carregados ainda')),
                );
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<HabitBloc, HabitState>(
        listener: (context, state) {
          if (state is HabitCompleted) {
            _showRewardDialog(context, state.habitName);
          }
        },
        builder: (context, state) {
          if (state is HabitLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HabitFailed) {
            return HabitErrorView(onRetry: () {
              context.read<HabitBloc>().add(const LoadHabits());
            });
          } else if (state is HabitLoaded) {
            final habits = state.habits.where((habit) => habit.progress < 1.0).toList();
            return HabitListView(
              habits: habits,
              onEditHabit: (habit) => _showAddHabitModal(context, habitToEdit: habit), // Passando o método como callback
            );
          } else {
            return const Center(child: Text('Ocorreu um erro desconhecido.'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Palette.yellow500,
        onPressed: () {
          _showAddHabitModal(context);
        },
        child: const Icon(Icons.add, color: Palette.white),
      ),
    );
  }

  void _showRewardDialog(BuildContext context, String habitName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
          title: const Text('Parabéns!'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Você completou o hábito!',
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Icon(Icons.emoji_events, color: Palette.yellow500, size: 64),
              SizedBox(height: 20),
              Text(
                'Continue assim e conquiste ainda mais!',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK', style: TextStyle(color: Palette.yellow500)),
            ),
          ],
        );
      },
    );
  }

  void _navigateToHistoryPage(BuildContext context, List<HabitEntity> completedHabits, List<HabitEntity> trophyHabits) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HistoryPage(
          completedHabits: completedHabits.map((habit) => habit.habitName).toList(),
          trophyHabits: trophyHabits.map((habit) => habit.habitName).toList(),
        ),
      ),
    );
  }

  void _showAddHabitModal(BuildContext context, {HabitEntity? habitToEdit}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      builder: (context) => AddHabitModal(habitToEdit: habitToEdit),
    );
  }
}
