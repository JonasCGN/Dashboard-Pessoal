import 'package:dashboard_pessoal/class/provider/category_provider.dart';
import 'package:dashboard_pessoal/class/provider/edit_informations_provider.dart';
import 'package:dashboard_pessoal/routes/routes.dart';
import 'package:dashboard_pessoal/screen/edit_informations/edit_informations_expense.dart';
import 'package:dashboard_pessoal/screen/edit_informations/edit_informations_revenue.dart';
import 'package:dashboard_pessoal/screen/home/home_page.dart';
import 'package:dashboard_pessoal/screen/show_informations/show_informations_expense.dart';
import 'package:dashboard_pessoal/screen/show_informations/show_informations_revenue.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';

Future<void> main() async{
	await dotenv.load();
	runApp(
		MultiProvider(
			providers: [
				ChangeNotifierProvider(create: (_) => BalanceListProvider()),
				ChangeNotifierProvider(create: (_) => EditInformationsProvider()),
				ChangeNotifierProvider(create: (_) => CategoryProvider()),
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
				Routes.editInformationsExpense: (context) => EditInformationsExpense(),
				Routes.editInformationsRevenue: (context) => EditInformationsRevenue(),
			},
			title: 'Dashboard',
			initialRoute: Routes.home,
		);
	}
} 