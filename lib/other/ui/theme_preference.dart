import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemePreference {
  // this key and value represent dark or light theme
  static const String _keyDarkMode = 'darkMode';

  // Save the theme preference (true for dark, false for light)
  static Future<void> saveThemeMode(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyDarkMode, isDarkMode);
  }

  // Load the theme preference (defaults to light theme if not set)
  static Future<bool> getThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyDarkMode) ??
        false; // Default to light theme (false)
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    bool darkMode = await ThemePreference.getThemeMode();
    state = darkMode;
  }

  Future<void> toggleTheme() async {
    state = !state; // Toggle the theme state
    await ThemePreference.saveThemeMode(state); // Save to SharedPreferences
  }
}
