import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/provider/edit_informations_provider.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OptionEfectivedToggle extends StatefulWidget {
	const OptionEfectivedToggle({super.key});

	@override
	OptionEfectivedToggleState createState() => OptionEfectivedToggleState();
}

class OptionEfectivedToggleState extends State<OptionEfectivedToggle> {
	bool isSelected = false;

	@override
	Widget build(BuildContext context) {
		return Material(
			color: MiscellaneousColors.darkGray,
			borderRadius: BorderRadius.all(Radius.circular(10)),
			child: InkWell(
				borderRadius: BorderRadius.all(Radius.circular(10)),
				onTap: () {
					setState(() {
						isSelected = !isSelected;
					});
				},
				child: Container(
					padding: EdgeInsets.all(5),
					height: 60,
					child: Row(
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							Row(
								spacing: 5,
								children: [
									Icon(
										Icons.check_circle_outline_outlined,
										color: IconColors.expenseIncome,
										size: 30,
									),
									TextApp(
										texto: "Efetivada",
										size: 20,
									)
								],
							),
							Switch(
								value: isSelected,
								onChanged: (bool newValue) {
									setState(() {
										isSelected = newValue;
									});
									Provider.of<EditInformationsProvider>(context, listen: false).process = 
										isSelected ? EfitevedTransaction.finished : EfitevedTransaction.finished;
								},
								activeColor: IconColors.expenseIncome,
								inactiveThumbColor: Colors.grey,
								inactiveTrackColor: Colors.grey.shade400,
							),
						],
					),
				),
			),
		);
	}
}