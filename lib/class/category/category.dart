import 'package:flutter/material.dart';

class CategoryApp {
	final int id;
	final String name;
	final Map<int,int?> icon;
	
	CategoryApp({
		required this.id,
		required this.name,
		required this.icon
	});

	factory CategoryApp.fromJson(Map<String, dynamic> json) {
		return CategoryApp(
			id: json['id'],
			name: json['name'],
			icon: json['icon'] != null
				? (json['icon'] as Map<String, dynamic>).map(
					(key, value) => MapEntry(int.parse(key), value == null ? null : int.tryParse(value.toString())))
				: <int, int?>{},
		);
	}

	Map<String, dynamic> toJson() {
		return {
			'id': id,
			'name': name,
			'icon': icon,
		};
	}

	Color converteHexaColor(id){
		int? colorHex = icon[id];
		if (colorHex == null) {
		  return Colors.white;
		}
		return Color(colorHex);
	}
}

class Categories {
	final Map<int, CategoryApp> categories;
	int id = 0 ;

	Categories()
		: categories = {
			1: CategoryApp(
				id: 1,
				name: 'Academia',
				icon: {7600783: 0xFF2196F3}, // Azul
			),
			2: CategoryApp(
				id: 2,
				name: 'Alimentação',
				icon: {7742389: 0xFFF44336}, // Vermelho
			),
			3: CategoryApp(
				id: 3,
				name: 'Saúde',
				icon: {7323095: 0xFF4CAF50}, // Verde
			),
			4: CategoryApp(
				id: 4,
				name: 'Finanças',
				icon: {607257: 0xFFFFC107}, // Amarelo
			),
		} {
			id = categories.length;
		}

	void addCategory(CategoryApp category) {
		categories[id] = category;
		id++;
	}

	void delCategory(String name) {
		categories.remove(name);
	}

	CategoryApp? getCategoryByName(String name) {
		return categories[name];
	}

	List<CategoryApp> getAllCategories() {
		return categories.values.toList();
	}

	// Para popular a partir de uma lista de JSONs
	factory Categories.fromJsonList(List<dynamic> jsonList) {
		final cats = Categories();
		for (var item in jsonList) {
		cats.addCategory(CategoryApp.fromJson(item));
		}
		return cats;
	}

	// Para exportar para lista de JSONs
	List<Map<String, dynamic>> toJsonList() {
		return categories.values.map((cat) => cat.toJson()).toList();
	}
}