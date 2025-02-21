import 'package:isar/isar.dart';

part 'income.g.dart';

@Collection()
class Income {
  /// IncomeSchema
  Id? id = Isar.autoIncrement;

  final double amount;
  final DateTime date;
  final String description;

  final String category;

  Income({
    required this.amount,
    required this.date,
    required this.description,
    required this.category,
  });
}
