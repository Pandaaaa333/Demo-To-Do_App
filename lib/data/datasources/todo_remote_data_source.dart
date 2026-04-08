import '../models/todo_model.dart';
import 'todo_data_source.dart';

class TodoRemoteDataSourceImpl implements TodoDataSource {
  // Fake in-memory list to simulate a database.
  final List<TodoModel> _todos = [
    TodoModel(
      id: 'remote-1',
      title: 'Học Clean Architecture Slide 1 đến 10',
      isCompleted: false,
    ),
    TodoModel(
      id: 'remote-2',
      title: 'Thuyết trình nhóm 12 Demo get_it',
      isCompleted: false,
    ),
  ];

  @override
  Future<List<TodoModel>> getTodos() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    return List.from(_todos); // Return a copy
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _todos.add(todo);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    } else {
      throw Exception('Todo not found on remote server');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _todos.removeWhere((t) => t.id == id);
  }
}
