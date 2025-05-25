import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
				fontFamily: Fonte.fonteFamily,
			),
			textAlign: align,
		);
	}
}

class TextFormApp extends StatelessWidget {
	final String texto;
	final double size;
	final TextAlign? align;
	final Color? corTexto;
	final TextInputType? typeInput;
	final TextEditingController controller;
	const TextFormApp({
		super.key,
		required this.texto,
		required this.size,
		required this.controller,
		this.align,
		this.corTexto,
		this.typeInput,
	});

	@override
	Widget build(BuildContext context) {
		return Focus(
			child: TextField(
				style: TextStyle(
					color: TextColors.white,
					fontFamily: Fonte.fonteFamily,
					fontSize: size,
				),
				keyboardType: typeInput,
				inputFormatters: typeInput == TextInputType.number
					? [
						FilteringTextInputFormatter.allow(RegExp(r'^\d*[\.,]?\d*')),
					]
					: [
						FilteringTextInputFormatter.deny(RegExp(r'^\s+|\s{2,}')),
					],
				controller: controller,
				decoration: InputDecoration(
					hintText: texto,
					hintStyle: TextStyle(
						fontFamily: Fonte.fonteFamily,
						color: TextColors.placeholder,
					),
					enabledBorder: UnderlineInputBorder(
						borderSide: BorderSide.none,
					),
					focusedBorder: UnderlineInputBorder(
						borderSide: BorderSide.none,
					),
				),
				cursorColor: TextColors.placeholder,
			),
		);
	}
}
