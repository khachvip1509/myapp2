import 'package:flutter/material.dart';
import 'package:myapp2/transaction.dart';
class TransactionList extends StatelessWidget {
  final List<Transaction> transactionss;

  TransactionList({required this.transactionss});
  ListView _buildListView(){
    return ListView.builder(
        itemCount: transactionss.length,
        itemBuilder: (context,index){
          return Card(
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)) ,
          color: (index -1)%2==0 ? Colors.pink:Colors.green,
          elevation: 10,
          child: ListTile(
            leading: const Icon(Icons.access_alarm),
            title:  Text(transactionss[index].content,style: TextStyle(fontWeight: FontWeight.bold,fontSize:  18),),
            subtitle: Text("Price: +${transactionss[index].amount}", style:  TextStyle(fontSize: 18, color: Colors.white),),
            onTap: () {
              print("you clicked : ${transactionss[index].content}");
            },
          )
      );
      });
    }

  @override
  Widget build(BuildContext context) {
    return  Container(
        height: 500,
        child: _buildListView()
    );
  }
}