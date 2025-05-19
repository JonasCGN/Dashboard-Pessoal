import 'package:dashboard_pessoal/screen/partials/home/balance_info.dart';
import 'package:dashboard_pessoal/screen/partials/home/date_month_slide_show.dart';
import 'package:dashboard_pessoal/screen/partials/home/recent_movimentations.dart';
import 'package:dashboard_pessoal/screen/partials/home/section_type_transaction.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
	const HomePage({super.key});

	@override
	Widget build(BuildContext context) {
		return SingleChildScrollView(
			child: Container(
				// margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
				padding: const EdgeInsets.all(10),
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					spacing: 10,
					children: [
						BalanceInfo(),
						DateMonthSlideShow(),
						SectionTypeTransaction(),
						RecentMovimentations()
					],
				),
			), 
		);
	}
}