import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/app_theme.dart';
import '../utils/logger.dart';

/// Provider for current user type that determines the theme
final userTypeProvider = StateProvider<String>((ref) {
  logger.d('Initializing user type provider with default: homeowner');
  return 'homeowner';
});

/// Provider for theme based on user type
final themeProvider = Provider<ThemeData>((ref) {
  final userType = ref.watch(userTypeProvider);
  logger.d('Getting theme for user type: $userType');
  return AppTheme.getThemeForUserType(userType);
});

/// Provider for theme mode
final themeModeProvider =
    StateNotifierProvider<ThemeModeNotifier, ThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<ThemeMode> {
  static const _key = 'theme_mode';
  late final SharedPreferences _prefs;

  ThemeModeNotifier() : super(ThemeMode.system) {
    _init();
  }

  Future<void> _init() async {
    try {
      logger.i('Initializing ThemeModeNotifier');
      _prefs = await SharedPreferences.getInstance();
      final savedMode = _prefs.getString(_key);
      if (savedMode != null) {
        state = ThemeMode.values.firstWhere(
          (mode) => mode.name == savedMode,
          orElse: () => ThemeMode.system,
        );
        logger.d('Loaded saved theme mode: ${state.name}');
      }
    } catch (e) {
      logger.e('Error initializing theme mode', error: e);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    try {
      logger.i('Setting theme mode to: ${mode.name}');
      await _prefs.setString(_key, mode.name);
      state = mode;
      logger.d('Theme mode updated successfully');
    } catch (e) {
      logger.e('Error setting theme mode', error: e);
    }
  }

  Future<void> toggleThemeMode() async {
    final newMode = state == ThemeMode.light
        ? ThemeMode.dark
        : state == ThemeMode.dark
            ? ThemeMode.system
            : ThemeMode.light;
    await setThemeMode(newMode);
  }
}
