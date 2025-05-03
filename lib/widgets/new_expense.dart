import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

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

  void _submitForm() {
    final enteredAmount = double.tryParse(_amountController
        .text); //takes string as an input, returns double if its able to convert that string to a double, returns null otherwise
    //tryParse('Hello') => null, tryParse ('1.12') => 1.12
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      //show error message
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid input'),
          content: Text(
              'Please ensure a valid title, amount, date and category was entered.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text(
                'Okay',
              ),
            ),
          ],
        ),
      );
      return; //this ensures that no function after this return statement is returned will be executed.
      //so if user enters this if statement and reaches this return; , any functions after this if statement wont be executed.
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
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 48, 16, 16),
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
                onPressed: _submitForm,
                child: Text('Save Expense'),
              ),
            ],
          )
        ],
      ),
    );
  }
}
