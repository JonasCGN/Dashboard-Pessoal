enum TransactionType {
	expense,
	revenue,
}

enum EfitevedTransaction{
	loading,
	finished,
}


class Transaction{
	int? id;
	final String description;
	final double amount;
	final DateTime dateVenc;
	final DateTime dateLanc;
	final TransactionType type;
	final EfitevedTransaction process;
	final int category;

	Transaction({
		this.id,
		required this.description,
		required this.amount,
		required this.dateVenc,
		required this.dateLanc,
		required this.type, 
		required this.process,
		required this.category,
	});
}

class Transactions {
	late final List<Transaction> transactions;
	static int idTransaction = 0;

	Transactions({
		required this.transactions
	});

	void addTransaction(Transaction transaction) {
		transaction.id = 0;
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

	double getTotalAmountDate() {
		double total = 0.0;

		total = transactions
			.map((transaction) => transaction.type == TransactionType.revenue 
				? transaction.amount 
				: -transaction.amount)
			.fold(0.0, (sum, amount) => sum + amount);

		return total;
	}

	double getTotalAmountDateType(TransactionType type, int month, int year) {
		double total = 0.0;
		total = transactions
			.where((transaction) => transaction.type == type && transaction.dateVenc.month == month && transaction.dateVenc.year == year)
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
				'dateVenc': transaction.dateVenc.toIso8601String(),
				'dateLanc': transaction.dateLanc.toIso8601String(),
				'type': transaction.type == TransactionType.expense ? 'expense' : 'revenue',
				'process': transaction.process == EfitevedTransaction.loading ? 'loading' : 'finished',
				'category': transaction.category,
			}).toList(),
		};
	}
	
	static Transactions fromJson(Map<String, dynamic> json) {
		List<Transaction> transactions = (json['transactions'] as List).map((transactionJson) {
			return Transaction(
				id: transactionJson['id'],
				description: transactionJson['description'],
				amount: transactionJson['amount'],
				dateVenc: DateTime.parse(transactionJson['dateVenc']),
				dateLanc: DateTime.parse(transactionJson['dateLanc']),
				type: transactionJson['type'] == 'expense' ? TransactionType.expense : TransactionType.revenue,
				process: transactionJson['process'] == 'loading' ? EfitevedTransaction.loading : EfitevedTransaction.finished,
				category: transactionJson['category'],
			);
		}).toList();

		return Transactions(transactions: transactions);
	}
}