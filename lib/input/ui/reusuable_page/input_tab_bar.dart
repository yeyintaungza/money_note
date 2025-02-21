import 'package:flutter/material.dart';
import 'package:moneynote/constants/constants.dart';

import 'reususble_input.dart';

class InputTabBar extends StatelessWidget {
  const InputTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const TabBar(
            tabs: <Widget>[Tab(text: 'Expense'), Tab(text: 'Income')],
          ),
        ),
        body: const TabBarView(
          children: [
            ReUsuableInput(isIncome: false, categorylist: kExpenseCategory),
            ReUsuableInput(isIncome: true, categorylist: kIncomeCategory),
          ],
        ),
      ),
    );
  }
}
