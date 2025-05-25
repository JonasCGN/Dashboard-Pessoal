import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/icons/icons.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';

class DynamicIconPicker extends StatefulWidget {
  const DynamicIconPicker({super.key});

  @override
  DynamicIconPickerState createState() => DynamicIconPickerState();
}

class DynamicIconPickerState extends State<DynamicIconPicker> {
	bool isLoading = true;
	String searchQuery = '';
	int? selectedIconId;
	IconsApp iconsApp = IconsApp();
	Map<String, List<int>> categorizedIcons = {};

	@override
	void initState() {
		super.initState();
		_loadIcons();
	}

	Future<void> _loadIcons() async {
		setState(() => isLoading = true);
		iconsApp.icons = await IconsApp.listarTodosOsIconsComTagsMap();
		_filterIcons();
		setState(() => isLoading = false);
	}

	void _filterIcons() {
		setState(() {
			categorizedIcons = iconsApp.filterIconsByQuery(searchQuery);
		});
	}

	@override
	Widget build(BuildContext context) {
		return Dialog(
			key: ValueKey(isLoading), // Garante animação ao alternar loading/conteúdo
			backgroundColor: MiscellaneousColors.darkGray,
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
			child: Container(
				width: 500,
				height: 500,
				padding: EdgeInsets.all(16),
				child: isLoading
					? Center(child: CircularProgressIndicator())
					: Column(
						children: [
						TextField(
							cursorColor: IconColors.expenseIncome,
							style: TextStyle(color: TextColors.white),
							onChanged: (value) {
								setState(() {
									searchQuery = value;
									_filterIcons();
								});
							},
							decoration: InputDecoration(
							labelText: 'Buscar ícone',
							labelStyle: TextStyle(color: TextColors.placeholder),
							prefixIcon: Icon(
								Icons.search,
								color: IconColors.expenseIncome,
							),
							focusColor: IconColors.expenseIncome,
							focusedBorder: UnderlineInputBorder(
								borderSide: BorderSide(color: IconColors.expenseIncome),
							),
							),
						),
						SizedBox(height: 16),
						Expanded(
							child: categorizedIcons.isEmpty
								? Center(
									child: TextApp(
									texto: 'Nenhum ícone encontrado',
									size: 25,
									),
								)
								: ListView(
									children: categorizedIcons.entries.map((entry) {
									final category = entry.key;
									final iconIds = entry.value;
									return Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
										Padding(
											padding: const EdgeInsets.symmetric(vertical: 8.0),
											child: Text(
											category,
											style: TextStyle(
												fontWeight: FontWeight.bold,
												fontSize: 16,
												color: Colors.white,
											),
											),
										),
										GridView.builder(
											shrinkWrap: true,
											physics: NeverScrollableScrollPhysics(),
											gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
												crossAxisCount: 5,
												crossAxisSpacing: 8,
												mainAxisSpacing: 8,
											),
											itemCount: iconIds.length,
											itemBuilder: (ctx, index) {
												final iconId = iconIds[index];
												final IconsAppSVG iconData = iconsApp.icons[iconId]!;
												return GestureDetector(
													onTap: () {
														setState(() {
															selectedIconId = iconId;
														});
													},
													child: Container(
													decoration: BoxDecoration(
														border: Border.all(
														color: selectedIconId == iconId
															? Colors.blue
															: Colors.transparent,
														width: 2,
														),
														borderRadius: BorderRadius.circular(8),
													),
													padding: EdgeInsets.all(6),
													child: iconData.svgShow(selectedIconId),
													),
												);
											},
										),
										],
									);
									}).toList(),
								),
						),
						SizedBox(height: 16),
						ElevatedButton(
							onPressed: selectedIconId != null
								? () {
									Navigator.of(context).pop(selectedIconId);
								}
								: null,
							style: ButtonStyle(
							shape: WidgetStateProperty.all(
								RoundedRectangleBorder(
								borderRadius: BorderRadius.all(Radius.circular(5)),
								),
							),
							shadowColor: WidgetStateProperty.resolveWith<Color>(
								(states) {
								if (states.contains(WidgetState.disabled)) {
									return Colors.white;
								}
								return Colors.grey.shade700;
								},
							),
							backgroundColor: WidgetStateProperty.resolveWith<Color>(
								(states) {
									if (states.contains(WidgetState.disabled)) {
										return Colors.grey.shade700;
									}
									return Colors.white;
									},
								),
							),
							child: TextApp(
								texto: 'Selecionar',
								corTexto: selectedIconId != null ? TextColors.black : TextColors.white,
								size: 15,
							),
						),
						],
					),
			),
		);
	}
}
