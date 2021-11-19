import 'package:expenseapp/widgets/new_transaction.dart';
import 'package:flutter/material.dart';


import 'models/transaction.dart';
import './widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FExpense App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber, 
      ),
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({ Key? key }) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

    final List<Transaction> _userTransactions = [
    Transaction(
      id: 't1',
      title: 'new shoes',
      amount: 69.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 't2',
      title: 'some tshirts',
      amount: 300.67,
      date: DateTime.now(),
    )
  ];

  void _addNewTransaction(String title, double amount) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });

  }
  void _startAddNewTransaction(BuildContext context){
    showModalBottomSheet(
      context: context, 
      builder: (bCtx){
        return GestureDetector(
          onTap:(){},
          child:NewTransaction( _addNewTransaction),
          behavior: HitTestBehavior.opaque
        );
      },);
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text("Expense App"),
          actions: [
            IconButton(icon: Icon(Icons.add),
            onPressed:()=> _startAddNewTransaction(context),)
          ],
        ),
        body:SingleChildScrollView(child: 
         Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child:
                  Card(child: Text("Chart"), elevation: 5, color: Colors.blue),

            ),
           TransactionList(_userTransactions)],
         
        )),


        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(onPressed:()=> _startAddNewTransaction(context),
        child: Icon(Icons.add)),
        );
  }
  
}