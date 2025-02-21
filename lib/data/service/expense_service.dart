import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:moneynote/data/models/expense.dart';
import 'package:moneynote/main.dart';

class ExpenseService {
  final Ref ref;

  ExpenseService(this.ref);

  Future<double> totalExpenseMonthly(DateTimeRange month) async {
    final isar = ref.watch(isarProvider);

    final expenses =
        await isar.expenses
            .filter()
            .dateBetween(month.start, month.end)
            .findAll();

    double totalMonthlyExpense = 0;
    for (var expense in expenses) {
      totalMonthlyExpense = expense.amount;
    }

    return totalMonthlyExpense;
  }

  Future<List<Expense>> monthlyExpenseList(DateTimeRange month) async {
    final isar = ref.watch(isarProvider);

    final expenseList =
        await isar.expenses
            .filter()
            .dateBetween(month.start, month.end)
            .findAll();

    return expenseList;
  }

  Future<void> creteExpense(Expense expense) async {
    final isar = ref.watch(isarProvider);

    try {
      await isar.writeTxn(() async {
        await isar.expenses.put(expense);
      });
    } catch (e) {
      debugPrint('$e');
    }
  }
}

final expenseServiceProvider = Provider<ExpenseService>(
  (ref) => ExpenseService(ref),
);

//NOTE: total monthly Expense
final totalExpneseMonthlyProvider = FutureProvider.autoDispose.family((
  ref,
  DateTimeRange month,
) {
  final expenseService = ref.watch(expenseServiceProvider);
  return expenseService.totalExpenseMonthly(month);
});

//NOTE: list of Expense in a month
final monthlyExpenseListProvider = FutureProvider.autoDispose.family((
  ref,
  DateTimeRange month,
) {
  final expenseService = ref.watch(expenseServiceProvider);
  return expenseService.monthlyExpenseList(month);
});

final createExpenseProvider = FutureProvider.autoDispose.family((
  ref,
  Expense expense,
) {
  final expenseService = ref.watch(expenseServiceProvider);
  return expenseService.creteExpense(expense);
});
