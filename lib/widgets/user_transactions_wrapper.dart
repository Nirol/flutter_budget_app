import 'package:flutter/material.dart';
import './transaction_form.dart';
import './transactions_widget.dart';
import '../models/transaction_model.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: 't1', title: 'new sheoes', amount: 16.12, date: DateTime.now()),
    Transaction(id: 't2', title: 'new watch', amount: 62, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final newTransaction = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTransaction);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        TransactionForm(_addNewTransaction),
        Transactions(_userTransactions),
      ],
    );
  }
}
