import 'package:recase/recase.dart';

import 'package:icomoon_generator/src/common/constant.dart';
import 'package:icomoon_generator/src/common/selection.dart';

const _kDefaultIndent = 2;
const _kDefaultClassName = 'UiIcons';

/// Removes any characters that are not valid for variable name.
///
/// Returns a new string.
String _getVarName(String string) {
  final replaced = string.replaceAll(RegExp(r'[^a-zA-Z0-9_$]'), '');
  return RegExp(r'^[a-zA-Z$].*').firstMatch(replaced)?.group(0) ?? '';
}

/// A helper for generating Flutter-compatible class with IconData objects for each icon.
class FlutterClassGenerator {
  /// * [glyphList] is a list of non-default glyphs.
  /// * [className] is generated class' name (preferably, in PascalCase).
  /// * [package] is the name of a font package. Used to provide a font through package dependency.
  /// * [indent] is a number of spaces in leading indentation for class' members. Defaults to 2.
  FlutterClassGenerator(
    this.iconList, {
    String? className,
    String? package,
    int? indent,
  })  : _indent = ' ' * (indent ?? _kDefaultIndent),
        _className = _getVarName(className ?? _kDefaultClassName),
        _package = package?.isEmpty ?? true ? null : package;

  final List<IcomoonIcon> iconList;
  final String _className;
  final String _indent;
  final String? _package;

  bool get _hasPackage => _package != null;

  String get _fontFamilyConst => "static const iconFontFamily = 'Icomoon';";

  String get _fontPackageConst => "static const iconFontPackage = '$_package';";

  List<String> _generateIconConst(int index) {
    final properties = iconList[index].properties;

    final iconName = properties.name;
    final hexCode = properties.code.toRadixString(16);
    final varName = ReCase(iconName).camelCase;

    final posParamList = [
      'fontFamily: iconFontFamily',
      if (_hasPackage) 'fontPackage: iconFontPackage'
    ];

    final posParamString = posParamList.join(', ');

    return [
      '',
      '/// Font icon named "__${iconName}__"',
      'static const IconData $varName = IconData(0x$hexCode, $posParamString);'
    ];
  }

  /// Generates content for a class' file.
  String generate() {
    final classContent = [
      'const $_className._();',
      '',
      _fontFamilyConst,
      if (_hasPackage) _fontPackageConst,
      for (var i = 0; i < iconList.length; i++) ..._generateIconConst(i),
    ];

    final classContentString =
        classContent.map((e) => e.isEmpty ? '' : '$_indent$e').join('\n');

    return '''// Generated code: do not hand-edit.

// Generated using $kVendorName.
// Copyright © ${DateTime.now().year} $kVendorName ($kVendorUrl).

import 'package:flutter/widgets.dart';

/// Identifiers for the icons.
///
/// Use with the [Icon] class to show specific icons.
///
/// Icons are identified by their name as listed below.
///
/// To use this class, make sure you declare the font in your
/// project's `pubspec.yaml` file in the `fonts` section. This ensures that
/// the "Icomoon" font is included in your application. This font is used to
/// display the icons. For example:
/// 
/// ```yaml
/// flutter:
///   fonts:
///     - family: Icomoon
///       fonts:
///         - asset: fonts/icomoon.ttf
/// ```
class $_className {
$classContentString
}
''';
  }
}
