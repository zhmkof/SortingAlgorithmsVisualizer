import 'package:algorithms/constants.dart';
import 'package:algorithms/sorting_details.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '算法可视化',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: primary,
          primaryColorDark: primaryDark,
          canvasColor: Colors.transparent),
      home: SortDetailsScreen(),
    );
  }
}
