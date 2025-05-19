import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DateMonthSlideShow extends StatelessWidget {
  const DateMonthSlideShow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
		child: Row(
			mainAxisAlignment: MainAxisAlignment.spaceEvenly,
			children: [
				SvgPicture.asset(
					'assets/icons/home/arrow.svg',
					width: 48,
					height: 48,
				),
				TextApp(
					texto: "Month", 
					size: 37
				),
				Transform.rotate(
					angle: 3.1416, // Rotate 180 degrees (pi radians)
					child: SvgPicture.asset(
						'assets/icons/home/arrow.svg',
						width: 48,
						height: 48,
					),
				),
			],
		),
	);
  }
}