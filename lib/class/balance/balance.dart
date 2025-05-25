import 'package:dashboard_pessoal/class/category/category.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'dart:convert';
import 'dart:io';

import 'package:faker/faker.dart';

class Balance {
	final int month;
	final int year;
	double amount;
	Transactions transactions = Transactions(transactions: []);

	Balance({
			required this.month,
			required this.year,
			required this.amount,
	});
	
	void addTransaction(Transaction transaction) {
		transactions.addTransaction(transaction);
		getTotalAmountDate();
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

	double getTotalAmountTypeDate(TransactionType type){
		return transactions.getTotalAmountDateType(type, month, year);
	}

	double getTotalAmountDate() {
		amount = transactions.getTotalAmountDate();
		return amount;
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
	DateTime currentDate = DateTime.now();
	Categories categories = Categories();
	late final List<Balance> balances;

	void addFakeTransactions(bool createFakeTransitcitons) {

		if(createFakeTransitcitons){
			final faker = Faker();
			for (int i = 0; i < 100; i++) {
				DateTime dateVenc = faker.date.dateTime(minYear: 2025, maxYear: 2028);
				DateTime dateLanc = faker.date.dateTime(minYear: 2025, maxYear: 2028);
				final transaction = Transaction(
					id: faker.randomGenerator.integer(1000),
					description: faker.lorem.sentence(),
					amount: faker.randomGenerator.decimal(scale: 1000),
					dateVenc: dateVenc,
					dateLanc: dateLanc,
					type: faker.randomGenerator.boolean() ? TransactionType.expense : TransactionType.revenue,
					process: faker.randomGenerator.boolean() ? EfitevedTransaction.loading : EfitevedTransaction.finished,
					category: faker.randomGenerator.integer(categories.categories.keys.length),
				);
				addTransaction(transaction);
			}
		}
	}

	void initialize(int yearsAhead,int yearsBehind) {
		balances = List.generate(
			(yearsAhead + yearsBehind + 1) * 12,
			(index) {
				final yearOffset = (index ~/ 12) - yearsBehind;
				final month = (index % 12) + 1;
				final year = currentDate.year + yearOffset;
				return Balance(
					month: month,
					year: year,
					amount: 0.0,
				);
			},
		);
	}

	Balance getBalance(int month, int year) {
		return balances.firstWhere(
			(balance) => balance.month == month && balance.year == year,
			orElse: () => Balance(month: month, year: year, amount: 0.0),
		);
	}

	void addTransaction(Transaction transaction) {
		final balance = getBalance(transaction.dateVenc.month, transaction.dateVenc.year);
		balance.addTransaction(transaction);
	}

	void removeTransaction(int month, int year, int id) {
		final balance = getBalance(month, year);
		balance.removeTransaction(id);
	}

	void updateTransaction(int oldMonth, int oldYear, int id, Transaction updatedTransaction) {
		final oldBalance = getBalance(oldMonth, oldYear);
		oldBalance.removeTransaction(id);

		final newBalance = getBalance(updatedTransaction.dateVenc.month, updatedTransaction.dateVenc.year);
		newBalance.addTransaction(updatedTransaction);
	}

	void clearTransactions(int month, int year) {
		final balance = getBalance(month, year);
		balance.clearTransactions();
	}

	double getTotalAmountDate(int month, int year) {
		final balance = getBalance(month, year);
		return balance.getTotalAmountDate();
	}

	List<Transaction> getAllTypeTransactions(int month, int year, TransactionType type) {
		final balance = getBalance(month, year);
		final transactions = balance.getAllTypeTransactions(type);
		transactions.sort((a, b) => a.dateVenc.compareTo(b.dateVenc));
		return transactions;
	}

	List<Balance> getAllBalances() {
		return balances;
	}

	List<Transaction> getRecentTransactions(int qtd) {
		final allTransactions = balances
			.expand((balance) => balance.transactions.transactions)
			.where((transaction) => transaction.dateVenc.isBefore(currentDate) || transaction.dateVenc.isAtSameMomentAs(currentDate))
			.toList();

		allTransactions.sort((a, b) => b.dateVenc.compareTo(a.dateVenc));

		return allTransactions.take(qtd).toList();
	}

	Balance getCurrentBalance() {
		Balance balance = getBalance(currentDate.month, currentDate.year);
		// print(balance.amount);

		return balance;
	}

	Balance getTodayBalance() {
		currentDate = DateTime.now();
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
			initialize(10,10); // Initialize if file doesn't exist
		}
	}
}