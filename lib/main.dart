import 'package:expense_tracker/widgets/expenses.dart';
import 'package:flutter/material.dart';

var kColourScheme = ColorScheme.fromSeed(
  seedColor: Color.fromARGB(255, 96, 59, 181),
);

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData().copyWith(
        // scaffoldBackgroundColor: const Color.fromARGB(255, 254, 236, 255),
        //Instead of setting up an entire Theme from scratch, it's often better to copy an existing Theme
        //and then just style individual aspects of that Theme.
        colorScheme: kColourScheme,
        //You can set up an app bar Theme here and create an app bar Theme object.
        //Again, best done by creating an object and then using copy with so that you get some default app bar Theme settings by Flutter.
        //And you then just override selected settings.
        appBarTheme: AppBarTheme().copyWith(
          backgroundColor: kColourScheme.onPrimaryContainer,
          foregroundColor: kColourScheme.primaryContainer,
        ),
        cardTheme: CardTheme().copyWith(
          color: kColourScheme.secondaryContainer,
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              backgroundColor: kColourScheme.primaryContainer),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              // titleLarge: ThemeData().textTheme.titleLarge!.copyWith(),
              titleLarge: TextStyle(
                fontWeight: FontWeight.normal,
                color: kColourScheme.onSecondaryContainer,
                fontSize: 14,
              ),
            ),
      ),
      home: Expenses(),
    ),
  );
}
