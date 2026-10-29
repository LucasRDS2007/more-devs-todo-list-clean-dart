import 'package:todo_gabarito/modules/habits/domain/entities/habit.dart';
import 'package:todo_gabarito/modules/habits/domain/repositories/habit_repository.dart';

class CheckinHabitsUsecase {
  final HabitRepository repository;
  CheckinHabitsUsecase(this.repository);

  Future<Habit> call(Habit habit) async {
    final updatedHabit = await repository.checkinHabit(habit);
    return updatedHabit;
  }
}
