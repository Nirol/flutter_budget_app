import 'package:flutter/material.dart';

class TransactionForm extends StatelessWidget {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  final Function(String, double) newTxHandler;

  void submitTransaction() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0) {
      return;
    }
    newTxHandler(title, amount);
  }

  TransactionForm(this.newTxHandler);
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
