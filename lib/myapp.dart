import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'transaction.dart';
import 'TransactionList.dart';

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  Transaction _transaction = Transaction(content: '', amount: 0.0);
  List<Transaction> _transactions = <Transaction>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    print("Ken Run iniState");
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    print("Ken  Run Dispose()");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // TODO: implement didChangeAppLifecycleState
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print("Ken App is in Background mode");
    } else if (state == AppLifecycleState.resumed) {
      print("Ken App is in ForeGround Mode");
    }
  }
void _insertTransaction(){
    if (_transaction.content.isEmpty ||
    _transaction.amount ==0.0 ||
    _transaction.amount.isNaN
    ){
      return;
    }
  _transactions.add(_transaction);
  _transaction = Transaction(content: "", amount: 0.0);
  _contentController.text = '';
  _amountController.text = '';
}
//mainAxisAlignment: MainAxisAlignment.center,
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ken This is StateFulWidget123',
      home: Scaffold(
        appBar:AppBar(
          title: const Text("Transaction Manager"),
          actions: [
            IconButton(onPressed: (){
              setState(() {
                this._insertTransaction();
              });
             }, icon: Icon(Icons.add)
            )],
      ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          setState(() {
            this._insertTransaction();
          });
        },
          tooltip: "Add transaction",
          child: Icon(Icons.add),
        ),
        key: _scaffoldKey,
        body: SafeArea(
          minimum: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                  labelText: "Content",
                ),
                controller: _contentController,
                onChanged: (text) {
                  setState(() {
                    _transaction.content = text;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount(money)'),
                controller: _amountController,
                onChanged: (text) {
                  setState(() {
                    _transaction.amount = double.tryParse(text) ?? 0.0;
                  });
                },
              ),
              Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
              ButtonTheme(
                height: 60,
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      this._insertTransaction();
                    });

                  },
                  child: Text(
                    'Insert Transaction',
                    style: TextStyle(fontSize: 20),
                  ),
                  textColor: Colors.white,
                  color: Colors.amber,
                ),
              ),
              TransactionList(transactionss:_transactions)
            ]),
          )
        ),
      ),
    );
  }
}
