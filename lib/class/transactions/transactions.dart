enum TransactionType {
	expense,
	revenue,
}

enum EfitevedTransaction{
	loading,
	finished
}

class Transaction{
	final int id;
	final String description;
	final double amount;
	final DateTime date;
	final TransactionType type;
	final EfitevedTransaction process;

	Transaction({
		required this.id,
		required this.description,
		required this.amount,
		required this.date,
		required this.type, 
		required this.process
	});
	
}

class Transactions {
	late final List<Transaction> transactions;

	Transactions({
		required this.transactions
	});

	void addTransaction(Transaction transaction) {
		transactions.add(transaction);
	}

	void removeTransaction(int id) {
		transactions.removeWhere((transaction) => transaction.id == id);
	}

	void updateTransaction(int id, Transaction updatedTransaction) {
		int index = transactions.indexWhere((transaction) => transaction.id == id);
		if (index != -1) {
			transactions[index] = updatedTransaction;
		}
	}

	void clearTransactions() {
		transactions.clear();
	}

	Transaction? getTransaction(int id) {
		int index = transactions.indexWhere((transaction) => transaction.id == id);
		if (index != -1) {
			return transactions[index];
		}
		return null;
	}

	List<Transaction> getAllTypeTransactions(TransactionType type) {
		return transactions.where((transaction) => transaction.type == type).toList();
	}

	double getTotalAmountDate(int month, int year) {
		double total = 0.0;
		
		total = transactions
			.where((transaction) => transaction.date.month == month && transaction.date.year == year)
			.map((transaction) => transaction.amount)
			.reduce((sum, amount) => sum + amount);

		return total;
	}

	double getTotalAmountDateType(TransactionType type, int month, int year) {
		double total = 0.0;
		total = transactions
			.where((transaction) => transaction.type == type && transaction.date.month == month && transaction.date.year == year)
			.map((transaction) => transaction.amount)
			.fold(0.0, (sum, amount) => sum + amount);

		return total;
	}


	Map<String, dynamic> toJson() {
		return {
			'transactions': transactions.map((transaction) => {
				'id': transaction.id,
				'description': transaction.description,
				'amount': transaction.amount,
				'date': transaction.date.toIso8601String(),
				'type': transaction.type == TransactionType.expense ? 'expense' : 'revenue',
				'process': transaction.process == EfitevedTransaction.loading ? 'loading' : 'finished',
			}).toList(),
		};
	}

	static Transactions fromJson(Map<String, dynamic> json) {
		List<Transaction> transactions = (json['transactions'] as List).map((transactionJson) {
			return Transaction(
				id: transactionJson['id'],
				description: transactionJson['description'],
				amount: transactionJson['amount'],
				date: DateTime.parse(transactionJson['date']),
				type: transactionJson['type'] == 'expense' ? TransactionType.expense : TransactionType.revenue,
				process: transactionJson['process'] == 'loading' ? EfitevedTransaction.loading : EfitevedTransaction.finished,
			);
		}).toList();

		return Transactions(transactions: transactions);
	}

}