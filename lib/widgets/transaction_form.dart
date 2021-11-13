import 'package:flutter/material.dart';

// IMPORTANT: we need to convert this widget to stateful in order for the form data to be saved during its fillment
// reason is Flutter internal re rendering and managements deletes the data in a Stateless widget.
// With a stateful widget, the data is kept sepreatly from the wdiget, and the form data is not deleted !

class TransactionForm extends StatefulWidget {
  final Function(String, double) newTxHandler;

  TransactionForm(this.newTxHandler);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitTransaction() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }

    // use a field received with the widget constructuor outside the state
    widget.newTxHandler(title, amount);

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
              controller: titleController,
              onSubmitted: (_) => submitTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitTransaction(),
            ),
            TextButton(
              onPressed: submitTransaction,
              child: Text('Add Transaction'),
              style: TextButton.styleFrom(
                primary: Colors.purple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
