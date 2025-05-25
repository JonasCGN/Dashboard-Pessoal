import 'package:dashboard_pessoal/class/color/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

class IconsAppSVG {
	final int id;
	final String file;
	final String category;
	List<String> tags;

	IconsAppSVG({
		required this.id,
		required this.file,
		required this.category,
		required this.tags,
	});

	SvgPicture svgShow(selectedIconId){
		return SvgPicture.asset(
				file,
				width: 40,
				height: 40,
				colorFilter: selectedIconId == id
					? ColorFilter.mode(Colors.blue, BlendMode.srcIn)
					: ColorFilter.mode(IconColors.category, BlendMode.srcIn)
		);
	}

	SvgPicture svgShowBackground(double size,Color cor){
		return SvgPicture.asset(
				file,
				width: size,
				height: size,
				colorFilter: ColorFilter.mode(cor, BlendMode.srcIn)
		);
	}
}

class IconsApp {
	Map<int, IconsAppSVG> icons = {};

	static Future<IconsApp> criar() async {
		final iconsMap = await listarTodosOsIconsComTagsMap();
		final instance = IconsApp();
		instance.icons = iconsMap;
		return instance;
	}

	static Future<List<String>> listarTodosOsIcons() async {
		final manifestContent = await rootBundle.loadString('AssetManifest.json');
		final Map<String, dynamic> manifestMap = json.decode(manifestContent);

		final svgPaths = manifestMap.keys.where((String key) =>
			key.startsWith('assets/icons/categorias/') && key.endsWith('.svg'));

		return svgPaths.toList();
	}

	Map<String, List<int>> filterIconsByQuery(String searchQuery) {
		final query = searchQuery.trim().toLowerCase();
		Map<String, List<int>> categorizedIcons = {};
		
		icons.forEach((id, iconData) {
			final tagsLower = iconData.tags.map((tag) => tag.toLowerCase()).toList();
			final categoryLower = iconData.category.toLowerCase();
			bool matches = query.isEmpty ||
				tagsLower.any((tag) => tag.contains(query)) ||
				categoryLower.contains(query);

			if (matches) {
				String category = iconData.category.isNotEmpty ? iconData.category : 'Outros';
				categorizedIcons.putIfAbsent(category, () => []);
				categorizedIcons[category]!.add(id);
			}
		});
		return categorizedIcons;
	}

	static Future<Map<int, IconsAppSVG>> listarTodosOsIconsComTagsMap() async {
		final manifestContent = await rootBundle.loadString('AssetManifest.json');
		final Map<String, dynamic> manifestMap = json.decode(manifestContent);
		final svgPaths = manifestMap.keys.where((String key) =>
			key.startsWith('assets/icons/categorias/') && key.endsWith('.svg'));
		final jsonPaths = manifestMap.keys.where((String key) =>
			key.startsWith('assets/icons/categorias/') && key.endsWith('.json'));

		Map<String, dynamic> jsonDataByFile = {};
		for (final jsonPath in jsonPaths) {
			final jsonString = await rootBundle.loadString(jsonPath);
			final data = json.decode(jsonString);
			if (data is List) {
				for (var item in data) {
					if (item is Map && item['file'] != null) {
						final fileName = item['file'].toString().split('.').first;
						jsonDataByFile[fileName] = item;
					}
				}
			} else if (data is Map && data['file'] != null) {
				final fileName = data['file'].toString().split('.').first;
				jsonDataByFile[fileName] = data;
			}
		}

		int id = 0;
		Map<int, IconsAppSVG> iconsMap = {};
		for (final path in svgPaths) {
			final parts = path.split('/');
			List<String> tags = [];
			String fileName = '';
			int iconId = id;
			String category = '';
			if (parts.isNotEmpty) {
				fileName = parts.last.split('.').first;
			}
			if (parts.length >= 4) {
				category = parts[3];
			}
			if (jsonDataByFile.containsKey(fileName)) {
				final jsonIcon = jsonDataByFile[fileName];
				tags = List<String>.from(jsonIcon['tags'] ?? []);
				if (jsonIcon['id'] != null) {
					iconId = int.tryParse(jsonIcon['id'].toString()) ?? id;
				}
			}
			else {
				if (category.isNotEmpty) tags.add(category);
				if (fileName.isNotEmpty) tags.add(fileName);
			}
			iconsMap[iconId] = IconsAppSVG(
				id: iconId,
				file: path,
				category: category,
				tags: tags,
			);
			id++;
		}
		return iconsMap;
	}
}