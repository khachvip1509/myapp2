import 'package:flutter/material.dart';

import 'myapp.dart';

void main() {
  runApp(MaterialApp(
    title: "Transaction App",
    theme: ThemeData(
      primaryColor: Colors.green[300],
      accentColor: Colors.pink[200]
    ),
    home: MyApp(),
  ));
}
