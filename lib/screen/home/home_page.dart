import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/screen/partials/home/home.dart';
import 'package:dashboard_pessoal/screen/partials/home/modal_transaction.dart';
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
			floatingActionButton: Builder(
				builder: (context) => FloatingActionButton(
					shape: const CircleBorder(),
					backgroundColor: IconColors.category,
					onPressed: () {
						showDialog(
							context: context,
							builder: (context) => Stack(
								children: [
									Positioned(
										bottom: MediaQuery.of(context).size.height * 0.1,
										right: MediaQuery.of(context).size.width * 0.1,
										child: Material(
											color: Colors.transparent,
											child: ModalTransaction(),
										),
									),
								],
							),
						);
					},
					child: Icon(
						Icons.more_horiz_outlined,
						size: 40,
						color: BackgroundAndBarColors.background,
					),
				),
			),
		);
	}
}