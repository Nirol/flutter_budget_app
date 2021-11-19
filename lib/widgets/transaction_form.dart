import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// IMPORTANT: we need to convert this widget to stateful in order for the form data to be saved during its fillment
// reason is Flutter internal re rendering and managements deletes the data in a Stateless widget.
// With a stateful widget, the data is kept sepreatly from the wdiget, and the form data is not deleted !

class TransactionForm extends StatefulWidget {
  final Function(String, double, DateTime) newTxHandler;

  TransactionForm(this.newTxHandler);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime _selectedDate;

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1997),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _submitTransaction() {
    final title = _titleController.text;
    final amount = double.parse(_amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }

    // use a field received with the widget constructuor outside the state
    widget.newTxHandler(title, amount, _selectedDate);

    // pop the new transaction form off the screen after new tx
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _submitTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitTransaction(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Picked date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                  Expanded(
                    child: TextButton(
                        style: TextButton.styleFrom(primary: Colors.amber),
                        child: Text('Choose date',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: _presentDatePicker),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _submitTransaction,
              child: Text('Add Transaction',
                  style: TextStyle(color: Colors.white)),
              style: TextButton.styleFrom(
                primary: Colors.amber,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
