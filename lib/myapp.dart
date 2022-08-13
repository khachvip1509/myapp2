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
    _transaction.createdDate =DateTime.now();
    _transactions.add(_transaction);
    _transaction = Transaction(content: "", amount: 0.0);
    _contentController.text = '';
    _amountController.text = '';
}

void _onButtonShowModalSheet(){
    showModalBottomSheet(context: this.context,
        builder: (context){
          return Column(
            children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
              Container(
                padding: EdgeInsets.all(10),
                child:TextField(
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
              ),
              Container(
              padding: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(labelText: 'Amount(money)'),
                  controller: _amountController,
                  onChanged: (text) {
                    setState(() {
                      _transaction.amount = double.tryParse(text) ?? 0.0;
                    });
                  },
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10,right: 10, top: 30,bottom: 20),
                child:  Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: SizedBox(child: RaisedButton(onPressed: (){
                      print("Press Save");
                      setState(() {
                        this._insertTransaction();
                      });
                      Navigator.of(context).pop();
                    },child: Text('Save',style: TextStyle(fontSize: 16,color: Colors.white),),
                      color: Colors.green,
                    ), height: 50,),),
                  Padding(padding: EdgeInsets.all(10)),
                  Expanded(child: SizedBox(child: RaisedButton(color: Colors.red,onPressed: (){
                    print("Press cancel");
                    Navigator.of(context).pop();
                  },child: Text('Cancel',style: TextStyle(fontSize: 16,color: Colors.white)),),height: 50,)
                    ,)

                ],
              ),)
            ],
          );
        });
}

//mainAxisAlignment: MainAxisAlignment.center,
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: const Text("Transaction Manager"),
        actions: [
          IconButton(onPressed: (){
            this._onButtonShowModalSheet();
          }, icon: Icon(Icons.add)
          )],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        this._onButtonShowModalSheet();
      },
        tooltip: "Add transaction",
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      key: _scaffoldKey,
      body: SafeArea(
          minimum: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(padding: const EdgeInsets.symmetric(vertical: 20)),
              ButtonTheme(
                height: 60,
                child: FlatButton(
                  onPressed: () {
                    this._onButtonShowModalSheet();
                  },
                  child: Text(
                    'Insert Transaction',
                    style: const TextStyle(fontSize: 20, fontFamily:'Indie_Flower',),
                  ),
                  textColor: Colors.white,
                  color: Colors.amber,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(20)),
                  Text("Tong :",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold ),),
                ],
              ),
              TransactionList(transactionss:_transactions)
            ]),
          )
      ),
    );
  }
}
