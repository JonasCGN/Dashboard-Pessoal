import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';

class OptionsRecorrente extends StatelessWidget {
	const OptionsRecorrente({super.key});

	@override
	Widget build(BuildContext context) {
		return Container(
			decoration: BoxDecoration(
				color: BackgroundAndBarColors.barColor,
				borderRadius: BorderRadius.all(Radius.circular(10))
			),
			padding: EdgeInsets.all(10),
			margin: EdgeInsets.all(10),
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: [
					ListTile(
						leading: Icon(Icons.calendar_today, color: IconColors.expenseIncome),
						title: TextApp(texto: "Opção 1", size: 18),
						onTap: () {
							// Ação para a opção 1
						},
					),
					ListTile(
						leading: Icon(Icons.alarm, color: IconColors.expenseIncome),
						title: TextApp(texto: "Opção 2", size: 18),
						onTap: () {
							// Ação para a opção 2
						},
					),
					ListTile(
						leading: Icon(Icons.settings, color: IconColors.expenseIncome),
						title: TextApp(texto: "Opção 3", size: 18),
						onTap: () {
							// Ação para a opção 3
						},
					),
				],
			),
		);
	}
}

class ModalRecorenteOptions extends StatelessWidget {
  const ModalRecorenteOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
		color: MiscellaneousColors.darkGray,
		borderRadius: BorderRadius.all(Radius.circular(10)),
		child: InkWell(
			borderRadius: BorderRadius.all(Radius.circular(10)),
			onTap: (){
				showDialog(
					context: context,
					builder: (context) => Stack(
						children: [
							Center(
								child: Material(
									color: Colors.transparent,
									child: OptionsRecorrente(),
								),
							),
						],
					),
				);
			},
			child: Container(
					height: 60,
					padding: EdgeInsets.all(5),
					child: Row(
						spacing: 5,
						children: [
							Icon(
								Icons.refresh_rounded,
								size: 30,
								color: IconColors.expenseIncome,
							),
							TextApp(
								texto: "Recorrente",
								size: 20,
							),
						],
					),
				),
			),
		);
  }
}