import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/routes/routes.dart';
import 'package:dashboard_pessoal/screen/partials/home/section_type_transaction.dart';
import 'package:flutter/cupertino.dart';

class ModalTransaction extends StatelessWidget {
	const ModalTransaction({
		super.key,
	});

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				color: BackgroundAndBarColors.barColor,
				borderRadius: BorderRadius.all(Radius.circular(10))
			),
			padding:EdgeInsets.fromLTRB(10, 11, 10, 11),
			child: Column(
				spacing: 13,
				mainAxisSize: MainAxisSize.min,
				crossAxisAlignment: CrossAxisAlignment.start,
				children: [
					OptionTypeTransaction(
						function: 
						(){
							 Navigator.pop(context); // Fecha o dialog
							Navigator.pushNamed(
								context, 
								Routes.editInformationsRevenue
							);
						},
						colorBack: BackgroundAndBarColors.barColor,
						mainAxis: true,
						caminhoSvg: 'assets/icons/home/bonificacao_icon.svg',
						texto: "Receita",
					),
					Container(
						color: BackgroundAndBarColors.background,
						height: 2,
						width: MediaQuery.of(context).size.width * 0.4,
					),
					OptionTypeTransaction(
						function: (){
							 Navigator.pop(context); // Fecha o dialog
							Navigator.pushNamed(
								context, 
								Routes.editInformationsExpense
							);
						},
						colorBack: BackgroundAndBarColors.barColor,
						caminhoSvg: 'assets/icons/home/despesa_icon.svg',
						texto: "Despesa",
						mainAxis: true,
					),
				],
			),
		);
  }
}