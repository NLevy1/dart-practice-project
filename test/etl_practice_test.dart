import 'package:dart_practice_projects/dart_practice_projects_functions.dart';
import 'package:test/test.dart';
import 'dart:io';

void main() {
  group('Transaction', () {
    test('creates transaction with all fields', () {
      final transaction = Transaction(
        id: 'TXN_001',
        amount: 45.50,
        category: 'Groceries',
      );

      expect(transaction.id, 'TXN_001');
      expect(transaction.amount, 45.50);
      expect(transaction.category, 'Groceries');
    });

    test('toString returns formatted string', () {
      final transaction = Transaction(
        id: 'TXN_001',
        amount: 45.50,
        category: 'Groceries',
      );

      expect(
        transaction.toString(),
        'Transaction(id: TXN_001, amount: 45.5, category: Groceries)',
      );
    });
  });

  group('loadData', () {
    test('loads and parses CSV file correctly', () async {
      final transactions = await loadData();

      expect(transactions, isNotEmpty);
      expect(transactions.length, greaterThan(0));

      // Check first transaction
      final first = transactions.first;
      expect(first.id, 'TXN_001');
      expect(first.amount, 45.50);
      expect(first.category, 'Groceries');
    });

    test('skips header row', () async {
      final transactions = await loadData();

      // Verify no transaction has "id" as its id (which would be the header)
      expect(transactions.any((t) => t.id == 'id'), isFalse);
    });

    test('handles negative amounts', () async {
      final transactions = await loadData();

      // Find the transaction with negative amount
      final negativeTransaction = transactions.firstWhere(
        (t) => t.amount < 0,
        orElse: () => throw Exception('No negative transaction found'),
      );

      expect(negativeTransaction.amount, -12.00);
      expect(negativeTransaction.category, 'Entertainment');
    });

    test('handles empty category field', () async {
      final transactions = await loadData();

      // Find transaction with empty category (TXN_003)
      final emptyCategory = transactions.firstWhere(
        (t) => t.id == 'TXN_003',
        orElse: () => throw Exception('TXN_003 not found'),
      );

      expect(emptyCategory.category, '');
    });

    test('parses all valid rows from CSV', () async {
      final transactions = await loadData();

      // Should have at least the valid rows (excluding invalid ones)
      expect(transactions.length, greaterThanOrEqualTo(4));

      // Verify specific transactions exist
      final ids = transactions.map((t) => t.id).toList();
      expect(ids, contains('TXN_001'));
      expect(ids, contains('TXN_002'));
      expect(ids, contains('TXN_003'));
      expect(ids, contains('TXN_005'));
    });
  });

  group('CSV parsing edge cases', () {
    test('handles transactions with same ID', () async {
      final transactions = await loadData();

      // TXN_001 appears twice in the CSV
      final tx001Transactions = transactions
          .where((t) => t.id == 'TXN_001')
          .toList();
      expect(tx001Transactions.length, greaterThanOrEqualTo(1));
    });
  });
}
