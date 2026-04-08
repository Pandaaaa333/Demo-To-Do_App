import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 1. Dependency Injection với Riverpod
/// Provider này cung cấp một instance của SharedPreferences cho toàn bộ ứng dụng.
/// Do SharedPreferences cần được khởi tạo bất đồng bộ (await SharedPreferences.getInstance()),
/// chúng ta sẽ override giá trị của provider này ở hàm main() của app.
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

/// 2. State Management với Riverpod
/// Lớp ThemeNotifier dùng để quản lý trạng thái của ThemeMode (Dark/Light).
/// Nó sẽ đọc giá trị đã lưu từ SharedPreferences trong hàm build.
class ThemeNotifier extends Notifier<ThemeMode> {
  static const _themeKey = 'theme_mode';

  @override
  ThemeMode build() {
    // Đọc SharedPreferences từ Provider, thể hiện DI trong Riverpod
    final prefs = ref.watch(sharedPreferencesProvider);
    final isDark = prefs.getBool(_themeKey) ?? false;
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  /// Cập nhật ThemeMode và lưu xuống bộ nhớ thiết bị
  void toggleTheme() {
    final prefs = ref.read(sharedPreferencesProvider);
    if (state == ThemeMode.light) {
      state = ThemeMode.dark;
      prefs.setBool(_themeKey, true);
    } else {
      state = ThemeMode.light;
      prefs.setBool(_themeKey, false);
    }
  }
}

/// Provider của ThemeNotifier để UI (Consumer) có thể lắng nghe
final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});
