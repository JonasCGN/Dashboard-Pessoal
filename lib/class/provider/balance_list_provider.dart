import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_pessoal/class/balance/balance.dart';

class BalanceListProvider extends ChangeNotifier {
	late BalanceList _balanceList;

	BalanceListProvider() {
		_balanceList = BalanceList();
		_balanceList.initialize();
		_balanceList.addFakeTransactions(true);
	}

	BalanceList get balanceList => _balanceList;

	List<Balance> get allBalances => _balanceList.getAllBalances();

	Balance getBalance(int index){
		switch (index) {
			case -1:
				return _balanceList.getPreviousBalance();
			case 1:
				return _balanceList.getNextBalance();
			default:
				return _balanceList.getCurrentBalance();
		}
	}

  	Balance todayBalance() {
		final balance = _balanceList.todayBalance();
		notifyListeners();
		return balance;
	}

	Balance previousBalance() {
		final previousBalance = _balanceList.previousBalance();
		notifyListeners();
		return previousBalance;
	}

	Balance nextBalance() {
		final nextBalance = _balanceList.nextBalance();
		notifyListeners();
		return nextBalance;
	}

	void addTransaction(int month, int year, Transaction transaction) {
		_balanceList.addTransaction(month, year, transaction);
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
