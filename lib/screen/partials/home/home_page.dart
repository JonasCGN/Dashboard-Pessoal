import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/screen/home/home.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
	const MyHomePage({super.key});

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				backgroundColor: BackgroundAndBarColors.barColor,
			),
			backgroundColor: BackgroundAndBarColors.background,
			body: const HomePage(),
			floatingActionButton: FloatingActionButton(
				shape: const CircleBorder(),
				backgroundColor: IconColors.category,
				onPressed: () {
					// Ação do botão flutuante
				},
				child: Icon(
					Icons.more_horiz_outlined,
					size: 40,
					color: BackgroundAndBarColors.background,
				),
			),
		);
	}
}