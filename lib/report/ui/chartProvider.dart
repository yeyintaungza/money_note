import 'package:flutter_riverpod/flutter_riverpod.dart';

enum ChartType { expense, income }

final chartTypeProvider = StateProvider<ChartType>((ref) {
  return ChartType.expense; // Default to Expense
});
