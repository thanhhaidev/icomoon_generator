/// Selection model
///
/// This model is used to represent the selection of icons from the API.
///
/// The `Selection` class has a `name` and a list of `Icon` objects.
///
/// The `Icon` class has a `properties` object.
///
/// The `IconProperties` class has a `name` and a `code`.
///
/// The `Selection` and `Icon` classes have a factory constructor that takes a JSON object and returns a new instance of the class.
class Selection {
  /// The name of the selection.
  final String name;

  /// A list of icons.
  final List<Icon> icons;

  /// Constructor
  Selection({
    required this.name,
    required this.icons,
  });

  /// Factory constructor
  factory Selection.fromJson(Map<String, dynamic> json) {
    final legacyIcons = json['icons'];
    if (legacyIcons is List) {
      final metadata = json['metadata'];
      final name = metadata is Map ? metadata['name'] as String : '';

      return Selection(
        name: name,
        icons: legacyIcons
            .map((icon) => Icon.fromJson(icon as Map<String, dynamic>))
            .toList(),
      );
    }

    final glyphs = json['glyphs'];
    if (glyphs is List) {
      return Selection(
        name: json['name'] as String? ?? '',
        icons: glyphs
            .map((glyph) => Icon.fromIcoMoonGlyph(
                  glyph as Map<String, dynamic>,
                ))
            .toList(),
      );
    }

    throw const FormatException(
      'Unsupported IcoMoon JSON format: expected "icons" or "glyphs".',
    );
  }
}

/// Icon model
/// This class is used to represent an icon.
/// It has a `properties` object.
class Icon {
  /// Icon properties
  /// This class is used to represent the properties of an icon.
  final IconProperties properties;

  /// Constructor
  Icon({
    required this.properties,
  });

  /// Factory constructor
  factory Icon.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'] as Map<String, dynamic>;

    return Icon(properties: IconProperties.fromJson(properties));
  }

  /// Creates an icon from the glyph shape emitted by the current IcoMoon UI.
  factory Icon.fromIcoMoonGlyph(Map<String, dynamic> json) {
    final extras = json['extras'] as Map<String, dynamic>;

    return Icon(
      properties: IconProperties(
        name: extras['name'] as String,
        code: extras['codePoint'] as int,
      ),
    );
  }
}

/// Icon properties
/// This class is used to represent the properties of an icon.
/// It has a `name` and a `code`.
/// It has a factory constructor that takes a JSON object and returns a new instance of the class.
class IconProperties {
  /// The name of the icon.
  final String name;

  /// The code of the icon.
  final int code;

  /// Constructor
  IconProperties({
    required this.name,
    required this.code,
  });

  /// Factory constructor
  factory IconProperties.fromJson(Map<String, dynamic> json) {
    return IconProperties(
      name: json['name'] as String,
      code: json['code'] as int,
    );
  }
}
