import 'package:recase/recase.dart';

import 'package:icomoon_generator/src/common/constant.dart';
import 'package:icomoon_generator/src/common/selection.dart';

const _kUnnamedIconName = 'unnamed';
const _kDefaultIndent = 2;
const _kDefaultClassName = 'UiIcons';
const _kDefaultFontFileName = 'icomoon.ttf';
const _kDefaultFontFamily = 'Icomoon';
final _iconNameRegex = RegExp(r"[^A-Za-z0-9_]");

const _kDartReserved = [
  'abstract',
  'deferred',
  'if',
  'super',
  'as ',
  'do',
  'implements',
  'switch',
  'assert',
  'dynamic',
  'import',
  'sync',
  'async',
  'else',
  'in',
  'this',
  'enum',
  'is',
  'throw',
  'await',
  'export',
  'library',
  'true',
  'break',
  'external',
  'new',
  'try',
  'case',
  'extends',
  'null',
  'typedef',
  'catch',
  'factory',
  'operator',
  'var',
  'class',
  'false',
  'part',
  'void',
  'const',
  'final',
  'rethrow',
  'while',
  'continue',
  'finally',
  'return',
  'with',
  'covariant',
  'for',
  'set',
  'yield',
  'default',
  'get',
  'static',
  'yield'
];

/// A map which adjusts icon ids starting with a number
///
/// Some icons cannot keep their id as identifier, as dart does not allow
/// numbers as the beginning of a variable names. The chosen solution is, to
/// write those parts out.
const Map<String, String> _kNameAdjustments = {
  "500px": "fiveHundredPx",
  "360-degrees": "threeHundredSixtyDegrees",
  "1": "one",
  "2": "two",
  "3": "three",
  "4": "four",
  "5": "five",
  "6": "six",
  "7": "seven",
  "8": "eight",
  "9": "nine",
  "0": "zero",
  "42-group": "fortyTwoGroup",
  "00": "zeroZero",
  // found in aliases
  "100": "hundred",
};

/// Returns a normalized version of [iconName] which can be used as const name
///
/// [nameAdjustments] lists some icons which need special treatment to be valid
/// const identifiers, as they cannot start with a number.
String normalizeIconName(String iconName) {
  iconName = _kNameAdjustments[iconName] ?? iconName;
  return iconName.camelCase;
}

String convertIconName(String name) {
  String out = name.replaceAll(_iconNameRegex, '_');
  for (String r in _kDartReserved) {
    if (out == r) {
      out = "${out}_icon";
      break;
    }
  }
  return out;
}

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
  /// * [familyName] is font's family name to use in IconData.
  /// * [package] is the name of a font package. Used to provide a font through package dependency.
  /// * [fontFileName] is font file's name. Used in generated docs for class.
  /// * [indent] is a number of spaces in leading indentation for class' members. Defaults to 2.
  FlutterClassGenerator(
    this.iconList, {
    String? className,
    String? familyName,
    String? fontFileName,
    String? package,
    int? indent,
  })  : _indent = ' ' * (indent ?? _kDefaultIndent),
        _className = _getVarName(className ?? _kDefaultClassName),
        _familyName = familyName ?? _kDefaultFontFamily,
        _fontFileName = fontFileName ?? _kDefaultFontFileName,
        _iconVarNames = _generateVariableNames(iconList),
        _package = package?.isEmpty ?? true ? null : package;

  final List<Icon> iconList;
  final String _className;
  final String _familyName;
  final String _fontFileName;
  final String _indent;
  final String? _package;
  final List<String> _iconVarNames;

  static List<String> _generateVariableNames(List<Icon> iconList) {
    final iconNameSet = <String>{};

    return iconList.map((icon) {
      final properties = icon.properties;
      final name = properties.name;
      final baseName = convertIconName(normalizeIconName(name)).camelCase;
      final usingDefaultName = baseName.isEmpty;

      var variableName = usingDefaultName ? _kUnnamedIconName : baseName;

      // Handling same names by adding numeration to them
      if (iconNameSet.contains(variableName)) {
        // If name already contains numeration, then splitting it
        final countMatch = RegExp(r'^(.*)_([0-9]+)$').firstMatch(variableName);

        var variableNameCount = 1;
        var variableWithoutCount = variableName;

        if (countMatch != null) {
          variableNameCount = int.parse(countMatch.group(2)!);
          variableWithoutCount = countMatch.group(1)!;
        }

        String variableNameWithCount;

        do {
          variableNameWithCount =
              '${variableWithoutCount}_${++variableNameCount}';
        } while (iconNameSet.contains(variableNameWithCount));

        variableName = variableNameWithCount;
      }

      iconNameSet.add(variableName);

      return variableName;
    }).toList();
  }

  bool get _hasPackage => _package != null;

  String get _fontFamilyConst => "static const iconFontFamily = 'Icomoon';";

  String get _fontPackageConst => "static const iconFontPackage = '$_package';";

  List<String> _generateIconConst(int index) {
    final properties = iconList[index].properties;

    final iconName = properties.name;
    final hexCode = properties.code.toRadixString(16);
    final varName = _iconVarNames[index];

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
///     - family: $_familyName
///       fonts:
///         - asset: fonts/$_fontFileName
/// ```
class $_className {
$classContentString
}
''';
  }
}
