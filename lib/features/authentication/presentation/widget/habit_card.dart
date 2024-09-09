import 'package:flutter/material.dart';
import 'package:habits/theme/palette/palette.dart';

class HabitCard extends StatelessWidget {
  final String habitId;
  final String habitName;
  final double progress;
  final Color color;
  final DateTime? endDate;
  final ValueChanged<double> onProgressUpdated;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const HabitCard({
    Key? key,
    required this.habitId,
    required this.habitName,
    required this.progress,
    required this.color,
    required this.onProgressUpdated,
    required this.onDelete,
    required this.onEdit,
    this.endDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Palette.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  habitName,
                  style: const TextStyle(
                    color: Palette.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Palette.gray600),
                onPressed: onEdit,
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Palette.red500),
                onPressed: onDelete,
              ),
            ],
          ),
          if (endDate != null) ...[
            const SizedBox(height: 4.0),
            Text(
              'Até ${endDate!.day.toString().padLeft(2, '0')}/${endDate!.month.toString().padLeft(2, '0')}/${endDate!.year}',
              style: const TextStyle(color: Palette.gray600),
            ),
          ],
          const SizedBox(height: 8.0),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Palette.gray200,
            color: color,
            minHeight: 8.0,
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  final updatedProgress = (progress - 0.1).clamp(0.0, 1.0);
                  onProgressUpdated(updatedProgress);
                },
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  final updatedProgress = (progress + 0.1).clamp(0.0, 1.0);
                  onProgressUpdated(updatedProgress);
                },
              ),
              Text(
                '${(progress * 100).toInt()}%',
                style: const TextStyle(color: Palette.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
