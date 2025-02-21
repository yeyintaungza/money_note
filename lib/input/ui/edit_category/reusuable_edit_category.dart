import 'package:flutter/material.dart';

class ReusuableEditCategory extends StatefulWidget {
  const ReusuableEditCategory({super.key});

  @override
  State<ReusuableEditCategory> createState() => _ReusuableEditCategoryState();
}

// need to pass editable fix arrays to this widget
class _ReusuableEditCategoryState extends State<ReusuableEditCategory> {
  @override
  Widget build(BuildContext context) {
    // TODO: listview builder , list tile
    return Text(
        'edit catedory for imcome and expense : list lite , listview builder');
  }
}
