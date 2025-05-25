import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/screen/partials/home/date_month_slide_show.dart';
import 'package:dashboard_pessoal/screen/partials/show_informations/informations_show.dart';
import 'package:dashboard_pessoal/screen/partials/show_informations/total_month_amount.dart';
import 'package:flutter/material.dart';

class BaseShowInformations extends StatelessWidget {
	final TransactionType tipoTransacao;
	const BaseShowInformations({
		super.key,
		required this.tipoTransacao
	});

	@override
	Widget build(BuildContext context) {
		return SingleChildScrollView(
			child: Container(
				padding: EdgeInsets.all(10),
				child: Column(
					children: [
						TotalMonthAmount(transactionType: tipoTransacao),
						DateMonthSlideShow(),
						InformationsShow(tipoTransacao:tipoTransacao)
					]
				),
			) 
		);
	}
}