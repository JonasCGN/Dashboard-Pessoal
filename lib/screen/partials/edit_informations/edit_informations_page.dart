import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:dashboard_pessoal/screen/partials/edit_informations/date_venc_page.dart';
import 'package:dashboard_pessoal/screen/partials/edit_informations/forms_information.dart';
import 'package:dashboard_pessoal/screen/partials/edit_informations/list_category_options.dart';
import 'package:dashboard_pessoal/screen/partials/edit_informations/modal_recorente_options.dart';
import 'package:dashboard_pessoal/screen/partials/edit_informations/option_efectived_toggle.dart';
import 'package:flutter/material.dart';

class EditInformationsPage extends StatelessWidget {
	final TransactionType transactionType;
	final TextEditingController descricaoController;
	final TextEditingController valorController;
  	const EditInformationsPage({
		super.key,
		required this.transactionType,
		required this.descricaoController,
		required this.valorController,
	});

	@override
	Widget build(BuildContext context) {
		return SingleChildScrollView(
			padding: EdgeInsets.all(10),
			child: Column(
				children: [
					Column(
						spacing: 10,
						mainAxisSize: MainAxisSize.max,
						children: [
							FieldForm(
								texto: "Descrição",
								icon: Icons.edit_document,
								typeInput: TextInputType.text,
								controller: descricaoController,
							),
							FieldForm(
								texto: "R\$0,00",
								icon: Icons.monetization_on_outlined,
								typeInput: TextInputType.number,
								controller:valorController,
							),
							ModalRecorenteOptions(),
							DateVencPage(),
							OptionEfectivedToggle(),
							ListCategoryOptions(),
						],
					)
				],
			),
		);
	}
}