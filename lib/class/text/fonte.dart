import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:flutter/material.dart';

class Fonte {
	static final String fonteFamily = 'Inder';
}

class TextApp extends StatelessWidget {
	final String texto;
	final double size;
	final TextAlign? align;
	final Color? corTexto;
	const TextApp({
		super.key,
		required this.texto,
		required this.size,
		this.align,
		this.corTexto
	});

	@override
	Widget build(BuildContext context) {
		return Text(
			texto,
			style: TextStyle(
				fontSize: size,
				color: corTexto ?? TextColors.white,
				fontFamily: Fonte.fonteFamily
			),
			textAlign: align,
		);
	}
}