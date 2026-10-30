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
  bool loadingHabits = false;
  String? error;
  Habit? updatedHabit;

  List<String> checkingInId = [];

  void load() async {
    loadingHabits = true;
    error = null;
    notifyListeners();
    try {
      habits = await getHabits();
    } on HabitFailure catch (f) {
      error = f.message;
    }
    loadingHabits = false;
    notifyListeners();
  }

  addCheckingId(String id) {
    checkingInId.add(id);
  }

  removeCheckingId(String id) {
    checkingInId.remove(id);
  }

  void checkIn(Habit habit) async {
    addCheckingId(habit.id.toString());
    error = null;
    notifyListeners();
    try {
      updatedHabit = await checkinHabitsUsecase(habit);
      final index = habits.indexWhere((h) => h.id == updatedHabit!.id);
      if (index != -1) {
        habits[index] = updatedHabit!;
      }
    } on HabitFailure catch (f) {
      error = f.message;
    } finally {
      removeCheckingId(habit.id.toString());
      notifyListeners();
    }

    notifyListeners();
  }
}
