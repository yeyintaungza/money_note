import 'package:flutter/material.dart';
import 'package:moneynote/input/ui/reusuable_page/input_tab_bar.dart';

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Row(children: [const Text('MoneyNote')]),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.edit))],
      ),
      body: InputTabBar(),
    );
  }
}
