import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class DateOrMonthSelector extends StatefulWidget {
  final bool isDay;
  final Function(DateTime dateTime)
  onDateChanged; // don't really understand the idea of this

  const DateOrMonthSelector({
    super.key,
    required this.isDay,
    required this.onDateChanged,
  });
  @override
  _DateOrMonthSelectorState createState() => _DateOrMonthSelectorState();
}

//WARNING: feb trouble
class _DateOrMonthSelectorState extends State<DateOrMonthSelector> {
  DateTime _selectedDate = DateTime.now();
  //NOTE: show dd-MM-yy EEE
  String _formattedDate(DateTime date) {
    return DateFormat('dd-MM-yy (EEE)').format(date);
  }

  //NOTE: show month
  // Feb 2025
  String _formatedMonth(DateTime date) {
    return DateFormat('MMM yyyy').format(date);
  }

  //NOTE: Function to select the previous day
  void _previousDay() {
    setState(() {
      _selectedDate = _selectedDate.subtract(Duration(days: 1));
      widget.onDateChanged(_selectedDate);
    });
  }

  //NOTE: Function to select the next day
  void _nextDay() {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: 1));
      widget.onDateChanged(_selectedDate);
    });
  }

  void _previousMonth() {
    setState(() {
      // Go to the previous month
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month - 1,
        _selectedDate.day,
      );

      // If the new month is invalid (e.g., Feb 30th), adjust to the last day of the previous month
      if (_selectedDate.month != (_selectedDate.month - 1) % 12) {
        // Adjust to the last valid day of the previous month
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month + 1,
          0,
        ); // Last day of the previous month
      }

      widget.onDateChanged(_selectedDate);
    });
  }

  void _nextMonth() {
    setState(() {
      // Go to the next month
      _selectedDate = DateTime(
        _selectedDate.year,
        _selectedDate.month + 1,
        _selectedDate.day,
      );

      // If the new month is invalid (e.g., Feb 30th), adjust to the last day of the next month
      if (_selectedDate.month != (_selectedDate.month - 1) % 12 + 1) {
        // Adjust to the last valid day of the next month
        _selectedDate = DateTime(
          _selectedDate.year,
          _selectedDate.month + 1,
          0,
        ); // Last day of the next month
      }

      widget.onDateChanged(_selectedDate);
    });
  }

  //NOTE: Function to pick a new date
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
        widget.onDateChanged(_selectedDate);
      });
    }
  }

  //NOTE: Function to pick a new month
  Future<void> _selectMonth(BuildContext context) async {
    final DateTime? pickedDate = await showMonthPicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = DateTime(pickedDate.year, pickedDate.month);
        widget.onDateChanged(_selectedDate);
      });
    }
  }

  //FIX: afte modifying this un-expected ui behavior happes the input /income page
  //might be the effect of month picker pkg

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Center the row
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          iconSize: 30,
          onPressed: widget.isDay ? _previousDay : _previousMonth,
          icon: Icon(Icons.chevron_left),
        ),
        SizedBox(
          width: 180,
          child: FilledButton(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              backgroundColor: WidgetStatePropertyAll(Colors.lightBlueAccent),
            ),
            onPressed:
                () =>
                    widget.isDay ? _selectDate(context) : _selectMonth(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    widget.isDay
                        ? _formattedDate(_selectedDate)
                        : _formatedMonth(_selectedDate),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                SizedBox(width: 45),
                Icon(Icons.calendar_month),
              ],
            ),
          ),
        ),
        IconButton(
          iconSize: 30,
          onPressed: widget.isDay ? _nextDay : _nextMonth,
          icon: Icon(Icons.chevron_right),
        ),
      ],
    );
  }
}
