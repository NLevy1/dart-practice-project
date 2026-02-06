import 'package:csv/csv.dart';
import 'dart:io';
import 'package:dart_practice_projects_functions/dart_practice_projects_functions.dart';

void main() async {
  final file = File('data.csv');

  if (!await file.exists()) {
    print('Error: data.csv not found');
    return;
  }

  List<Transaction> cleanData = await loadData();

  print('Loaded ${cleanData.length} rows.');

  if (cleanData.isNotEmpty) {
    var groceries = cleanData.where((t) => t.category == 'Groceries');
    print('Grocery Transactions: ${groceries.length}');
  }
}
