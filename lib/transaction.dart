import 'package:flutter/material.dart';
class Transaction{
  String content;
  double amount;
  DateTime? createdDate;
  Transaction({required this.content, required this.amount});

  @override
  String toString() {
    // TODO: implement toString
    return 'content :$content, amount: $amount';
  }
}