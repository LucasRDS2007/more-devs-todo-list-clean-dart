import 'package:todo_gabarito/modules/habits/domain/entities/habit.dart';
import 'package:todo_gabarito/modules/habits/domain/errors/habit_failure.dart';
import 'package:todo_gabarito/modules/habits/domain/repositories/habit_repository.dart';
import 'package:todo_gabarito/modules/habits/infra/datasources/habit_data_source.dart';
import 'package:todo_gabarito/modules/habits/infra/models/habit_model.dart';

class HabitRepositoryImpl implements HabitRepository {
  final HabitDatasource datasource;
  HabitRepositoryImpl(this.datasource);

  @override
  Future<List<Habit>> getHabits() async {
    try {
      final maps = await datasource.fetchHabits();
      return maps.map(HabitModel.fromMap).toList();
    } catch (_) {
      throw const HabitFailure('Não foi possível carregar os habitos');
    }
  }

  @override
  void checkinHabit(Habit habit) async {
    try {
      await datasource.updateHabits(habit);
    } catch (_) {
      throw const HabitFailure('Não foi possível atualizar o habito');
    }
  }
}
