import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:moneynote/data/models/income.dart';
import 'package:moneynote/main.dart';

class IncomeService {
  final Ref ref;

  IncomeService({required this.ref});

  Future<double> totoalIncomeMonthly(DateTimeRange month) async {
    final isar = ref.watch(isarProvider);

    final incomes =
        await isar.incomes
            .filter()
            .dateBetween(month.start, month.end)
            .findAll();

    double totalMonthlyIncome = 0;

    for (var income in incomes) {
      totalMonthlyIncome = income.amount;
    }

    return totalMonthlyIncome;
  }

  Future<List<Income>> monthlyIncomeList(DateTimeRange month) async {
    final isar = ref.watch(isarProvider);

    final incomeList =
        await isar.incomes
            .filter()
            .dateBetween(month.start, month.end)
            .findAll();

    return incomeList;
  }

  Future<void> createIncome(Income income) async {
    final isar = ref.watch(isarProvider);

    try {
      await isar.writeTxn(() async {
        await isar.incomes.put(income);
      });
    } catch (e) {
      debugPrint('error in income_service $e');
    }
  }
}

final incomeServiceProvider = Provider<IncomeService>(
  (ref) => IncomeService(ref: ref),
);

//NOTE: total monthly income
final totalIncomeMonthlyProvider = FutureProvider.autoDispose.family((
  ref,
  DateTimeRange month,
) {
  final incomeService = ref.watch(incomeServiceProvider);
  return incomeService.totoalIncomeMonthly(month);
});

//NOTE: monthly list of income
final monthlyIncomeListProvider = FutureProvider.autoDispose.family((
  ref,
  DateTimeRange month,
) {
  final incomeService = ref.watch(incomeServiceProvider);
  return incomeService.monthlyIncomeList(month);
});

//NOTE: create income
final createIncomeProvider = FutureProvider.autoDispose.family((
  ref,
  Income income,
) {
  final incomeService = ref.watch(incomeServiceProvider);
  return incomeService.createIncome(income);
});
