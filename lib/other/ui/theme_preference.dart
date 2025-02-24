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

final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, bool>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<bool> {
  /// encapsulate the business logic inside the notifier
  /// pass the initial value to the constructor
  ThemeNotifier() : super(false) {
    _loadTheme();
  }

  // this is called in constructor at the start up
  Future<void> _loadTheme() async {
    bool darkMode = await ThemePreference.getThemeMode();
    state = darkMode;
  }

  // this is called inside a widget explicitly
  Future<void> toggleTheme() async {
    // since the value is boolean
    state = !state; // Toggle the theme state
    await ThemePreference.saveThemeMode(state); // Save to SharedPreferences
  }
}

//doesn’t manage mutable state directly. If the state changes, you have to manually trigger those changes outside of the Provider
