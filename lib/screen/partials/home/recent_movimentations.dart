import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/date/date_format.dart';
import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovimentacaoInformation extends StatelessWidget {

	final Transaction transaction;
	final bool sectionScreen;

	const MovimentacaoInformation({
		super.key,
		required this.transaction,
		required this.sectionScreen,
	});

	@override
	Widget build(BuildContext context) {
		return Material(
			color: MiscellaneousColors.darkGray,
			borderRadius: BorderRadius.all(Radius.circular(10)),
			child: InkWell(
				// hoverColor: BackgroundAndBarColors.barColor,
				focusColor:BackgroundAndBarColors.barColor ,
				borderRadius: BorderRadius.all(Radius.circular(10)),
				onTap: (){

				},
				child: Container(
					decoration: BoxDecoration(
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
												color: transaction.type == TransactionType.expense ? FinancialColors.expense : FinancialColors.income,
											),
											child:  Icon(
												transaction.process == EfitevedTransaction.finished ? Icons.check_rounded : Icons.more_horiz,
												color: IconColors.category,
												size: 30,
											) 
										),
										Column(
											crossAxisAlignment: CrossAxisAlignment.start,
											spacing: 5,
											children: [
												TextApp(
													texto: (transaction.description.length > 20) ? 
													"${transaction.description.substring(0, 20).trimRight()}..." : 
													transaction.description,
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
											crossAxisAlignment: CrossAxisAlignment.end,
											children: [
												TextApp(
													texto: 
													(sectionScreen) ? 
														"${transaction.dateVenc.day}. ${DateFormatString.formatDayWeekName(transaction.dateVenc)}"
														:
														"${transaction.dateVenc.day}/${DateFormatString.formatMonthName(transaction.dateVenc)}",
													size: 10,
												),
												TextApp(
													texto: "R\$${transaction.amount.toStringAsFixed(2).toString().replaceFirst('.', ',')}",
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
				),
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
						transaction: transaction,
						sectionScreen: false,
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
