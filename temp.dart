final note = _noteController.text;
                      final amount =
                          double.tryParse(_amountController.text) ?? 0.0;
                      final category =
                          widget.categorylist[_selectedGridItem]['label'];
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
