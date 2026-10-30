import 'package:todo_gabarito/modules/habits/domain/entities/habit.dart';

class HabitModel extends Habit {
  const HabitModel({
    required super.id,
    required super.name,
    required super.checkins,
  });

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    return HabitModel(
      id: map['id'] as int,
      name: map['name'] as String,
      checkins: map['checkins'],
    );
  }
}
