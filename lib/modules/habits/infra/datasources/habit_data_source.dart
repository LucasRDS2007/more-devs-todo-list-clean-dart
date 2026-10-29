import 'package:todo_gabarito/modules/habits/domain/entities/habit.dart';

abstract interface class HabitDatasource {
  Future<List<Map<String, dynamic>>> fetchHabits();
  Future<Map<String, dynamic>> updateHabits(Habit habit);
}
