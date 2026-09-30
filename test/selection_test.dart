import 'package:icomoon_generator/src/common/selection.dart';
import 'package:test/test.dart';

void main() {
  test('parses the legacy IcoMoon selection format', () {
    final selection = Selection.fromJson({
      'metadata': {'name': 'legacy'},
      'icons': [
        {
          'properties': {'name': 'home', 'code': 57344},
        },
      ],
    });

    expect(selection.name, 'legacy');
    expect(selection.icons.single.properties.name, 'home');
    expect(selection.icons.single.properties.code, 57344);
  });

  test('parses the current IcoMoon glyph format', () {
    final selection = Selection.fromJson({
      'glyphs': [
        {
          'extras': {'name': 'thumbs-up', 'codePoint': 128077},
        },
      ],
    });

    expect(selection.icons.single.properties.name, 'thumbs-up');
    expect(selection.icons.single.properties.code, 128077);
  });

  test('rejects unknown JSON formats', () {
    expect(
      () => Selection.fromJson({}),
      throwsA(isA<FormatException>()),
    );
  });
}
