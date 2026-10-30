import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_gabarito/modules/habits/domain/usecases/checkin_habit_usecase.dart';
import 'package:todo_gabarito/modules/habits/domain/usecases/get_habits_usecase.dart';
import 'package:todo_gabarito/modules/habits/external/datasources/habit_api_datasource.dart';
import 'package:todo_gabarito/modules/habits/infra/datasources/habit_data_source.dart';
import 'package:todo_gabarito/modules/habits/infra/repositories/habit_repository_impl.dart';
import 'package:todo_gabarito/modules/habits/presenter/habits_controller.dart';
import 'package:todo_gabarito/modules/todos/domain/usecases/get_todos_usecase.dart';
import 'package:todo_gabarito/modules/todos/domain/usecases/update_todos_usecase.dart';

import 'modules/habits/presenter/habits_page.dart';
import 'modules/todos/external/datasources/todo_api_datasource.dart';
import 'modules/todos/infra/datasources/todo_datasource.dart';
import 'modules/todos/infra/repositories/todo_repository_impl.dart';
import 'modules/todos/presenter/todos_controller.dart';
import 'modules/todos/presenter/todos_page.dart';

/// Único lugar que sabe quais implementações usar.
void main() {
  final Dio dio = Dio(
      BaseOptions(baseUrl: 'https://todo-api-production-62d2.up.railway.app'));

  final TodoDatasource todoDatasource = TodoApiDatasource(dio);
  final todoRepository = TodoRepositoryImpl(todoDatasource);
  final todoController = TodosController(
    updateTodosUseCase: UpdateTodoUsecase(repository: todoRepository),
    getTodos: GetTodosUsecase(todoRepository),
  )..load();

  final HabitDatasource habitDatasource = HabitApiDatasource(dio);
  final habitRepository = HabitRepositoryImpl(habitDatasource);
  final habitController = HabitController(
    checkinHabitsUsecase: CheckinHabitsUsecase(habitRepository),
    getHabits: GetHabitsUsecase(habitRepository),
  )..load();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => todoController,
      ),
      ChangeNotifierProvider(
        create: (context) => habitController,
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF315CFF)),
      ),
      home: HomeShell(
        pages: [
          TodosPage(controller: todoController),
          HabitsPage(
            controller: habitController,
          ),
        ],
      ),
    ),
  ));
}

class HomeShell extends StatefulWidget {
  const HomeShell({super.key, required this.pages});

  final List<Widget> pages;

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: widget.pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.checklist_rounded),
            label: 'Tarefas',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_fire_department_rounded),
            label: 'Hábitos',
          ),
        ],
      ),
    );
  }
}
