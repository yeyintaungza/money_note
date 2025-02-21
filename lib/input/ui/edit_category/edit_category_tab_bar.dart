import 'package:flutter/material.dart';
import 'package:moneynote/input/ui/edit_category/reusuable_edit_category.dart';

class EditCategoryTabBar extends StatelessWidget {
  const EditCategoryTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          //WARNING: other wise , there will be a left chevron
          automaticallyImplyLeading: false,
          leading: null,
          title: const TabBar(
            tabs: <Widget>[
              Tab(text: 'Expense'),
              Tab(text: 'Income'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: ReusuableEditCategory()),
            Center(child: ReusuableEditCategory()),
          ],
        ),
      ),
    );
  }
}
