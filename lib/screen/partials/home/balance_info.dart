import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';

class SaldoInfo extends StatelessWidget {
	final double valor;
	final String text;
	final bool meio;

	const SaldoInfo({
		super.key,
		required this.valor,
		required this.text,
		required this.meio
	});

	@override
	Widget build(BuildContext context) {
		return Column(
			mainAxisAlignment: MainAxisAlignment.center,
			crossAxisAlignment: CrossAxisAlignment.center,
			children: [
				if (meio)
					...[
						TextApp(
							texto: text,
							size: 20,
						),
						TextApp(
							texto: "R\$${valor.toStringAsFixed(2).replaceAll('.', ',')}",
							size: 24,
							align: TextAlign.center,
						),
					]
				else
					...[
						TextApp(
							texto: text,
							size: 14,
							align: TextAlign.center,
						),
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
	final double valor;
	const BalanceInfo({super.key, this.valor = 0.0});

	@override
	Widget build(BuildContext context) {
		return Row(
			crossAxisAlignment: CrossAxisAlignment.center,
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: [
				SaldoInfo(valor: valor, text: "Anterior",meio: false),
				SaldoInfo(valor: 1000.0, text: "Atual",meio: true,),
				SaldoInfo(valor: valor, text: "Posterior",meio: false),
			],
		);
	}
}