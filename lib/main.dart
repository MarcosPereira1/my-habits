import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habits/features/authentication/data/repository/habit_repository_impl.dart';
import 'package:habits/features/authentication/domain/usecases/get_habits_usecase.dart';
import 'package:habits/features/authentication/domain/usecases/remove_habit_usecase.dart';
import 'package:habits/features/authentication/domain/usecases/save_habit_usecase.dart';
import 'package:habits/features/authentication/presentation/blocs/habit/habit_bloc.dart';
import 'package:habits/features/authentication/presentation/pages/habit_list_page.dart';
import 'package:habits/theme/palette/palette.dart';
import 'package:habits/theme/typography/typography.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const habitRepository = HabitRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HabitBloc(
            getHabitsUsecase: const GetHabitsUsecase(repository: habitRepository),
            saveHabitUsecase: const SaveHabitUsecase(repository: habitRepository),
            removeHabitUsecase: const RemoveHabitUsecase(repository: habitRepository),
          )..add(const LoadHabits()),
        ),
      ],
      child: MaterialApp(
        title: 'Fundo escuro',
        theme: ThemeData(
          primaryColor: Palette.yellow500,
          fontFamily: 'Inter',
          textTheme: const TextTheme(
            displayLarge: AppTextStyles.title,
            displayMedium: AppTextStyles.subtitle,
            bodyLarge: AppTextStyles.bodyText,
          ),
        ),
        home: const HabitListPage(),
      ),
    );
  }
}
