import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';
import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SaldoInfo extends StatelessWidget {
	final double valor;
	final String text;
	final bool meio;
	final bool showText;

	const SaldoInfo({
		super.key,
		required this.valor,
		required this.text,
		required this.meio,
		this.showText = true
	});

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				if (meio)
					...[
						if(showText)...[
							TextApp(
								texto: text,
								size: 20,
							),
						],
						TextApp(
							texto: "R\$${valor.toStringAsFixed(2).replaceAll('.', ',')}",
							size: 24,
							align: TextAlign.center,
						),
					]
				else
					...[
						if(showText)...[
							TextApp(
								texto: text,
								size: 14,
								align: TextAlign.center,
							),
						],
						const SizedBox(height: 10),
						Container(
							width: 70,
							decoration: BoxDecoration(
								color: BackgroundAndBarColors.barColor,
								borderRadius: BorderRadius.all(Radius.circular(10))
							),
							child: Column(
								children: [
									TextApp(
										texto: "R\$${valor.toStringAsFixed(2).replaceAll('.', ',')}",
										size: 12,
										align: TextAlign.center,
									),
								],
							),
						)
					]
			],
		);
	}
}

class BalanceInfo extends StatelessWidget {
	const BalanceInfo({super.key});

	@override
	Widget build(BuildContext context) {
		return Consumer<BalanceListProvider>(
			builder: (context,balance,child){
				return Row(
					crossAxisAlignment: CrossAxisAlignment.center,
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: [
						SaldoInfo(valor: balance.getBalance(-1).amount, text: "Anterior",meio: false),
						SaldoInfo(valor: balance.getBalance(0).amount, text: "Atual",meio: true,),
						SaldoInfo(valor: balance.getBalance(1).amount, text: "Posterior",meio: false),
					],
				);
			}
		);
	}
}