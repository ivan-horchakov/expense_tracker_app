import 'package:expense_tracker_app/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem(this.expense, {super.key});

  final Expense expense;

  final TextStyle blackText = const TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    const double textScaler = 1.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          children: [
            Text(
              expense.title,
              style: blackText,
              textScaler: const TextScaler.linear(textScaler),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  '\$${expense.amount.toStringAsFixed(2)}',
                  style: blackText,
                  textScaler: const TextScaler.linear(textScaler),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(categoryIcons[expense.category]),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      expense.formattedDate,
                      style: blackText,
                      textScaler: const TextScaler.linear(textScaler),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
