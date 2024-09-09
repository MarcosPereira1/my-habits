import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/features/authentication/domain/entities/habit_entity.dart';
import 'package:habits/theme/palette/palette.dart';
import 'package:habits/features/authentication/presentation/blocs/habit/habit_bloc.dart';

class AddHabitModal extends StatefulWidget {
  final HabitEntity? habitToEdit;

  const AddHabitModal({Key? key, this.habitToEdit}) : super(key: key);

  @override
  AddHabitModalState createState() => AddHabitModalState();
}

class AddHabitModalState extends State<AddHabitModal> {
  late TextEditingController habitController;
  DateTime? selectedEndDate;

  @override
  void initState() {
    super.initState();
    habitController = TextEditingController(text: widget.habitToEdit?.habitName ?? '');
    selectedEndDate = widget.habitToEdit?.endDate;
  }

  @override
  void dispose() {
    habitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 16.0,
        right: 16.0,
        top: 16.0,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.habitToEdit == null ? 'Adicionar Novo Hábito' : 'Editar Hábito',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Palette.black,
            ),
          ),
          const SizedBox(height: 16.0),
          TextField(
            controller: habitController,
            decoration: InputDecoration(
              hintText: "Nome do Hábito",
              filled: true,
              fillColor: Palette.gray300,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 16.0),
          ListTile(
            title: const Text("Data de Conclusão"),
            subtitle: Text(
              selectedEndDate == null
                  ? "Nenhuma data selecionada"
                  : "${selectedEndDate!.day.toString().padLeft(2, '0')}/${selectedEndDate!.month.toString().padLeft(2, '0')}/${selectedEndDate!.year}",
            ),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: () async {
                final DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2100),
                );
                if (pickedDate != null) {
                  setState(() {
                    selectedEndDate = pickedDate;
                  });
                }
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Palette.yellow500,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            onPressed: () {
              final habitName = habitController.text;
              if (habitName.isNotEmpty) {
                final state = context.read<HabitBloc>().state;
                if (state is HabitLoaded) {
                  final existingHabits = state.habits;

                  final habitExists = existingHabits.any(
                    (habit) => habit.habitName.toLowerCase() == habitName.toLowerCase(),
                  );

                  if (!habitExists || widget.habitToEdit != null) {
                    if (widget.habitToEdit != null) {
                      context.read<HabitBloc>().add(UpdateHabit(
                            widget.habitToEdit!.id,
                            habitName,
                            selectedEndDate,
                          ));
                    } else {
                      context.read<HabitBloc>().add(AddHabit(habitName, selectedEndDate));
                    }
                    Navigator.of(context).pop();
                    context.read<HabitBloc>().add(const RefreshHabits());
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Hábito já existe!'),
                      ),
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Não foi possível carregar os hábitos.'),
                    ),
                  );
                }
              }
            },
            child: Center(
              child: Text(
                widget.habitToEdit == null ? 'Adicionar Hábito' : 'Salvar Alterações',
                style: const TextStyle(
                  color: Palette.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }
}
