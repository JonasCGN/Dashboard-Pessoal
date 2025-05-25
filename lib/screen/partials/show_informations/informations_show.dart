import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/screen/partials/home/recent_movimentations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class InformationsShow extends StatelessWidget {
	final TransactionType tipoTransacao;
  	const InformationsShow({
		super.key,
		required this.tipoTransacao
	});

	@override
	Widget build(BuildContext context) {
		return Consumer<BalanceListProvider>(
			builder: (context,balance,child){
				List<Transaction> transactions = balance.balanceList.getAllTypeTransactions(
					balance.balanceList.currentDate.month, 
					balance.balanceList.currentDate.year, 
					tipoTransacao
				);
				return SingleChildScrollView(
					child: Container(
						padding: EdgeInsets.all(10),
						width: double.infinity,
						child: SizedBox(
							child: ListView.separated(
								shrinkWrap: true,
								itemCount: transactions.length,
								physics: NeverScrollableScrollPhysics(),
								itemBuilder: (context, index) {
									final transaction = transactions[index];
									return MovimentacaoInformation(
										transaction: transaction,
										sectionScreen: true,
									);
								},
								separatorBuilder: (context, index) => SizedBox(height: 5),
							),
						),
					),
				);
			}
		);
	}
}