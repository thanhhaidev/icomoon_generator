import 'package:icomoon_generator/src/common/selection.dart';
import 'package:icomoon_generator/src/utils/flutter_class_gen.dart';

/// Generates a Flutter-compatible class for a list of glyphs.
///
/// * [glyphList] is a list of non-default glyphs.
/// * [className] is generated class' name (preferably, in PascalCase).
/// * [package] is the name of a font package. Used to provide a font through package dependency.
/// * [indent] is a number of spaces in leading indentation for class' members. Defaults to 2.
///
/// Returns content of a class file.
String generateFlutterClass({
  required List<IcomoonIcon> iconsList,
  String? className,
  String? familyName,
  String? package,
  int? indent,
}) {
  final generator = FlutterClassGenerator(
    iconsList,
    className: className,
    indent: indent,
    package: package,
  );

  return generator.generate();
}
