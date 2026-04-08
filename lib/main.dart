import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/di/injection_container.dart' as di;
import 'data/models/todo_model.dart';
import 'presentation/pages/home_page.dart';
import 'presentation/viewmodels/bloc/todo_bloc.dart';
import 'presentation/viewmodels/riverpod/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Hive
  await Hive.initFlutter();
  
  // Register adapters
  Hive.registerAdapter(TodoModelAdapter());
  
  // Open Boxes
  await Hive.openBox<TodoModel>('todos');

  // Initialize Dependency Injection (get_it cho To-Do feature)
  await di.init();

  // Initialize SharedPreferences (Riverpod DI cho Settings feature)
  final sharedPrefs = await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        // Ghi đè cấu hình DI của Riverpod để truyền instance dùng chung
        sharedPreferencesProvider.overrideWithValue(sharedPrefs),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lắng nghe trạng thái Theme từ Riverpod Notifier
    final themeMode = ref.watch(themeNotifierProvider);

    return MaterialApp(
      title: 'Clean Architecture To-Do',
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3B82F6),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider(
        create: (_) => di.sl<TodoBloc>(),
        child: const HomePage(),
      ),
    );
  }
}
