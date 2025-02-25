import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneynote/data/service/expense_service.dart';

import '../../../data/models/expense.dart';
import '../../../data/models/income.dart';
import '../../../data/service/income_service.dart';
import 'date_picker_thing.dart';

class ReUsuableInput extends ConsumerStatefulWidget {
  final List<Map<String, dynamic>> categorylist;
  final bool isIncome;

  const ReUsuableInput({
    super.key,
    required this.categorylist,
    required this.isIncome,
  });

  @override
  ConsumerState<ReUsuableInput> createState() => _ReUsuableInputState();
}

class _ReUsuableInputState extends ConsumerState<ReUsuableInput> {
  int _selectedGridItem = -1;
  DateTime _selectDate = DateTime.now(); // just to hold a date time value

  //NOTE: pass this func to DateOrMonthSelector , and then
  //update the value of '_selectDate' , inside the DateOrMonthSelector
  // *** simple ***
  void _onDateChanged(DateTime newDate) {
    setState(() {
      _selectDate = newDate;
    });
  }

  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  // PERF:
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          //NOTE: date picker
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 0, 5),
            child: Row(
              children: [
                Text('Date', style: TextStyle(fontSize: 18)),
                SizedBox(width: 35),
                Align(
                  child: DateOrMonthSelector(
                    isDay: true,
                    onDateChanged: _onDateChanged,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
            child: Divider(height: 0),
          ),

          //NOTE: First block: 'Note' and its TextField
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 8, 0, 0),
            child: Row(
              children: [
                Text('Note', style: TextStyle(fontSize: 18)),
                Expanded(
                  child: Align(
                    child: SizedBox(
                      width: 200,
                      height: 40,
                      child: TextField(
                        controller: _noteController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.lightBlueAccent,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Not entered',
                          hintStyle: TextStyle(
                            fontWeight: FontWeight.w200,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Divider (optional for separation between fields)
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Divider(height: 0),
          ),

          //NOTE: Second block: 'Income' or 'Expense' and its TextField
          Padding(
            // different right padding to handle '$'
            padding: const EdgeInsets.fromLTRB(18, 8, 18, 0),
            child: Row(
              children: [
                Text(
                  widget.isIncome ? 'Income ' : 'Expense',
                  style: TextStyle(fontSize: 18),
                ),
                Expanded(
                  child: Align(
                    child: SizedBox(
                      width: 200,
                      height: 40,
                      child: TextField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.lightBlueAccent,
                          hintText: '0.00',
                          hintStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          signed: true,
                          decimal: true,
                        ),
                      ),
                    ),
                  ),
                ),
                Text('\$', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 18, 0),
            child: Divider(height: 0),
          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                child: Text('Category', style: TextStyle(fontSize: 18)),
              ),
            ],
          ),

          // Adding GridView.builder
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GridView.count(
              crossAxisCount: 4, // 4 items per row
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              shrinkWrap: true, // Prevents it from being scrollable
              physics:
                  const NeverScrollableScrollPhysics(), // Disables scrolling
              children: List.generate(widget.categorylist.length, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedGridItem = index;

                      //NOTE: another functionality if i want to
                      //if (index == 11) {
                      //  Navigator.push(
                      //    context,
                      //    MaterialPageRoute(
                      //      builder: (context) => EditCategories(),
                      //    ),
                      //  );
                      //}
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      // when choose => theme color ,for now lightBlueAccent
                      border: Border.all(
                        color:
                            _selectedGridItem == index
                                ? Colors.lightBlueAccent
                                : (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white24
                                    : Colors.black12),
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(widget.categorylist[index]['icon']),
                        Flexible(
                          child: Text(
                            widget.categorylist[index]['label'],
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  child: ElevatedButton(
                    //NOTE: date is correct
                    //but can't choose category
                    //possibly text field is not cleaned and donot show success msg
                    onPressed: () {
                      // it's working i guess
                      if (_noteController.text.isNotEmpty &&
                          _amountController.text.isNotEmpty) {
                        final note = _noteController.text;
                        final amount =
                            double.tryParse(_amountController.text) ?? 0.0;
                        final category =
                            _selectedGridItem >= 0 &&
                                    _selectedGridItem <
                                        widget.categorylist.length
                                ? widget
                                    .categorylist[_selectedGridItem]['label']
                                : '';
                        final date = _selectDate;

                        if (widget.isIncome) {
                          final income = Income(
                            amount: amount,
                            date: date,
                            description: note,
                            category: category,
                          );
                          ref.read(createIncomeProvider(income));
                        } else {
                          final expense = Expense(
                            amount: amount,
                            date: date,
                            description: note,
                            category: category,
                          );
                          ref.read(createExpenseProvider(expense));
                        }
                      }

                      //NOTE: Clear text fields and reset the category and date
                      _noteController.clear();
                      _amountController.clear();
                      setState(() {
                        _selectedGridItem = -1; // Reset category selection
                        _selectDate = DateTime.now(); // Reset to current date
                      });

                      debugPrint('submit is pressed ');
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                        Colors.lightBlueAccent,
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
