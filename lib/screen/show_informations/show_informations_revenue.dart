import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/screen/show_informations/base_show_informations_page.dart';
import 'package:flutter/material.dart';

class ShowInformationsRevenue extends StatelessWidget {
	const ShowInformationsRevenue({super.key});

	@override
	Widget build(BuildContext context) {
		return BaseShowInformationsPage(
			tipoTransacao: TransactionType.revenue
		);
	}
}