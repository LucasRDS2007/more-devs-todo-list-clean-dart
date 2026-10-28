import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodosUsecase {
  final TodoRepository repository;
  GetTodosUsecase(this.repository);

  /// Regra de negócio: quando [hideDone] é verdadeiro, esconde as concluídas.
  Future<List<Todo>> call({bool hideDone = false}) async {
    final todos = await repository.getTodos();
    return hideDone ? todos.where((t) => !t.done).toList() : todos;
  }
}
