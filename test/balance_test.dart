import 'package:flutter_test/flutter_test.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/class/balance/balance.dart';

void testeinicializabalances() {
	test('Inicializa com 96 balances', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		expect(balanceList.balances.length, 96);
	});
}

void testeadicionarecuperatransacao() {
	test('Adiciona e recupera transação', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		final transaction = Transaction(
			id: 1,
			description: 'Teste',
			amount: 100.0,
			date: DateTime(2025, 5, 1),
			type: TransactionType.revenue,
			process: EfitevedTransaction.finished,
		);
		balanceList.addTransaction(5, 2025, transaction);
		final balance = balanceList.getBalance(5, 2025);
		expect(balance.getTransaction(1)?.description, 'Teste');
	});
}

void testeremovetransacao() {
	test('Remove transação', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		final transaction = Transaction(
			id: 2,
			description: 'Remover',
			amount: 50.0,
			date: DateTime(2025, 6, 1),
			type: TransactionType.expense,
			process: EfitevedTransaction.finished,
		);
		balanceList.addTransaction(6, 2025, transaction);
		balanceList.removeTransaction(6, 2025, 2);
		final balance = balanceList.getBalance(6, 2025);
		expect(balance.getTransaction(2), isNull);
	});
}

void testeatualizatransacao() {
	test('Atualiza transação', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		final transaction = Transaction(
			id: 3,
			description: 'Antigo',
			amount: 20.0,
			date: DateTime(2025, 7, 1),
			type: TransactionType.expense,
			process: EfitevedTransaction.finished,
		);
		balanceList.addTransaction(7, 2025, transaction);
		final updated = Transaction(
			id: 3,
			description: 'Novo',
			amount: 30.0,
			date: DateTime(2025, 7, 1),
			type: TransactionType.revenue,
			process: EfitevedTransaction.finished,
		);
		balanceList.updateTransaction(7, 2025, 3, updated);
		final balance = balanceList.getBalance(7, 2025);
		expect(balance.getTransaction(3)?.description, 'Novo');
		expect(balance.getTransaction(3)?.amount, 30.0);
		expect(balance.getTransaction(3)?.type, TransactionType.revenue);
	});
}

void testelimpatransacoes() {
	test('Limpa transações', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		final transaction = Transaction(
			id: 4,
			description: 'Limpar',
			amount: 10.0,
			date: DateTime(2025, 8, 1),
			type: TransactionType.expense,
			process: EfitevedTransaction.finished,
		);
		balanceList.addTransaction(8, 2025, transaction);
		balanceList.clearTransactions(8, 2025);
		final balance = balanceList.getBalance(8, 2025);
		expect(balance.transactions.transactions.isEmpty, true);
	});
}

void testegetalltypetransactions() {
	test('getAllTypeTransactions retorna apenas do tipo correto', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		final t1 = Transaction(
			id: 5,
			description: 'Receita',
			amount: 200.0,
			date: DateTime(2025, 9, 1),
			type: TransactionType.revenue,
			process: EfitevedTransaction.finished,
		);
		final t2 = Transaction(
			id: 6,
			description: 'Despesa',
			amount: 80.0,
			date: DateTime(2025, 9, 1),
			type: TransactionType.expense,
			process: EfitevedTransaction.finished,
		);
		balanceList.addTransaction(9, 2025, t1);
		balanceList.addTransaction(9, 2025, t2);
		final revenues = balanceList.getAllTypeTransactions(9, 2025, TransactionType.revenue);
		expect(revenues.length, 1);
		expect(revenues.first.description, 'Receita');
	});
}

void testegettotalamountdate() {
	test('getTotalAmountDate retorna soma correta', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		final t1 = Transaction(
			id: 7,
			description: 'A',
			amount: 10.0,
			date: DateTime(2025, 10, 1),
			type: TransactionType.revenue,
			process: EfitevedTransaction.finished,
		);
		final t2 = Transaction(
			id: 8,
			description: 'B',
			amount: 20.0,
			date: DateTime(2025, 10, 1),
			type: TransactionType.expense,
			process: EfitevedTransaction.finished,
		);
		balanceList.addTransaction(10, 2025, t1);
		balanceList.addTransaction(10, 2025, t2);
		final total = balanceList.getTotalAmountDate(10, 2025);
		expect(total, 30.0);
	});
}

void testegetbalancebyindex() {
	test('getBalanceByIndex retorna o balance correto', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		final balance = balanceList.getBalanceByIndex(0);
		expect(balance.month, 1);
	});
}

void testegetbalancebydate() {
	test('getBalanceByDate retorna o balance correto', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		final date = DateTime(2025, 11, 1);
		final balance = balanceList.getBalanceByDate(date);
		expect(balance.month, 11);
		expect(balance.year, 2025);
	});
}

void testebalancenavigationmethods() {
	test('getCurrentBalance, getPreviousBalance, getNextBalance retornam meses corretos', () {
		final balanceList = BalanceList();
		balanceList.initialize();
		// Considerando que a data atual é maio (5), conforme contexto
		expect(balanceList.getCurrentBalance().month, 5);
		expect(balanceList.getPreviousBalance().month, 4);
		expect(balanceList.getNextBalance().month, 6);
	});
}

void main() {
	testeinicializabalances();
	testeadicionarecuperatransacao();
	testeremovetransacao();
	testeatualizatransacao();
	testelimpatransacoes();
	testegetalltypetransactions();
	testegettotalamountdate();
	testegetbalancebyindex();
	testegetbalancebydate();
	testebalancenavigationmethods();
}
