import 'package:flutter/foundation.dart';
import 'package:todo_gabarito/main.dart';
import 'package:todo_gabarito/modules/todos/domain/usecases/update_todos_usecase.dart';

import '../domain/entities/todo.dart';
import '../domain/errors/todo_failure.dart';
import '../domain/usecases/get_todos_usecase.dart';

class TodosController extends ChangeNotifier {
  TodosController({required this.getTodos, required this.updateTodosUseCase});

  final GetTodosUsecase getTodos;
  final UpdateTodoUsecase updateTodosUseCase;

  List<Todo> todos = [];
  bool loading = false;
  String? error;
  bool hideDone = false;
  Todo? updatedTodo;

  void load() async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      todos = await getTodos(hideDone: hideDone);
    } on TodoFailure catch (f) {
      error = f.message;
    }
    loading = false;
    notifyListeners();
  }

  void toggleHideDone() {
    hideDone = !hideDone;
    load();
  }

  Future<void> updateTodo(Todo todo) async {
    loading = true;
    error = null;
    notifyListeners();
    try {
      updatedTodo = await updateTodosUseCase(todo);
    } on TodoFailure catch (f) {
      error = f.message;
    }
    loading = false;
    notifyListeners();
  }
}
