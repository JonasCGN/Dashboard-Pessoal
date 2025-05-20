import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/date/date_format.dart';
import 'package:dashboard_pessoal/class/provider/balance_list_provider.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DateMonthSlideShow extends StatelessWidget {
  	const DateMonthSlideShow({super.key});

	@override
	Widget build(BuildContext context) {
		return Consumer<BalanceListProvider>(
			builder: (context,balance,child){
				return Row(
					mainAxisAlignment: MainAxisAlignment.spaceEvenly,
					children: [
						IconButton(
							onPressed: (){
								balance.previousBalance();
							}, 
							icon: Icon(
								Icons.arrow_back_ios_rounded,
								color: IconColors.category
							),
						),
						TextButton(
							onPressed: (){
								balance.todayBalance();
							}, 
							child: TextApp(
								texto: DateFormatString.formatMonthName(balance.balanceList.currentDate), 
								size: 37
							)
						),
						IconButton(
							onPressed: (){
								balance.nextBalance();
							}, 
							icon: Icon(
								Icons.arrow_forward_ios_rounded,
								color: IconColors.category,
							),
						),
					],
				);
			}
		);
	}
}