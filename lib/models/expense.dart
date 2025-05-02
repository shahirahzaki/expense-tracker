import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

final formatter = DateFormat('d/M/y');
const uuid = Uuid();

enum Category {
  food,
  travel,
  leisure,
  work,
} //these are the only accepted categories

const categoryIcons = {
  Category.food: Icons.lunch_dining_outlined,
  Category.travel: Icons.directions_bus_filled_outlined,
  Category.leisure: Icons.local_movies_outlined,
  Category.work: Icons.work_outline_outlined,
};

class Expense {
  //create an Expense object
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid
            .v4(); //add initializer list using the ':' after closing parenthesis
  //uuid package generates unique id to 'id' & assigns it as initial value to the id property whenever this expense class is initialized

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formattedDate {
    return formatter.format(date);
  }
}
