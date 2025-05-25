import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:dashboard_pessoal/class/icons/icons.dart';
import 'package:dashboard_pessoal/class/provider/category_provider.dart';
import 'package:dashboard_pessoal/class/provider/edit_informations_provider.dart';
import 'package:dashboard_pessoal/class/text/fonte.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ShowCategories extends StatelessWidget {
	const ShowCategories({super.key});

	@override
	Widget build(BuildContext context) {

		return Consumer<CategoryProvider>(
			builder: (BuildContext context, CategoryProvider value, Widget? child) { 
				final List<int> categoriesName = value.categories.categories.keys.toList();
				IconsApp? iconsApp = Provider.of<EditInformationsProvider>(context).iconsApp;
				
				if (categoriesName.isEmpty) {
					return Dialog(
						child: Container(
							width: 200,
							height: 100,
							alignment: Alignment.center,
							child: TextApp(
								texto: 'Nenhuma categoria cadastrada',
								size: 18,
							),
						),
					);
				}
				return Dialog(
					child: Container(
						width: 200,
						height: 300,
						padding: EdgeInsets.all(10),
						decoration: BoxDecoration(
							color: BackgroundAndBarColors.barColor,
							borderRadius: BorderRadius.circular(10)
						),
						child: Column(
							children: [
								Expanded(
									child: ListView.separated(
										separatorBuilder: (BuildContext context, int index) => const Divider(),
										itemCount: categoriesName.length,
										itemBuilder: (context, index) {
											final category = value.categories.categories[index + 1];
											if (category == null || category.icon.isEmpty) {
												return ListTile(
													title: TextApp(
														texto: value.categories.categories[index+1]!.name,
														size: 20,
													),
												);
											}
											final iconId = category.icon.keys.first;
											final iconColor = category.icon[iconId];
											Color color = Color(iconColor!);
											final iconData = iconsApp?.icons[iconId];
											return ListTile(
												leading: iconData != null
													? Container(
														padding: EdgeInsets.all(5),
														decoration: BoxDecoration(
															color: color,
															borderRadius: BorderRadius.circular(50),
														),
														child: SvgPicture.asset(
															iconData.file,
															width: 25,
															height: 25,
															colorFilter: ColorFilter.mode(
																IconColors.expenseIncome,
																BlendMode.srcIn,
															),
														),
													)
													: null,
												title: TextApp(
													texto: value.categories.categories[index+1]!.name,
													size: 20,
												),
												onTap: () {
													Navigator.of(context).pop(categoriesName[index]);
												},
											);
										},
									),
								)
							],
						),
					),
				);
			},
		);
	}
}
