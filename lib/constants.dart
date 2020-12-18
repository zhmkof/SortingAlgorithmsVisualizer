import 'package:flutter/material.dart';

import 'package:algorithms/modals.dart';

const Color primary = Color(0xff1a3e59);
const Color primaryDark = Color(0xff470938);
const Color accent = Color(0xffffffff);
const Color activeData = Color(0xff1DD75F);

///AlgorithmTitles
const String selectionSortTitle = '选择排序';
const String insertionSortTitle = '插入排序';
const String bubbleSortTitle = '冒泡排序';

///ComplexityString
const bigOh = 'O';
const logN = 'log(n)';
const nsquare = 'n2';
const logNsquare = 'log(n2)';

///Algorithms
final List<SortingAlgorithm> sortingAlgorithmsList = [
	///https://www.geeksforgeeks.org/bubble-sort/
  SortingAlgorithm(
    title: selectionSortTitle,
    complexity: nsquare,
    resources: [],
  ),
	///https://www.geeksforgeeks.org/bubble-sort/
  SortingAlgorithm(
    title: insertionSortTitle,
    complexity: nsquare,
    resources: [],
  ),
	///https://www.geeksforgeeks.org/bubble-sort/
  SortingAlgorithm(
    title: bubbleSortTitle,
    complexity: logNsquare,
    resources: [],
  ),
];
