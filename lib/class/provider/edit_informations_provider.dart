import 'package:dashboard_pessoal/class/icons/icons.dart';
import 'package:dashboard_pessoal/class/transactions/transactions.dart';
import 'package:flutter/material.dart';

class EditInformationsProvider extends ChangeNotifier {
	String descricao = '';
	double? valor;
	int? categoriaId = 1;
	DateTime dateVenc = DateTime.now();
	DateTime dateLan = DateTime.now();
	TransactionType? typeTransaction;
	EfitevedTransaction? process = EfitevedTransaction.loading;
	IconsApp? iconsApp;

	EditInformationsProvider() {
		_initIcons();
	}

	Future<void> _initIcons() async {
		iconsApp = await IconsApp.criar();
		notifyListeners();
	}

	void setDescricao(String value) {
		descricao = value;
		notifyListeners();
	}

	void setValor(double value) {
		valor = value;
		notifyListeners();
	}

	void setCategoriaId(int? value) {
		categoriaId = value;
		notifyListeners();
	}

	void setDateVenc(DateTime value) {
		dateVenc = value;
		notifyListeners();
	}

	void setDateLan(DateTime value) {
		dateLan = value;
		notifyListeners();
	}

	void setTypeTransaction(TransactionType? value) {
		typeTransaction = value;
		notifyListeners();
	}

	void setProcess(EfitevedTransaction? value) {
		process = value;
		notifyListeners();
	}

	void setIconsApp(IconsApp? value) {
		iconsApp = value;
		notifyListeners();
	}

	Transaction getFormData() {
		return Transaction(
			id: Transactions.idTransaction++,
			description: descricao,
			amount: valor!,
			dateVenc: dateVenc,
			dateLanc: DateTime.now(),
			type: typeTransaction!,
			process: process!,
			category: categoriaId!,
		);
	}

	void showFormData() {
		print(descricao);
		print(valor);
		print(categoriaId);
		print(dateVenc);
		print(dateLan);
		print(typeTransaction);
		print(process);
		print(iconsApp);
	}

	bool validateDescricao() {
		return descricao.trim().isNotEmpty;
	}

	bool validateValor() {
		return valor != 0.0;
	}

	bool validateCategoriaId() {
		return categoriaId != null;
	}

	bool validate() {
		return validateDescricao() && validateValor() && validateCategoriaId();
	}
}