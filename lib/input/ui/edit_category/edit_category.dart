import 'package:flutter/material.dart';
import 'package:moneynote/input/ui/edit_category/edit_category_tab_bar.dart';

class EditCategories extends StatefulWidget {
  const EditCategories({super.key});

  @override
  State<EditCategories> createState() => _EditCategoriesState();
}

// orders can be re-arranged
// since the array is fixed , replace instead of add or remove
// functionality will be re-usuable , the array will be different
// gotta pass the different array representing 'income' and 'expense'
class _EditCategoriesState extends State<EditCategories> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit category'),
        // TODO: add functionality
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.add))],
      ),
      body: EditCategoryTabBar(),
    );
  }
}
