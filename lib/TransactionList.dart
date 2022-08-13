import 'package:flutter/material.dart';
import 'package:myapp2/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionss;

  TransactionList({required this.transactionss});

  ListView _buildListView() {
    return ListView.builder(
        itemCount: transactionss.length,
        itemBuilder: (context, index) {
          return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              color: (index - 1) % 2 == 0 ? Colors.pink : Colors.green,
              elevation: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(padding: EdgeInsets.all(10)),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.only(top: 10)),
                      Text(
                        transactionss[index].content,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                      ),
                      Text(
                        "Date: + ${DateFormat.yMd().format(transactionss[index].createdDate!)}",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      Padding(padding: EdgeInsets.only(bottom: 10)),
                    ],
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        padding:const EdgeInsets.all(10),
                        child: Text(
                          '${transactionss[index].amount}\$',
                          style: TextStyle(fontSize: 18, color: Colors.lime),
                        ),
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.white,width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                      Padding(padding: EdgeInsets.only(right: 10)),
                    ],
                  ))
                ],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 500, child: _buildListView());
  }
}
