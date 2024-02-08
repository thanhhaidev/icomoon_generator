class Selection {
  final List<Icon> icons;

  Selection({
    required this.icons,
  });

  factory Selection.fromJson(Map<String, dynamic> json) {
    final icons = json['icons'] as List<dynamic>;

    return Selection(
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

class IconProperties {
  final String name;
  final int code;

  IconProperties({
    required this.name,
    required this.code,
  });

  factory IconProperties.fromJson(Map<String, dynamic> json) {
    return IconProperties(
      name: json['name'] as String,
      code: json['code'] as int,
    );
  }
}
