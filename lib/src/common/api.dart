import 'package:icomoon_generator/src/common/selection.dart';
import 'package:icomoon_generator/src/utils/flutter_class_gen.dart';

/// Generates a Flutter-compatible class for a list of icons.
///
/// * [iconsList] is a list of non-default icons.
/// * [className] is generated class' name (preferably, in PascalCase).
/// * [familyName] is font's family name to use in IconData.
/// * [fontFileName] is font file's name. Used in generated docs for class.
/// * [package] is the name of a font package. Used to provide a font through package dependency.
/// * [indent] is a number of spaces in leading indentation for class' members. Defaults to 2.
///
/// Returns content of a class file.
String generateFlutterClass({
  required List<Icon> iconsList,
  String? className,
  String? familyName,
  String? fontFileName,
  String? package,
  int? indent,
}) {
  final generator = FlutterClassGenerator(
    iconsList,
    className: className,
    indent: indent,
    fontFileName: fontFileName,
    familyName: familyName,
    package: package,
  );

  return generator.generate();
}
