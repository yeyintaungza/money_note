import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moneynote/report/ui/no_data.dart';

import '../../data/models/expense.dart';
import '../../data/models/income.dart';

class BloodyPieChart<T> extends StatelessWidget {
  const BloodyPieChart({super.key, required this.listOfExpenseOrIncome});
  final AsyncValue<List<T>> listOfExpenseOrIncome;

  // WARNING: make the smallest segment size wide enough for text display
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    // Check if the list is empty or loading, if so, return NoData widget
    if (listOfExpenseOrIncome is AsyncLoading ||
        listOfExpenseOrIncome is AsyncError) {
      return Center(child: CircularProgressIndicator());
    }

    if (listOfExpenseOrIncome.value?.isEmpty ?? true) {
      return const NoData(); // Your NoData widget
    }

    // Calculate total value for percentage calculations
    double total = 0;
    listOfExpenseOrIncome.value?.forEach((item) {
      if (item is Expense) {
        total += item.amount;
      } else if (item is Income) {
        total += item.amount;
      }
    });

    // Generate the PieChart sections dynamically
    List<PieChartSectionData> pieChartSections = [];
    List<T> items = listOfExpenseOrIncome.value!;

    // Define your color scheme
    List<Color> pieColors = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];

    // Limit the items to 6, and the rest will go into the "Other" category
    double otherAmount = 0;
    int maxItems = 6;

    for (int i = 0; i < items.length; i++) {
      if (i < maxItems) {
        double sectionValue =
            (items[i] is Expense)
                ? (items[i] as Expense).amount
                : (items[i] as Income).amount;
        double percentage = (sectionValue / total) * 100;

        // Skip the section if the percentage is 0
        if (percentage > 0) {
          pieChartSections.add(
            PieChartSectionData(
              color: pieColors[i],
              value: percentage,
              title:
                  (percentage > 1.0) // Show title only for large sections
                      ? '${percentage.toStringAsFixed(0)}%'
                      : '', // Empty title for very small segments
              radius: 50,
              showTitle: percentage > 1.0, // Show title only if percentage > 1%
            ),
          );
        }
      } else {
        otherAmount +=
            (items[i] is Expense)
                ? (items[i] as Expense).amount
                : (items[i] as Income).amount;
      }
    }

    // Add the "Other" category if there's any remaining amount
    if (otherAmount > 0) {
      double otherPercentage = (otherAmount / total) * 100;
      // Skip if the "Other" category is less than 1% (adjust threshold as needed)
      if (otherPercentage > 0) {
        pieChartSections.add(
          PieChartSectionData(
            color: pieColors[6], // Use violet for "Other"
            value: otherPercentage,
            title:
                (otherPercentage > 1.0)
                    ? '${otherPercentage.toStringAsFixed(0)}%'
                    : '', // Empty title for "Other" if it's too small
            radius: 50,
            showTitle:
                otherPercentage >
                1.0, // Show title for "Other" only if it's > 1%
          ),
        );
      }
    }

    return Column(
      children: [
        SizedBox(
          width: screenWidth * 0.7, // 70% of screen width
          height: screenHeight * 0.3, // 30% of screen height
          child: PieChart(PieChartData(sections: pieChartSections)),
        ),
        Divider(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.food_bank),
                  SizedBox(width: 10),
                  Text('Food'),
                ],
              ),
              Text('400.00 \$'), // You can dynamically replace this as well
            ],
          ),
        ),
      ],
    );
  }
}
