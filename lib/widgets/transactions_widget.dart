import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import 'package:intl/intl.dart';

class Transactions extends StatelessWidget {
  final List<Transaction> transacations;

  Transactions(this.transacations);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
        itemBuilder: (ctx, index) {
          return Card(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text(
                      '\$${transacations[index].amount.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.purple,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        transacations[index].title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        DateFormat.yMMMd().format(transacations[index].date),
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                ]),
          );
        },
        itemCount: transacations.length,
      ),
    );
  }
}
