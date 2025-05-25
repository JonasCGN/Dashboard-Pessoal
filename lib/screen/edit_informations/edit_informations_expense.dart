import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/screen/edit_informations/base_edit_informations.dart';
import 'package:flutter/material.dart';

class EditInformationsExpense extends StatelessWidget {
	const EditInformationsExpense({super.key});

	@override
	Widget build(BuildContext context) {
		return BaseEditInformations(
			tipoTransacao: TransactionType.expense
		);
	}
}