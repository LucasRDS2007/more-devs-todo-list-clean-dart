import 'package:todo_gabarito/modules/habits/domain/entities/habit.dart';
import 'package:todo_gabarito/modules/habits/domain/repositories/habit_repository.dart';

class GetHabitsUsecase {
  final HabitRepository repository;
  GetHabitsUsecase(this.repository);

  Future<List<Habit>> call() async {
    final habits = await repository.getHabits();
    return habits;
  }
}
