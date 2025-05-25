import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:dashboard_pessoal/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionTypeTransaction extends StatelessWidget {
	final String caminhoSvg;
	final String texto;
	final Function() function;
	final bool mainAxis;
	final Color colorBack;

	const OptionTypeTransaction({
		super.key,
		required this.caminhoSvg,
		required this.texto,
		required this.function,
		required this.mainAxis,
		required this.colorBack,
	});

	@override
	Widget build(BuildContext context) {
		return Material(
			color: colorBack,
			child: InkWell(
				focusColor:BackgroundAndBarColors.barColor ,
				onTap: function,
				child: Row(
					spacing:5,
					mainAxisSize: (mainAxis) ? MainAxisSize.min : MainAxisSize.max,
					children: [
						SvgPicture.asset(
							caminhoSvg,
							width: 40,
							height: 40,
						),
						TextApp(
							texto: texto, 
							size: 28
						)
					],
				),
			),
		);
  }
}

class SectionTypeTransaction extends StatelessWidget {
  const SectionTypeTransaction({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
			width: double.infinity,
			child: Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			spacing: 2,
			children: [
				TextApp(
					texto: "Seção", 
					size: 24,
				),
				Container(
					width: double.infinity,
					decoration: BoxDecoration(
						color: MiscellaneousColors.darkGray,
						borderRadius: BorderRadius.all(Radius.circular(10))
					),
					padding:EdgeInsets.fromLTRB(10, 11, 10, 11),
					child: Column(
						spacing: 13,
						children: [
							OptionTypeTransaction(
								function: 
								(){
									Navigator.pushNamed(
										context, 
										Routes.showTransactionsRevenue
									);
								},
								colorBack: MiscellaneousColors.darkGray,
								caminhoSvg: 'assets/icons/home/bonificacao_icon.svg',
								texto: "Receita",
								mainAxis: false,
							),
							Container(
								color: BackgroundAndBarColors.background,
								height: 1,
								width: double.infinity,
							),
							OptionTypeTransaction(
								function: (){
									Navigator.pushNamed(
										context, 
										Routes.showTransactionsExpense
									);
								},
								colorBack: MiscellaneousColors.darkGray,
								caminhoSvg: 'assets/icons/home/despesa_icon.svg',
								texto: "Despesa",
								mainAxis: false,
							),
						],
					),
				)
			],
		),
	);
  }
}