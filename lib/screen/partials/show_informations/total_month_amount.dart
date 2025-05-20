import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/screen/partials/home/balance_info.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TotalMonthAmount extends StatelessWidget {
	final TransactionType transactionType;
	const TotalMonthAmount({
		super.key,
		required this.transactionType
	});

  @override
  Widget build(BuildContext context) {
    return Consumer<BalanceListProvider>(
			builder: (context,balance,child){
				int month = balance.balanceList.currentDate.month;
				int year = balance.balanceList.currentDate.year;

				return Row(
					crossAxisAlignment: CrossAxisAlignment.center,
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: [
						SaldoInfo(valor: balance.getTotalAmountMonth(month,year,transactionType), text: "Atual",meio: true,showText:false),
					],
				);
			}
		);
  	}
}