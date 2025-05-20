import 'package:dashboard_pessoal/screen/partials/home/balance_info.dart';
import 'package:dashboard_pessoal/screen/partials/home/date_month_slide_show.dart';
import 'package:dashboard_pessoal/screen/partials/home/recent_movimentations.dart';
import 'package:dashboard_pessoal/screen/partials/home/section_type_transaction.dart';
import 'package:flutter/material.dart';
import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
	const HomePage({super.key});
	
	@override
	Widget build(BuildContext context) {
		return ChangeNotifierProvider(
			create: (_) => BalanceListProvider(),
			child: SingleChildScrollView(
				child: Container(
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
			),
		);
	}
}