import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  final Function deleteTx;


  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 450,
        child: transactions.isEmpty
            ? Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      "No Transaction added yet",
                      style: Theme.of(context).textTheme.caption,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                        height: 200,
                        child: Image.asset(
                          "assets/images/waiting.jpg",
                          fit: BoxFit.cover,
                        ))
                  ],
                ),
              )
            : ListView(
                children: transactions.map((tx) {
                  return Card(
                      margin: EdgeInsets.all(10),
                      child: ListTile(
                          leading: CircleAvatar(
                              radius: 30,
                              child: Padding(
                                padding: const EdgeInsets.all(6),
                                child: FittedBox(
                                  child: Text("\$${tx.amount}"),
                                ),
                              )),
                          title: Text(
                            tx.title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          subtitle: Text(DateFormat.yMMMd().format(tx.date)),
                          trailing: IconButton(
                            onPressed: ()=> deleteTx(tx.id),
                              icon: Icon(Icons.delete),
                              color: Theme.of(context).errorColor)));
                }).toList(),
              ));
  }
}
