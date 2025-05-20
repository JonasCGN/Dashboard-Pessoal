import 'package:dashboard_pessoal/routes/routes.dart';
import 'package:dashboard_pessoal/screen/home/home_page.dart';
import 'package:dashboard_pessoal/screen/show_informations/show_informations_expense.dart';
import 'package:dashboard_pessoal/screen/show_informations/show_informations_revenue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';

void main() {
	runApp(
		MultiProvider(
			providers: [
				ChangeNotifierProvider(create: (_) => BalanceListProvider()),
			],
			child: const MyApp(),
		),
	);
}

class MyApp extends StatelessWidget {
	const MyApp({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			debugShowCheckedModeBanner: false,
			routes: {
				Routes.home: (context) => const MyHomePage(),
				Routes.showTransactionsExpense: (context) => ShowInformationsExpense(),
				Routes.showTransactionsRevenue: (context) => ShowInformationsRevenue(),
			},
			title: 'Dashboard',
			initialRoute: Routes.home,
		);
	}
}