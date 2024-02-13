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
  final String name;
  final List<Icon> icons;

  /// Constructor
  Selection({
    required this.name,
    required this.icons,
  });

  /// Factory constructor
  factory Selection.fromJson(Map<String, dynamic> json) {
    final icons = json['icons'] as List<dynamic>;
    final name = json['metadata']['name'] as String;

    return Selection(
      name: name,
      icons: icons
          .map((icon) => Icon.fromJson(icon as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Icon {
  final IconProperties properties;

  Icon({
    required this.properties,
  });

  factory Icon.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'] as Map<String, dynamic>;

    return Icon(properties: IconProperties.fromJson(properties));
  }
}

/// Icon properties
/// This class is used to represent the properties of an icon.
/// It has a `name` and a `code`.
/// It has a factory constructor that takes a JSON object and returns a new instance of the class.
class IconProperties {
  final String name;
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
