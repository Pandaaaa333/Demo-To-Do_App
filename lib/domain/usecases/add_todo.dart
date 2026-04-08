import 'package:fpdart/fpdart.dart';
import '../../core/error/failures.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class AddTodo {
  final TodoRepository repository;

  AddTodo(this.repository);

  Future<Either<Failure, void>> call(Todo todo) async {
    return await repository.addTodo(todo);
  }
}
