import 'package:todo_gabarito/modules/habits/domain/entities/habit.dart';

class HabitModel extends Habit {
  const HabitModel({
    required super.id,
    required super.name,
    required super.checkins,
  });

  factory HabitModel.fromMap(Map<String, dynamic> map) {
    for (var element in map['checkins']) {
      print(element);
    }

    return HabitModel(
      id: map['id'] as int,
      name: map['name'] as String,
      checkins: map['checkins'],
    );
  }
}
