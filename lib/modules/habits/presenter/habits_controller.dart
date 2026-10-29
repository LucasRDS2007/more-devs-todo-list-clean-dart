import 'package:flutter/material.dart';
import 'package:todo_gabarito/modules/habits/domain/entities/habit.dart';
import 'package:todo_gabarito/modules/habits/domain/errors/habit_failure.dart';
import 'package:todo_gabarito/modules/habits/domain/usecases/checkin_habit_usecase.dart';
import 'package:todo_gabarito/modules/habits/domain/usecases/get_habits_usecase.dart';

class HabitController extends ChangeNotifier {
  HabitController({
    required this.getHabits,
    required this.checkinHabitsUsecase,
  });
  final GetHabitsUsecase getHabits;
  final CheckinHabitsUsecase checkinHabitsUsecase;

  List<Habit> habits = [];
  bool loading = false;
  String? error;
  Habit? updatedHabit;

  void load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      habits = await getHabits();
    } on HabitFailure catch (f) {
      error = f.message;
    }
    loading = false;
    notifyListeners();
  }

  void checkIn(Habit habit) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      checkinHabitsUsecase(habit);
    } on HabitFailure catch (f) {
      error = f.message;
    }
    loading = false;
    notifyListeners();
  }
}
