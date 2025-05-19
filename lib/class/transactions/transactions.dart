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
	
	void __showTransaction() {
		print('ID: $id');
		print('Descrição: $description');
		print('Valor: $amount');
		print('Data: ${date.toLocal()}');
		print('Tipo: ${type == TransactionType.expense ? 'Despesa' : 'Receita'}');
	}
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
		
		for (Transaction transaction in transactions) {
			if (transaction.date.month == month && transaction.date.year == year) {
				total += transaction.amount;
			}
		}

		return total;
	}

	void __showTransactions() {
		for (Transaction transaction in transactions) {
			transaction.__showTransaction();
		}
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