import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _saveTitleInput(String inputValue) { //takes inputValue as input parameter
  //   _enteredTitle = inputValue;
  // }

  final _titleController =
      TextEditingController(); //the value stored in this _titleController property will be an object created with TEC
  //creates an object optimized for handling user input. this object is passed as a value to TF to let Flutter store the entered value
  //when TEC is created, u have to tell FLutter to delete the controller when the widget isn't needed anymore.
  final _amountController = TextEditingController();

  DateTime? _selectedDate; // since type is defined, so omit 'var'
  //_selectedDate will either be of DateTime value or null.
  Category _selectedCategory = Category.leisure;

  void _openDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);

    final pickedDate = await showDatePicker(
      context: context,
      firstDate: firstDate,
      lastDate: now,
    );
    // .then(
    //   (value) {
    //     //this fn will execute once and it will get the 'value', once it has been picked from showDatePicker.
    //   },
    // ); or u can use async-await
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            // onChanged: _saveTitleInput,
            controller: _titleController,
            maxLength: 50,
            decoration: InputDecoration(
              label: Text('Title'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  // onChanged: _saveTitleInput,
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text('Amount'),
                    prefixText: '\$ ',
                  ),
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _selectedDate == null
                          ? 'No date is picked'
                          : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                      onPressed: _openDatePicker,
                      icon: Icon(Icons.calendar_month_outlined),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map(
                        (category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    // log(value.toString());
                    if (value == null) {
                      return;
                    }
                    setState(() {
                      _selectedCategory = value;
                    });
                  }),
              Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  log(_titleController.text);
                  log(_amountController.text);
                },
                child: Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
