import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/add_todo.dart';
import '../../../domain/usecases/delete_todo.dart';
import '../../../domain/usecases/get_todos.dart';
import '../../../domain/usecases/update_todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final AddTodo addTodo;
  final UpdateTodo updateTodo;
  final DeleteTodo deleteTodo;

  TodoBloc({
    required this.getTodos,
    required this.addTodo,
    required this.updateTodo,
    required this.deleteTodo,
  }) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodoEvent>(_onAddTodo);
    on<UpdateTodoEvent>(_onUpdateTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    final failureOrTodos = await getTodos();
    failureOrTodos.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos)),
    );
  }

  Future<void> _onAddTodo(AddTodoEvent event, Emitter<TodoState> emit) async {
    final failureOrSuccess = await addTodo(event.todo);
    failureOrSuccess.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(LoadTodos()),
    );
  }

  Future<void> _onUpdateTodo(UpdateTodoEvent event, Emitter<TodoState> emit) async {
    final failureOrSuccess = await updateTodo(event.todo);
    failureOrSuccess.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(LoadTodos()),
    );
  }

  Future<void> _onDeleteTodo(DeleteTodoEvent event, Emitter<TodoState> emit) async {
    final failureOrSuccess = await deleteTodo(event.id);
    failureOrSuccess.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) => add(LoadTodos()),
    );
  }
}
