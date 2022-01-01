import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionListItem extends StatefulWidget {
  const TransactionListItem(
      {Key? key, required this.deleteTx, required this.transaction})
      : super(key: key);

  final Function deleteTx;
  final List<Transaction> transaction;

  @override
  State<TransactionListItem> createState() => _TransactionListItemState();
}

class _TransactionListItemState extends State<TransactionListItem> {
  
  Color _bgColor = Colors.purple;

  @override
  void initState() {
    const availableColors = [
      Colors.red,
      Colors.black,
      Colors.orange,
      Colors.blue,
      Colors.purple
    ];
  _bgColor = availableColors[Random().nextInt(5)];
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: widget.transaction.map((tx) {
        return Card(
          margin: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: _bgColor,
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
            trailing: MediaQuery.of(context).size.width > 360
                ? FlatButton.icon(
                    icon: const Icon(Icons.delete),
                    textColor: Theme.of(context).errorColor,
                    label: const Text("Delete"),
                    onPressed: () => widget.deleteTx(tx.id),
                  )
                : IconButton(
                    onPressed: () => widget.deleteTx(tx.id),
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).errorColor),
          ),
        );
      }).toList(),
    );
  }
}
