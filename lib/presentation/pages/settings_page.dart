import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../viewmodels/riverpod/settings_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Sử dụng ref.watch để lắng nghe sự thay đổi của themeNotifierProvider
    final themeMode = ref.watch(themeNotifierProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cài đặt'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Chế độ ban đêm (Dark Mode)'),
            subtitle: const Text('Cài đặt giao diện'),
            value: isDark,
            onChanged: (value) {
              // Sử dụng ref.read để gọi hàm từ Notifier mà không cần lắng nghe toàn cục
              ref.read(themeNotifierProvider.notifier).toggleTheme();
            },
            secondary: Icon(
              isDark ? Icons.dark_mode : Icons.light_mode,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}
