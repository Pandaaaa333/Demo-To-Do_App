import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data/datasources/settings_local_data_source.dart';
import '../../../data/repositories/settings_repository_impl.dart';
import '../../../domain/repositories/settings_repository.dart';
import '../../../domain/usecases/get_theme_mode.dart';
import '../../../domain/usecases/save_theme_mode.dart';

// ════════════════════════════════════════════════════════════════════════
//  DEPENDENCY INJECTION CHAIN — Constructor Injection via Riverpod
// ════════════════════════════════════════════════════════════════════════
//
//  SharedPreferences          (external, async → overrideWithValue ở main.dart)
//         │ Constructor Injection
//         ▼
//  SettingsLocalDataSourceImpl(prefs)       ← Data Layer
//         │ Constructor Injection
//         ▼
//  SettingsRepositoryImpl(dataSource)       ← Data Layer
//         │ Constructor Injection
//         ▼
//  GetThemeMode(repository)                 ← Domain Layer
//  SaveThemeMode(repository)                ← Domain Layer
//         │ Riverpod ref.watch (tương đương Constructor Injection)
//         ▼
//  ThemeNotifier   → chỉ biết về Use Cases, không biết SharedPreferences là gì
//
// ════════════════════════════════════════════════════════════════════════

// ── Bước 0: External Dependency ─────────────────────────────────────────
// SharedPreferences cần khởi tạo bất đồng bộ nên được cung cấp từ bên ngoài.
// ProviderScope.overrides trong main.dart đóng vai trò "DI Composition Root".
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError(
    'sharedPreferencesProvider chưa được override.\n'
    'Hãy dùng ProviderScope(overrides: [sharedPreferencesProvider.overrideWithValue(prefs)])',
  );
});

// ── Bước 1: Data Source Provider ────────────────────────────────────────
// Riverpod đóng vai trò "nhà máy" — tạo SettingsLocalDataSourceImpl
// và INJECT SharedPreferences qua constructor.
final settingsLocalDataSourceProvider = Provider<SettingsLocalDataSource>((ref) {
  return SettingsLocalDataSourceImpl(
    ref.watch(sharedPreferencesProvider), // ← Constructor Injection
  );
});

// ── Bước 2: Repository Provider ─────────────────────────────────────────
// Riverpod tạo SettingsRepositoryImpl và INJECT DataSource qua constructor.
// SettingsRepositoryImpl không hề biết SharedPreferences tồn tại.
final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepositoryImpl(
    ref.watch(settingsLocalDataSourceProvider), // ← Constructor Injection
  );
});

// ── Bước 3: Use Case Providers ──────────────────────────────────────────
// Mỗi Use Case nhận Repository qua constructor — tuân thủ đúng Clean Architecture.
// ThemeNotifier sẽ dùng các provider này, không bao giờ trực tiếp dùng Repository.

final getThemeModeProvider = Provider<GetThemeMode>((ref) {
  return GetThemeMode(
    ref.watch(settingsRepositoryProvider), // ← Constructor Injection
  );
});

final saveThemeModeProvider = Provider<SaveThemeMode>((ref) {
  return SaveThemeMode(
    ref.watch(settingsRepositoryProvider), // ← Constructor Injection
  );
});

// ── Bước 4: Notifier ────────────────────────────────────────────────────
// ThemeNotifier là tầng Presentation — chỉ biết về Use Cases.
// Không import SharedPreferences, không import Repository, không import DataSource.
// Đây chính là lợi ích của Clean Architecture + Constructor Injection.
class ThemeNotifier extends Notifier<ThemeMode> {
  late GetThemeMode _getThemeMode;
  late SaveThemeMode _saveThemeMode;

  @override
  ThemeMode build() {
    // ref.watch() ở đây tương đương Constructor Injection:
    // Riverpod tự "inject" use case vào Notifier khi khởi tạo.
    _getThemeMode = ref.watch(getThemeModeProvider);
    _saveThemeMode = ref.watch(saveThemeModeProvider);

    // Riverpod tự quản lý vòng đời — khi provider bị dispose,
    // tất cả dependency liên quan cũng được dọn dẹp tự động.
    final isDark = _getThemeMode();
    return isDark ? ThemeMode.dark : ThemeMode.light;
  }

  Future<void> toggleTheme() async {
    final isDark = state == ThemeMode.dark;
    await _saveThemeMode(!isDark); // ← Gọi Use Case, không tự gọi SharedPreferences
    state = isDark ? ThemeMode.light : ThemeMode.dark;
  }
}

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});
