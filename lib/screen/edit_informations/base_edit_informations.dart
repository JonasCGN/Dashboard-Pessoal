import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';
import 'package:dashboard_pessoal/class/provider/edit_informations_provider.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/screen/partials/edit_informations/edit_informations_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseEditInformations extends StatelessWidget {
	final TransactionType tipoTransacao;
	BaseEditInformations({
		super.key,
		required this.tipoTransacao
	});
	
	final TextEditingController descricaoController = TextEditingController();
	final TextEditingController valorController = TextEditingController();

	@override
	Widget build(BuildContext context) {
		return Consumer<EditInformationsProvider>(
			builder: (BuildContext context, EditInformationsProvider value, Widget? child) { 
				return  Scaffold(
					appBar: AppBar(
						backgroundColor: BackgroundAndBarColors.barColor,
						iconTheme: IconThemeData(
							color: IconColors.category,
						),
						leading: Navigator.canPop(context)
							? IconButton(
								icon: Icon(Icons.arrow_back),
								onPressed: () {
									Navigator.of(context).pop();
								},
							)
							: null,
					),
					backgroundColor: BackgroundAndBarColors.background,
					body: EditInformationsPage(
						transactionType: tipoTransacao,
						descricaoController:descricaoController,
						valorController:valorController
					),
					floatingActionButton: Builder(
						builder: (context) => FloatingActionButton(
							shape: const CircleBorder(),
							backgroundColor: (TransactionType.expense == tipoTransacao)
								? FinancialColors.expense
								: FinancialColors.income,
							onPressed: () {
								value.setTypeTransaction(tipoTransacao);
								value.setDescricao(descricaoController.text);
								value.setValor(double.tryParse(valorController.text.replaceAll(',', '.')) ?? 0);
								
								final Transaction transacao = value.getFormData();
								Provider.of<BalanceListProvider>(context,listen: false).addTransaction(transacao);

								Navigator.pop(context);
							},
							child: Icon(
								Icons.check,
								size: 40,
								color: IconColors.category,
							),
						),
					),
				);
			},
		);
	}
}