import 'package:isar/isar.dart';

part 'expense.g.dart';

@Collection()
class Expense {
  /// ExpenseSchema
  Id? id = Isar.autoIncrement;

  final double amount;
  //NOTE: because of this i think i can query the daily Expense
  final DateTime date;
  final String description;
  final String category;

  Expense({
    required this.amount,
    required this.date,
    required this.description,
    required this.category,
  });
}
