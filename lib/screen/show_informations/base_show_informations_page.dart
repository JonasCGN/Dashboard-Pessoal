import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/screen/partials/show_informations/base_show_informations.dart';
import 'package:flutter/material.dart';

class BaseShowInformationsPage extends StatelessWidget {
	final TransactionType tipoTransacao;
	const BaseShowInformationsPage({
		super.key,
		required this.tipoTransacao
	});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: BackgroundAndBarColors.barColor,
			),
			backgroundColor: BackgroundAndBarColors.background,
			body: BaseShowInformations(tipoTransacao: tipoTransacao,),
			floatingActionButton: FloatingActionButton(
				shape: const CircleBorder(),
				backgroundColor: (TransactionType.expense == tipoTransacao) ? FinancialColors.expense :  FinancialColors.income,
				onPressed: () {
					// Ação do botão flutuante
				},
				child: Icon(
					Icons.add_outlined,
					size: 40,
					color: IconColors.category,
				),
			),
		);
	}
}