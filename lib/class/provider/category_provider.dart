import 'package:flutter/material.dart';
import 'package:dashboard_pessoal/class/category/category.dart';

class CategoryProvider extends ChangeNotifier {
	final Categories _categories = Categories();

	Categories get categories => _categories;

	List<CategoryApp> get allCategories => _categories.getAllCategories();

	void addCategory(CategoryApp category) {
		_categories.addCategory(category);
		notifyListeners();
	}

	void removeCategoryByName(String name) {
		_categories.delCategory(name);
		notifyListeners();
	}

	CategoryApp? getCategoryByName(String name) {
		return _categories.getCategoryByName(name);
	}

	void updateCategory(CategoryApp category) {
		_categories.categories[category.id] = category;
		notifyListeners();
	}
}
