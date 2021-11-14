import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/widgets/chart_bar.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);
  double get getWeekSpendings {
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + item['amount'];
    });
  }

  List<Map<String, Object>> get groupedTransactionsValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum += transactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupedTransactionsValues.map(
          (txData) {
            return ChartBar(
                txData['day'],
                txData['amount'],
                (getWeekSpendings == 0.0 ? 0.0 : txData['amount'] as double) /
                    getWeekSpendings);
          },
        ).toList(),
      ),
    );
  }
}
