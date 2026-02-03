import 'package:csv/csv.dart';
import 'dart:io';

class Transaction {
    final String id;
    final double amount;
    final String category;

    Transaction({required this.id, required this.amount, required this.category});

    @override
    String toString() {
        return 'Transaction(id: $id, amount: $amount, category: $category)';
    }
}

Future<List<Transaction>> loadData() async {
  final file = File('data.csv');
  final rawString = await file.readAsString();

  List<List<dynamic>> rows = const CsvToListConverter(eol: '\n',).convert(rawString);
  
  List<Transaction> cleanData = rows.skip(1).map((row) {
    print('Processing row: $row (length: ${row.length})');
    final transaction = Transaction(
        id: row[0].toString(),
        amount: double.parse(row[1].toString()),
        category: row[2].toString(),
    );
    return transaction;
    }).toList();
  
  return cleanData;
}