
import 'dart:io';

import 'package:expenseapp/widgets/new_transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';


import 'models/transaction.dart';
import './widgets/transaction_list.dart';
import 'widgets/new_transaction.dart';
import './widgets/chart.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]);
//   runApp(const MyApp());
// }

void main() {
  runApp(const MyApp());
}
  

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FExpense App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        errorColor:  Colors.red,
        accentColor: Colors.amber,
        fontFamily:'Quicksand',
        appBarTheme: AppBarTheme(
         textTheme: ThemeData.light().textTheme.copyWith(
           headline1: TextStyle(
             fontFamily: 'OpenSans',
              fontSize: 20,
         ),
         button: TextStyle(
           color: Colors.white
         )
        
         )
      ),
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

    final List<Transaction> _userTransactions = [];


  bool _showChart =  false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
        assert(tx != null);
        return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
 }


  void _addNewTransaction(String title, double amount, DateTime  choosenDate) {
    final newTx = Transaction(
        title: title,
        amount: amount,
        date:   choosenDate,
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

  void _deleteTransaction(String id){
    setState(() {
      _userTransactions.removeWhere((tx){
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
          title: const Text("Expense App", style: TextStyle(fontFamily: 'OPenSans'),),
          actions: [
            IconButton(icon: Icon(Icons.add),
            onPressed:()=> _startAddNewTransaction(context),)
          ],
        );

    final txList  = Container(
              height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.8,
             child: TransactionList(_userTransactions, _deleteTransaction));

    final chart = Container(
                    height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.8,
                    child: Chart(_recentTransactions));
    
    

    return  Scaffold(
        appBar: appBar,
        body:SingleChildScrollView(child: 
         Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
              if(isLandscape)  Row(children: <Widget>[
                const Text("SHow Chart"),
                Switch.adaptive(
                  activeColor: Theme.of(context).accentColor,
                  value: _showChart, 
                  onChanged: (val){
                   
                    setState(() {
                      _showChart = val;
                    });
                }),
              ],
            ), 
            if(!isLandscape) Container(
                    height: (mediaQuery.size.height - appBar.preferredSize.height - mediaQuery.padding.top) * 0.3,
                    child: Chart(_recentTransactions)),

            if(!isLandscape) txList,

            if( isLandscape) _showChart ? Container(
              width: double.infinity,
              child: chart
            )
            : txList]
         
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Platform.isIOS ? Container() :  FloatingActionButton(onPressed:()=> _startAddNewTransaction(context),
        child: Icon(Icons.add)),
        );
  }
  
}