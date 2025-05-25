import 'dart:io';

import 'package:flutter/material.dart';

void main() {
	String relativePath = "../../";
	final svgRoot = Directory('${relativePath}assets/icons');

	if (!svgRoot.existsSync()) {
		debugPrint('❌ Pasta assets/icons não encontrada.');
		return;
	}

	final foldersWithSvgs = <String>{};

	for (final entity in svgRoot.listSync(recursive: true)) {
		if (entity is File && entity.path.toLowerCase().endsWith('.svg')) {
		final folder = File(entity.path).parent.path.replaceAll('\\', '/').replaceAll(relativePath, '');
		foldersWithSvgs.add(folder.endsWith('/') ? folder : '$folder/');
		}
	}

	if (foldersWithSvgs.isEmpty) {
		debugPrint('⚠️ Nenhum SVG encontrado.');
		return;
	}

	debugPrint('\n🔖 Cole isso no seu pubspec.yaml:\n');
	debugPrint('flutter:');
	debugPrint('  assets:');
	for (final folder in foldersWithSvgs.toList()..sort()) {
		debugPrint("    - $folder");
	}

	debugPrint('\n✅ Total: ${foldersWithSvgs.length} pastas com SVGs encontradas.');
}
