import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/screen/edit_informations/base_edit_informations.dart';
import 'package:flutter/material.dart';

class EditInformationsRevenue extends StatelessWidget {
	const EditInformationsRevenue({super.key});

	@override
	Widget build(BuildContext context) {
		return BaseEditInformations(
			tipoTransacao: TransactionType.revenue
		);
	}
}