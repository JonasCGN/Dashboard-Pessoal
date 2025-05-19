import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'dart:convert';
import 'dart:io';

class Balance {
	final int month;
	final int year;
	final double amount;
	Transactions transactions = Transactions(transactions: []);

	Balance({
			required this.month,
			required this.year,
			required this.amount,
	});
	
	void addTransaction(Transaction transaction) {
		transactions.addTransaction(transaction);
	}

	void removeTransaction(int id) {
		transactions.removeTransaction(id);
	}

	void updateTransaction(int id, Transaction updatedTransaction) {
		transactions.updateTransaction(id, updatedTransaction);
	}

	void clearTransactions() {
		transactions.clearTransactions();
	}

	Transaction? getTransaction(int id) {
		return transactions.getTransaction(id);
	}

	List<Transaction> getAllTypeTransactions(TransactionType type) {
		return transactions.getAllTypeTransactions(type);
	}

	double getTotalAmountDate(int month, int year) {
		return transactions.getTotalAmountDate(month, year);
	}

	Map<String, dynamic> toJson() {
		return {
			'month': month,
			'year': year,
			'amount': amount,
			'transactions': transactions.toJson(),
		};
	}

	static Balance fromJson(Map<String, dynamic> json) {
		return Balance(
			month: json['month'],
			year: json['year'],
			amount: json['amount'],
		)..transactions = Transactions.fromJson(json['transactions']);
	}
}

class BalanceList {
	final DateTime currentDate = DateTime.now();
	late final List<Balance> balances;

	void initialize() {
		balances = List.generate(
			96,
			(index) => Balance(
				month: (index % 12) + 1,
				year: DateTime.now().year + (index ~/ 12),
				amount: 0.0,
			),
		);
	}

	Balance getBalance(int month, int year) {
		return balances.firstWhere(
			(balance) => balance.month == month && balance.year == year,
			orElse: () => Balance(month: month, year: year, amount: 0.0),
		);
	}

	void addTransaction(int month, int year, Transaction transaction) {
		final balance = getBalance(month, year);
		balance.addTransaction(transaction);
	}

	void removeTransaction(int month, int year, int id) {
		final balance = getBalance(month, year);
		balance.removeTransaction(id);
	}

	void updateTransaction(int month, int year, int id, Transaction updatedTransaction) {
		final balance = getBalance(month, year);
		balance.updateTransaction(id, updatedTransaction);
	}

	void clearTransactions(int month, int year) {
		final balance = getBalance(month, year);
		balance.clearTransactions();
	}

	double getTotalAmountDate(int month, int year) {
		final balance = getBalance(month, year);
		return balance.getTotalAmountDate(month, year);
	}

	List<Transaction> getAllTypeTransactions(int month, int year, TransactionType type) {
		final balance = getBalance(month, year);
		return balance.getAllTypeTransactions(type);
	}

	List<Balance> getAllBalances() {
		return balances;
	}

	Balance getCurrentBalance() {
		return getBalance(currentDate.month, currentDate.year);
	}

	Balance getPreviousBalance() {
		final previousDate = DateTime(currentDate.year, currentDate.month - 1);
		return getBalance(previousDate.month, previousDate.year);
	}

	Balance getNextBalance() {
		final nextDate = DateTime(currentDate.year, currentDate.month + 1);
		return getBalance(nextDate.month, nextDate.year);
	}

	Balance getBalanceByIndex(int index) {
		if (index < 0 || index >= balances.length) {
			throw RangeError('Index out of range');
		}
		return balances[index];
	}

	Balance getBalanceByDate(DateTime date) {
		return getBalance(date.month, date.year);
	}

	// Save balances to a JSON file
	Future<void> saveToFile(String filePath) async {
		final file = File(filePath);
		final jsonData = jsonEncode(balances.map((balance) => balance.toJson()).toList());
		await file.writeAsString(jsonData);
	}

	// Load balances from a JSON file
	Future<void> loadFromFile(String filePath) async {
		final file = File(filePath);
		if (await file.exists()) {
			final jsonData = await file.readAsString();
			final List<dynamic> decodedData = jsonDecode(jsonData);
			balances = decodedData.map((data) => Balance.fromJson(data)).toList();
		} else {
			initialize(); // Initialize if file doesn't exist
		}
	}
}