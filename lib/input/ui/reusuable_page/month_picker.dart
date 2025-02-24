// build a month picker with chevron button at each side
// and a date picker in the middle

// might be an alt for date picker
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MonthPicker extends StatefulWidget {
  const MonthPicker({super.key});

  @override
  State<MonthPicker> createState() => _MonthPickerState();
}

class _MonthPickerState extends State<MonthPicker> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center the row
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(Icons.chevron_left),
        ),
        // this need to be month and year
        Text(
          DateFormat('MMMM yyyy').format(DateTime.now()),
          style: TextStyle(fontSize: 20),
        ),
        IconButton(
          iconSize: 30,
          onPressed: () {},
          icon: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
