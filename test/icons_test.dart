import 'package:flutter_test/flutter_test.dart';
import 'package:dashboard_pessoal/class/icons/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

void svgShow(){
    test('svgShow returns SvgPicture.asset with correct color', () {
      final icon = IconsAppSVG(
			id: 1,
			file: 'assets/icons/categorias/bank/svgs/1.svg',
			category: 'bank',
			tags: ['bank', '1'],
      );
      final widget = icon.svgShow(1);
      expect(widget, isA<SvgPicture>());
      expect(widget.width, 40);
      expect(widget.height, 40);
    });
}

void listarTodosOsIcons(){
	test('listarTodosOsIcons retorna lista de strings', () async {
      // O AssetManifest.json precisa estar disponível no ambiente de teste
      final icons = await IconsApp.listarTodosOsIcons();
      expect(icons, isA<List<String>>());
    });
}

void listarTodosOsIconsComTagsMap(){
	test('listarTodosOsIconsComTagsMap retorna mapa de IconsAppSVG', () async {
      final iconsMap = await IconsApp.listarTodosOsIconsComTagsMap();
      expect(iconsMap, isA<Map<int, IconsAppSVG>>());
      if (iconsMap.isNotEmpty) {
        final icon = iconsMap.values.first;
        expect(icon, isA<IconsAppSVG>());
        expect(icon.file, isNotEmpty);
        expect(icon.category, isNotEmpty);
        expect(icon.tags, isA<List<String>>());
      }
    });
}

void main() {
  	TestWidgetsFlutterBinding.ensureInitialized();

  	svgShow();
	listarTodosOsIcons();
	listarTodosOsIconsComTagsMap();
}
