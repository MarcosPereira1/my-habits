import 'package:flutter/material.dart';
import 'package:habits/theme/palette/palette.dart';

class HistoryPage extends StatelessWidget {
  final List<String> completedHabits;
  final List<String> trophyHabits;

  const HistoryPage({
    Key? key,
    required this.completedHabits,
    required this.trophyHabits,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico de Hábitos'),
        backgroundColor: Palette.yellow500,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: completedHabits.isEmpty
            ? const Center(
                child: Text(
                  'Nenhum hábito concluído ainda!',
                  style: TextStyle(color: Palette.black, fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: completedHabits.length,
                itemBuilder: (context, index) {
                  final habit = completedHabits[index];
                  return ListTile(
                    title: Text(
                      habit,
                      style: const TextStyle(
                        color: Palette.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: trophyHabits.contains(habit)
                        ? const Icon(Icons.emoji_events, color: Palette.yellow500)
                        : null,
                  );
                },
              ),
      ),
    );
  }
}
