import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:moneynote/app.dart';
import 'package:moneynote/data/models/expense.dart';
import 'package:moneynote/data/models/income.dart';
import 'package:path_provider/path_provider.dart';

import 'other/ui/theme_preference.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures that the app is properly initialized before running

  // Initialize Isar
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([
    IncomeSchema,
    ExpenseSchema,
  ], directory: dir.path);

  runApp(
    ProviderScope(
      overrides: [
        isarProvider.overrideWithValue(
          isar,
        ), // Override the isarProvider to use the initialized isar instance
      ],
      child: MyApp(),
    ),
  );
}

//NOTE: This is kinda cool
// Global Isar provider to access the database instance
// Placeholder, actual initialization is done in main
final isarProvider = Provider<Isar>((ref) {
  throw UnimplementedError('Isar provider should be overridden before use');
});

//NOTE: this one controll light and dark mode
class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final isDarkMode = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      darkTheme: ThemeData.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      debugShowCheckedModeBanner: false,

      home: App(),
    );
  }
}
