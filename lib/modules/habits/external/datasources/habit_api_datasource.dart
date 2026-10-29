import 'package:dio/dio.dart';
import 'package:todo_gabarito/modules/habits/domain/entities/habit.dart';
import 'package:todo_gabarito/modules/habits/infra/datasources/habit_data_source.dart';

/// Única classe do app que conhece o Dio.
class HabitApiDatasource implements HabitDatasource {
  final Dio dio;
  HabitApiDatasource(this.dio);

  @override
  Future<List<Map<String, dynamic>>> fetchHabits() async {
    final res = await dio.get<List<dynamic>>('/habits');
    return res.data!.cast<Map<String, dynamic>>();
  }

  @override
  Future<Map<String, dynamic>> updateHabits(Habit habit) async {
    final res = await dio.post(
      '/habits/${habit.id}/chekins',
    );

    return res.data as Map<String, dynamic>;
  }
}
