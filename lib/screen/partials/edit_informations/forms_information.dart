import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';

class FieldForm extends StatelessWidget {
	final String texto;
	final TextInputType? typeInput;
	final IconData icon;
	final TextEditingController controller;
	const FieldForm ({
		super.key,
		required this.texto,
		required this.typeInput,
		required this.icon,
		required this.controller,    
	});

	@override
	Widget build(BuildContext context) {
		return Container(
			height: 60,
			decoration: BoxDecoration(
				color: MiscellaneousColors.darkGray,
				borderRadius: BorderRadius.all(Radius.circular(10)),
			),
			padding: EdgeInsets.all(5),
			child: Row(
				spacing: 5,
				children: [
					Icon(
						icon,
						size: 35,
						color: IconColors.expenseIncome,
					),
					Expanded(
						child: TextFormApp(
							texto: texto,
							size: 15,
							typeInput: typeInput,
							controller:controller,
						),
					),
					
				],
			),
		);
	}
}