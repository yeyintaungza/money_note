import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneynote/data/service/expense_service.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../constants/constants.dart';
import '../../data/service/income_service.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

// TODO:
// init state givenMonth
// every time givenMonth chnages update the state

class _CalendarPageState extends ConsumerState<CalendarPage> {
  DateTime _focusedMonth = DateTime.now();

  //NOTE: provide current month with range
  DateTimeRange getMonthDateRange(DateTime date) {
    final startOfMonth = DateTime(date.year, date.month, 1);
    final endOfMonth = DateTime(
      date.year,
      date.month + 1,
      0,
      23,
      59,
      59,
    ); // Correct end of month calculation
    final DateTimeRange givenMonth = DateTimeRange(
      start: startOfMonth,
      end: endOfMonth,
    );
    return givenMonth;
  }

  @override
  Widget build(BuildContext context) {
    final totalExpense = ref.watch(
      totalExpneseMonthlyProvider(getMonthDateRange(_focusedMonth)),
    );

    final totalIncome = ref.watch(
      totalIncomeMonthlyProvider(getMonthDateRange(_focusedMonth)),
    );

    final monthlyExpenseList = ref.watch(
      monthlyExpenseListProvider(getMonthDateRange(_focusedMonth)),
    );

    double total = 0.0;

    totalIncome.when(
      data: (income) {
        total = income;
      },
      error: (error, stackTrace) {},
      loading: () {},
    );

    totalExpense.when(
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
        title: Row(children: const [Text('Calendar')]),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          //NOTE: calendar
          TableCalendar(
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedMonth,
            calendarFormat: CalendarFormat.month,
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedMonth = DateTime(focusedDay.year, focusedDay.month);
              });
            },
          ),

          //NOTE: monthly total report
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 14),
            height: 50,
            decoration: BoxDecoration(
              color: Colors.lightBlueAccent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Income'),
                    totalIncome.when(
                      data: (income) {
                        return Text('\$ $income');
                      },
                      error: (error, st) {
                        return const Text('error');
                      },
                      loading: () {
                        return const Text('Loading...');
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(color: Colors.red, thickness: 1),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Expense'),
                    totalExpense.when(
                      data: (expense) {
                        // This is where you access the double value
                        return Text('\$ $expense');
                      },
                      loading: () {
                        // Handle loading state, you can show a loading message or indicator
                        return const Text('Loading...');
                      },
                      error: (error, stackTrace) {
                        // Handle error state, you can show an error message
                        return const Text('Error occurred');
                      },
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                  child: VerticalDivider(color: Colors.red, thickness: 1),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text('Total'), Text('\$ $total')],
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          //NOTE: daily Expense of a  month
          Expanded(
            child: monthlyExpenseList.when(
              error: (error, st) {
                return Center(child: Text('error'));
              },
              loading: () {
                return const Center(child: CircularProgressIndicator());
              },
              data: (expenseList) {
                return ListView.builder(
                  itemCount: expenseList.length,
                  itemBuilder: (context, index) {
                    final expense = expenseList[index];
                    return Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.lightBlueAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [Text('\$ ${expense.amount} ')],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  //NOTE: Find the category in kExpenseCategory and display the correct icon
                                  Icon(
                                    kExpenseCategory.firstWhere(
                                      (category) =>
                                          category['label'] == expense.category,
                                      orElse:
                                          () => {
                                            'icon': Icons.error,
                                          }, // Default icon in case of no match
                                    )['icon'],
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    expense.category,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Text('test'),
                                ],
                              ),

                              Text(
                                expense.description,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
