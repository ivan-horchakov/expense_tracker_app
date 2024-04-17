import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpenseState();
  }
}

class _NewExpenseState extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;
  static const double _textScaler = 1.0;

  void _presentDatePicker() async {
    final todayDate = DateTime.now();
    final firstDate = DateTime(todayDate.year - 1, todayDate.month, todayDate.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: todayDate,
      firstDate: firstDate,
      lastDate: todayDate,
    );
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty || amountIsInvalid || _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text(
              'Invalid input',
              textScaler: TextScaler.linear(_textScaler),
            ),
            content: const Text(
              'Please make sure that you entered a valid title, amount & date.',
              textScaler: TextScaler.linear(_textScaler),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text(
                  'Okay',
                  textScaler: TextScaler.linear(_textScaler),
                ),
              ),
            ],
          );
        },
      );
      return;
    }
    widget.onAddExpense(
      Expense(
        title: _titleController.text,
        amount: enteredAmount,
        date: _selectedDate!,
        category: _selectedCategory,
      ),
    );
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    const double textScaler = 1.0;

    return LayoutBuilder(
      builder: (ctx, constrains) {
        final width = constrains.maxWidth;
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(18, 0, 18, keyboardSpace + 18),
            child: Column(
              children: [
                if (width >= 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _titleController,
                          maxLength: 50,
                          decoration: const InputDecoration(
                            label: Text(
                              'Title',
                              style: TextStyle(color: Colors.black),
                              textScaler: TextScaler.linear(textScaler),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text(
                              'Amount',
                              style: TextStyle(color: Colors.black),
                              textScaler: TextScaler.linear(textScaler),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  )
                else
                  TextField(
                    controller: _titleController,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text(
                        'Title',
                        style: TextStyle(color: Colors.black),
                        textScaler: TextScaler.linear(textScaler - 0.2),
                      ),
                    ),
                  ),
                if (width >= 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                  textScaler: const TextScaler.linear(textScaler),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null ? 'No Date Selected' : formatter.format(_selectedDate!),
                              textScaler: const TextScaler.linear(textScaler - 0.3),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                'Cancel',
                                textScaler: TextScaler.linear(textScaler),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: _submitExpenseData,
                              child: const Text(
                                'Save Expense',
                                textScaler: TextScaler.linear(textScaler),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountController,
                          decoration: const InputDecoration(
                            prefixText: '\$ ',
                            label: Text(
                              'Amount',
                              style: TextStyle(color: Colors.black),
                              textScaler: TextScaler.linear(textScaler - 0.2),
                            ),
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              _selectedDate == null ? 'No Date Selected' : formatter.format(_selectedDate!),
                              textScaler: const TextScaler.linear(textScaler - 0.3),
                            ),
                            IconButton(
                              onPressed: _presentDatePicker,
                              icon: const Icon(Icons.calendar_month),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (width < 600)
                  Row(
                    children: [
                      DropdownButton(
                        value: _selectedCategory,
                        items: Category.values
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(
                                  category.name.toUpperCase(),
                                  textScaler: const TextScaler.linear(textScaler - 0.2),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          textScaler: TextScaler.linear(textScaler - 0.3),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text(
                          'Save Expense',
                          textScaler: TextScaler.linear(textScaler - 0.3),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
