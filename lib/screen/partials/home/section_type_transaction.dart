import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OptionTypeTransaction extends StatelessWidget {
	final String caminhoSvg;
	final String texto;
	const OptionTypeTransaction({
		super.key,
		required this.caminhoSvg,
		required this.texto,
	});

	@override
	Widget build(BuildContext context) {
		return Row(
			spacing:5,
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
								caminhoSvg: 'assets/icons/home/bonificacao_icon.svg',
								texto: "Receita",
							),
							Container(
								color: BackgroundAndBarColors.background,
								height: 1,
								width: double.infinity,
							),
							OptionTypeTransaction(
								caminhoSvg: 'assets/icons/home/despesa_icon.svg',
								texto: "Despesa",
							),
						],
					),
				)
			],
		),
	);
  }
}