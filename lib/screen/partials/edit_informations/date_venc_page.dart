import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/date/date_format.dart';
import 'package:dashboard_pessoal/class/provider/edit_informations_provider.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateVencPage extends StatelessWidget {
  	const DateVencPage({super.key});

	@override
	Widget build(BuildContext context) {
		return Consumer<EditInformationsProvider>(
			builder: (context,value,child){
				return Material(
					borderRadius: BorderRadius.circular(10),
					color: MiscellaneousColors.darkGray,
					child: InkWell(
						onTap: () async {
							DateTime? pickedDate = await showDatePicker(
								context: context,
								initialDate: value.dateVenc,
								firstDate: DateTime(2000),
								lastDate: DateTime(2100),
							);
							if (pickedDate != null) {
								value.setDateVenc(pickedDate);
							}
						},
						child: Container(
							height: 60,
							padding: EdgeInsets.all(5),
							child: Row(
								mainAxisAlignment: MainAxisAlignment.spaceBetween,
								children: [
									Row(
										children: [
											Icon(
												Icons.date_range,
												color: IconColors.expenseIncome,
												size: 30,
											),
											SizedBox(width: 5),
											TextApp(
												texto: "Data de Vencimento", 
												size: 20
											)
										],
									),
									TextApp(
										texto: DateFormatString.traduzDate(value.dateVenc), 
										size: 20
									)
								],
							),
						),
					),
				);
			}
		);
	}
}