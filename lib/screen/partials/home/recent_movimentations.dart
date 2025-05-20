import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/date/date_format.dart';
import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovimentacaoInformation extends StatelessWidget {

	final String namePay;
	final String categoria;
	final DateTime date;
	final double amount;
	final TransactionType type;
	final EfitevedTransaction transaction;

	const MovimentacaoInformation({
		super.key,
		required this.namePay,
		required this.categoria,
		required this.date,
		required this.amount,
		required this.type,
		required this.transaction,
	});

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				color: MiscellaneousColors.darkGray,
				borderRadius: BorderRadius.all(Radius.circular(10)),
			),
			padding: EdgeInsets.all(10),
			child: Row(
					mainAxisAlignment: MainAxisAlignment.spaceBetween,
					children: [
						Row(
							spacing: 10,
							children: [
								Container(
									width: 50,
									height: 50,
									decoration: BoxDecoration(
										borderRadius: BorderRadius.all(Radius.circular(50)),
										color: type == TransactionType.expense ? FinancialColors.expense : FinancialColors.income,
									),
									child:  Icon(
										transaction == EfitevedTransaction.finished ? Icons.check_rounded : Icons.more_horiz,
										color: IconColors.category,
										size: 30,
									) 
								),
								Column(
									crossAxisAlignment: CrossAxisAlignment.start,
									spacing: 5,
									children: [
										TextApp(
											texto: "Nome do Pagamento", 
											size: 12,
										),
										Container(
											padding: EdgeInsets.all(2),
											decoration: BoxDecoration(
												color: IconColors.category,
												borderRadius: BorderRadius.all(Radius.circular(5))
											),
											child: TextApp(
												texto: "Bonificação", 
												size: 8,
												align: TextAlign.start,
												corTexto: TextColors.black,
											),
										)
									]
								),
							],
						),
						Row(
							children: [
								Column(
									spacing: 5,
									children: [
										TextApp(
											texto: "${date.day}. ${DateFormatString.formatDayWeekName(date)} ${DateFormatString.formatMonthName(date)}",
											size: 10,
										),
										TextApp(
											texto: "R\$${amount.toStringAsFixed(2).toString().replaceFirst('.', ',')}",
											size: 10,
										),
									],
								),
								Container(
									constraints: BoxConstraints.tightFor(height: 50),
									child: Column(
										children: [
											Icon(
												Icons.more_horiz,
												color: TextColors.white,
											)
										],
									),
								)
							],
						)
					],
				),
		);
	}
}

class RecentMovimentations extends StatelessWidget {
  const RecentMovimentations({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BalanceListProvider>(
      builder: (context, balanceListProvider, child) {
        List<Transaction> transactions = balanceListProvider.getRecentTransactions(5);
		return SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
				children: [
				  TextApp(
					texto: "Movimentações Recentes",
					size: 24,
				  ),
				  ListView.separated(
					shrinkWrap: true,
					physics: NeverScrollableScrollPhysics(),
					itemCount: transactions.length,
					itemBuilder: (context, index) {
					  final transaction = transactions[index];
					  return MovimentacaoInformation(
						namePay: transaction.description,
						categoria: "Saude",
						date: transaction.date,
						amount: transaction.amount,
						type: transaction.type,
						transaction: transaction.process,
					  );
					},
					separatorBuilder: (context, index) => SizedBox(height: 5),
				  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
