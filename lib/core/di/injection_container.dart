import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

import '../../data/datasources/todo_data_source.dart';
import '../../data/datasources/todo_local_data_source.dart';
import '../../data/datasources/todo_remote_data_source.dart';
import '../../data/models/todo_model.dart';
import '../../data/repositories/todo_repository_impl.dart';
import '../../domain/repositories/todo_repository.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/update_todo.dart';

import '../../presentation/viewmodels/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerFactory(
    () => TodoBloc(
      getTodos: sl(),
      addTodo: sl(),
      updateTodo: sl(),
      deleteTodo: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => AddTodo(sl()));
  sl.registerLazySingleton(() => UpdateTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));

  // Repository
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(sl()),
  );

  // Data sources

  sl.registerLazySingleton<TodoDataSource>(
    () => TodoLocalDataSourceImpl(sl()),
  );
  // sl.registerLazySingleton<TodoDataSource>(
  //   () => TodoRemoteDataSourceImpl(),
  // );


  // External Databases
  final todoBox = Hive.box<TodoModel>('todos');
  sl.registerLazySingleton<Box<TodoModel>>(() => todoBox);
}
