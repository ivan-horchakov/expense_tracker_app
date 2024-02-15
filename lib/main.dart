import 'package:expense_tracker_app/widgets/expenses.dart';
import 'package:flutter/material.dart';

// var kColorScheme = ColorScheme.fromSeed(seedColor: Colors.black);

void main() {
  runApp(
    const MaterialApp(
      // theme: ThemeData().copyWith(
      //   scaffoldBackgroundColor: Colors.black,
      //   cardTheme: const CardTheme().copyWith(
      //     color: Colors.white,
      //     margin: const EdgeInsets.symmetric(
      //       horizontal: 15,
      //       vertical: 3,
      //     ),
      //   ),
      // ),
      home: Expenses(),
    ),
  );
}
