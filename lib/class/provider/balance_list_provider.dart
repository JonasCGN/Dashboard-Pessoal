import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_pessoal/class/balance/balance.dart';

class BalanceListProvider extends ChangeNotifier {
	late BalanceList _balanceList;

	BalanceListProvider() {
		_balanceList = BalanceList();
		_balanceList.initialize(10, 10);
		// _balanceList.addFakeTransactions(true);
	}

	BalanceList get balanceList => _balanceList;

	List<Balance> get allBalances => _balanceList.getAllBalances();

	Balance get currentBalance => _balanceList.getBalance(_balanceList.currentDate.month, _balanceList.currentDate.year);
	

	void todayBalance() {
		_balanceList.currentDate = DateTime.now();
		notifyListeners();
	}

	void previousBalance() {
		final prev = DateTime(_balanceList.currentDate.year, _balanceList.currentDate.month - 1);
		_balanceList.currentDate = prev;
		notifyListeners();
	}

	void nextBalance() {
		final next = DateTime(_balanceList.currentDate.year, _balanceList.currentDate.month + 1);
		_balanceList.currentDate = next;
		notifyListeners();
	}

	void addTransaction(Transaction transaction) {
		_balanceList.addTransaction(transaction);
		notifyListeners();
	}

	void removeTransaction(int month, int year, int id) {
		_balanceList.removeTransaction(month, year, id);
		notifyListeners();
	}

	void updateTransaction(int month, int year, int id, Transaction updatedTransaction) {
		_balanceList.updateTransaction(month, year, id, updatedTransaction);
		notifyListeners();
	}

	void clearTransactions(int month, int year) {
		_balanceList.clearTransactions(month, year);
		notifyListeners();
	}

	double getTotalAmountDate(int month, int year) {
		return _balanceList.getTotalAmountDate(month, year);
	}

	List<Transaction> getAllTypeTransactions(int month, int year, TransactionType type) {
		return _balanceList.getAllTypeTransactions(month, year, type);
	}

	double getTotalAmountMonth(int month, int year, TransactionType type){
		Balance balance = balanceList.getBalance(month, year);
		double total = balance.getTotalAmountTypeDate(type);
		return total;
	}

	List<Transaction> getRecentTransactions(int qtd) {
		return _balanceList.getRecentTransactions(qtd);
	}

	Future<void> saveToFile(String filePath) async {
		await _balanceList.saveToFile(filePath);
	}

	Future<void> loadFromFile(String filePath) async {
		await _balanceList.loadFromFile(filePath);
		notifyListeners();
	}
}
