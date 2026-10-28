import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_gabarito/modules/todos/domain/usecases/update_todos_usecase.dart';
import 'modules/todos/domain/usecases/get_todos_usecase.dart';
import 'modules/todos/external/datasources/todo_api_datasource.dart';
import 'modules/todos/infra/datasources/todo_datasource.dart';
import 'modules/todos/infra/repositories/todo_repository_impl.dart';
import 'modules/todos/presenter/todos_controller.dart';
import 'modules/todos/presenter/todos_page.dart';

void main() {
  final TodoDatasource datasource = TodoApiDatasource(
    Dio(BaseOptions(
        baseUrl: 'https://todo-api-production-62d2.up.railway.app')),
  );
  final repository = TodoRepositoryImpl(datasource);
  final controller = TodosController(
      getTodos: GetTodosUsecase(repository),
      updateTodosUseCase: UpdateTodoUsecase(repository: repository))
    ..load();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<TodosController>.value(
        value: controller,
      )
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodosPage(controller: controller),
    ),
  ));
}
