import 'package:expenseapp/widgets/transactionListItem.dart';
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
        height: MediaQuery.of(context).size.height * 0.6,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraint){
              return  Center(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      "No Transaction added yet",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                        height: constraint.maxHeight * 0.6,
                        child: Image.asset(
                          "assets/images/waiting.jpg",
                          fit: BoxFit.cover,
                        ))
                  ],
                ),
              );
            })
           
            : 
            // ListView(
            //     children: transactions.map((tx) {
            //       return TransactionListItem(deleteTx: deleteTx, transaction: transactions);
            //     }).toList(),
            //   ),

            TransactionListItem(deleteTx: deleteTx, transaction: transactions)
              );
  }
}

