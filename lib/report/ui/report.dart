import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneynote/input/ui/reusuable_page/date_picker_thing.dart';
import 'package:moneynote/report/ui/bloody_pie_chart.dart';

import '../../data/service/expense_service.dart';
import '../../data/service/income_service.dart';
import 'chartProvider.dart';

class ReportPage extends ConsumerStatefulWidget {
  const ReportPage({super.key});

  @override
  ConsumerState<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends ConsumerState<ReportPage> {
  DateTime _selectDate = DateTime.now();

  void _onDateChanged(DateTime newDate) {
    if (_selectDate != newDate) {
      setState(() {
        _selectDate = newDate;
        debugPrint('$_selectDate');
      });
    }
  }

  DateTimeRange _getMonthDateRange(DateTime date) {
    final firstDayOfMonth = DateTime(date.year, date.month, 1);
    //NOTE: add one month to current month and subtract one day to get the last day of the current month
    //this is implicit , 0 force to go to the last day of previous month
    final lastDayOfMonth =
        (date.month == 12)
            ? DateTime(date.year + 1, 1, 0)
            : DateTime(date.year, date.month + 1, 0);
    return DateTimeRange(start: firstDayOfMonth, end: lastDayOfMonth);
  }

  @override
  Widget build(BuildContext context) {
    final chartType = ref.watch(chartTypeProvider); // Get current chart type

    final monthlyExpenseList = ref.watch(
      monthlyExpenseListProvider(_getMonthDateRange(_selectDate)),
    );

    final monthlyIncomeList = ref.watch(
      monthlyIncomeListProvider(_getMonthDateRange(_selectDate)),
    );

    final totalMonthlyExpense = ref.watch(
      totalExpneseMonthlyProvider(_getMonthDateRange(_selectDate)),
    );
    final totalMonthlyIncome = ref.watch(
      totalIncomeMonthlyProvider(_getMonthDateRange(_selectDate)),
    );

    double total = 0.0;

    totalMonthlyIncome.when(
      data: (income) {
        total = income;
      },
      error: (error, stackTrace) {},
      loading: () {},
    );

    totalMonthlyExpense.when(
      data: (expense) {
        total -= expense;
      },
      error: (error, stackTrace) {},
      loading: () {},
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.black87,
        title: Row(children: [const Text('Report')]),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.search))],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DateOrMonthSelector(
                  isDay: false,
                  onDateChanged: _onDateChanged,
                ),
              ],
            ),

            // 2nd item
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.lightBlueAccent,
              ),
              margin: EdgeInsets.all(30),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Expense',
                              style: TextStyle(color: Colors.black),
                            ),
                            totalMonthlyExpense.when(
                              data: (expense) {
                                return Text(
                                  '\$ $expense',
                                  style: TextStyle(color: Colors.black),
                                );
                              },
                              loading: () => const Text('Loading...'),
                              error:
                                  (error, stackTrace) =>
                                      const Text('Error occurred'),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: VerticalDivider(color: Colors.redAccent),
                        ),
                        Column(
                          children: [
                            Text(
                              'Income',
                              style: TextStyle(color: Colors.black),
                            ),
                            totalMonthlyIncome.when(
                              data: (income) {
                                return Text(
                                  '\$ $income',
                                  style: TextStyle(color: Colors.black),
                                );
                              },
                              loading: () => const Text('Loading...'),
                              error:
                                  (error, stackTrace) =>
                                      const Text('Error occurred'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(color: Colors.redAccent),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Income and expense',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 20),
                        Text(
                          '\$ $total',
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            // Button for selecting Expense or Income
            Container(
              color: Colors.lightBlueAccent,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          ref.read(chartTypeProvider.notifier).state =
                              ChartType.expense; // Change to Expense
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              chartType == ChartType.expense
                                  ? Colors.blue
                                  : Colors.grey, // Highlight Expense button
                        ),
                        child: const Text(
                          'Expense',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: () {
                          ref.read(chartTypeProvider.notifier).state =
                              ChartType.income; // Change to Income
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              chartType == ChartType.income
                                  ? Colors.blue
                                  : Colors.grey, // Highlight Income button
                        ),
                        child: const Text(
                          'Income',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  // Render BloodyPieChart based on selected chart type
                  chartType == ChartType.expense
                      ? BloodyPieChart(
                        listOfExpenseOrIncome: monthlyExpenseList,
                      )
                      : BloodyPieChart(
                        listOfExpenseOrIncome: monthlyIncomeList,
                      ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
