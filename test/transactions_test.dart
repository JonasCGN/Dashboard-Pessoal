import 'package:flutter_test/flutter_test.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';

void testetransactions(){
	test('Recupera descrição da transação pelo id', () {
		final transactions = Transactions(transactions: [
			Transaction(id: 1, description: 'Compra no supermercado', amount: 150.75, dateVenc: DateTime(2023, 10, 1), dateLanc: DateTime(2023, 10, 1), type: TransactionType.expense, process: EfitevedTransaction.finished, category: 1),
			Transaction(id: 2, description: 'Pagamento de aluguel', amount: 1200.00, dateVenc: DateTime(2023, 10, 5), dateLanc: DateTime(2023, 10, 5), type: TransactionType.expense, process: EfitevedTransaction.finished, category: 2),
			Transaction(id: 2, description: 'Pagamento de aluguel', amount: 1200.00, dateVenc: DateTime(2023, 10, 5), dateLanc: DateTime(2023, 10, 5), type: TransactionType.revenue, process: EfitevedTransaction.finished, category: 2),
			Transaction(id: 3, description: 'Assinatura de streaming', amount: 49.90, dateVenc: DateTime(2023, 10, 10), dateLanc: DateTime(2023, 10, 10), type: TransactionType.revenue, process: EfitevedTransaction.finished, category: 3),
		]);

		expect(transactions.getTransaction(1)?.description, 'Compra no supermercado');
	});
}

void testetransactionstype(){
	test('Recupera descrição da transação pelo id', () {
		final transactions = Transactions(transactions: [
			Transaction(id: 1, description: 'Compra no supermercado', amount: 150.75, dateVenc: DateTime(2023, 10, 1), dateLanc: DateTime(2023, 10, 1), type: TransactionType.expense, process: EfitevedTransaction.finished, category: 1),
			Transaction(id: 2, description: 'Pagamento de aluguel', amount: 1200.00, dateVenc: DateTime(2023, 10, 5), dateLanc: DateTime(2023, 10, 5), type: TransactionType.expense, process: EfitevedTransaction.finished, category: 2),
			Transaction(id: 2, description: 'Pagamento de aluguel', amount: 1200.00, dateVenc: DateTime(2023, 10, 5), dateLanc: DateTime(2023, 10, 5), type: TransactionType.revenue, process: EfitevedTransaction.finished, category: 2),
			Transaction(id: 3, description: 'Assinatura de streaming', amount: 49.90, dateVenc: DateTime(2023, 10, 10), dateLanc: DateTime(2023, 10, 10), type: TransactionType.revenue, process: EfitevedTransaction.finished, category: 3),
		]);

		expect(transactions.getAllTypeTransactions(TransactionType.revenue), isA<List<Transaction>>());
		expect(transactions.getAllTypeTransactions(TransactionType.revenue).length, 2);
	});
}

void main() {
  testetransactions();
  testetransactionstype();
}
