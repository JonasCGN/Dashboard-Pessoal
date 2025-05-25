import 'package:dashboard_pessoal/class/category/category.dart';
import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/provider/category_provider.dart';
import 'package:dashboard_pessoal/class/provider/edit_informations_provider.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:dashboard_pessoal/screen/partials/edit_informations/dynamic_icon_picker.dart';
import 'package:dashboard_pessoal/screen/partials/edit_informations/show_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class ListCategoryOptions extends StatelessWidget {
	const ListCategoryOptions({super.key});

	@override
	Widget build(BuildContext context) {

		return Consumer<EditInformationsProvider>(
			builder: (BuildContext context, EditInformationsProvider value, Widget? child) { 
				Categories categories = Provider.of<CategoryProvider>(context).categories;
				CategoryApp categorySelected = categories.categories[value.categoriaId!]!;
				String textCategory = categorySelected.name;
				MapEntry <int,int?> idIconCategory = categorySelected.icon.entries.first;

				Future<void> resgataOption() async {
					int? result = await showDialog(
						context: context, 
						builder: (context) => ShowCategories()
					);
					
					if(result != null){
						value.setCategoriaId(result);
					}
				}

				return Container(
					decoration: BoxDecoration(
						color: MiscellaneousColors.darkGray,
						borderRadius: BorderRadius.all(Radius.circular(10)),
					),
					padding: EdgeInsets.all(5),
					width: double.infinity,
					child: Row(
						mainAxisSize: MainAxisSize.max,
						mainAxisAlignment: MainAxisAlignment.spaceBetween,
						children: [
							Expanded(
								child: InkWell(
									onTap: () async {
										await resgataOption();
									},
									child: Row(
										mainAxisAlignment: MainAxisAlignment.spaceBetween,
										mainAxisSize: MainAxisSize.max,
										children: [
											Row(
												children: [
													(idIconCategory.value != null && value.iconsApp != null && value.iconsApp!.icons[idIconCategory.key] != null)
														? Container(
															padding: EdgeInsets.all(5),
															decoration: BoxDecoration(
																borderRadius: BorderRadius.circular(50),
																color: Color(idIconCategory.value!)
															),
															child: value.iconsApp!.icons[idIconCategory.key]!.svgShowBackground(
																25, IconColors.expenseIncome
															),
														)
														: SizedBox.shrink(),
													SizedBox(width: 5),
													Column(
														crossAxisAlignment: CrossAxisAlignment.start,
														children: [
															TextApp(
																texto: "Categoria",
																size: 20,
															),
															TextApp(
																texto: textCategory,
																size: 13,
															),
														],
													)
												],
											),
										],
									),
								),
							),
							Row(
								children: [
									Material(
										color: BackgroundAndBarColors.transparent,
										borderRadius: BorderRadius.all(Radius.circular(50)),
										child: InkWell(
											borderRadius: BorderRadius.all(Radius.circular(50)),
											onTap: () async {
												await resgataOption();
											},
											child: Icon(
												Icons.keyboard_arrow_down_rounded,
												size: 45,
												color: IconColors.category,
											),
										),
									),
									Material(
										color: BackgroundAndBarColors.transparent,
										borderRadius: BorderRadius.circular(50),
										child: InkWell(
											borderRadius: BorderRadius.circular(50),
											onTap: () async {
												final result = await showDialog(
													context: context, 
													builder: (context) {
														return DynamicIconPicker();
													}
												);
												print(result);
											},
											child: Icon(
												Icons.add,
												color: IconColors.category,
												size: 30,
											),
										),
									)
								],
							)
						],
					),
				);
			},	
		);
	}
}