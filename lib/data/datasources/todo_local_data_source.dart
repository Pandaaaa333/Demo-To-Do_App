import 'package:hive/hive.dart';
import '../models/todo_model.dart';
import 'todo_data_source.dart';

class TodoLocalDataSourceImpl implements TodoDataSource {
  final Box<TodoModel> todoBox;

  TodoLocalDataSourceImpl(this.todoBox);

  @override
  Future<List<TodoModel>> getTodos() async {
    try {
      return todoBox.values.toList();
    } catch (e) {
      throw Exception('Failed to get todos: $e');
    }
  }

  @override
  Future<void> addTodo(TodoModel todo) async {
    try {
      await todoBox.put(todo.id, todo);
    } catch (e) {
      throw Exception('Failed to add todo: $e');
    }
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    try {
      if (!todoBox.containsKey(todo.id)) {
        throw Exception('Todo not found');
      }
      await todoBox.put(todo.id, todo);
    } catch (e) {
      throw Exception('Failed to update todo: $e');
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      await todoBox.delete(id);
    } catch (e) {
      throw Exception('Failed to delete todo: $e');
    }
  }
}
