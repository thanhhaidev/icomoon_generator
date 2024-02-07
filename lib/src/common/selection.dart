class SelectionModel {
  final List<IcomoonIcon> icons;

  SelectionModel({
    required this.icons,
  });

  factory SelectionModel.fromJson(Map<String, dynamic> json) {
    final icons = json['icons'] as List<dynamic>;

    return SelectionModel(
        icons: icons
            .map((icon) => IcomoonIcon.fromJson(icon as Map<String, dynamic>))
            .toList());
  }
}

class IcomoonIcon {
  final IconProperties properties;

  IcomoonIcon({
    required this.properties,
  });

  factory IcomoonIcon.fromJson(Map<String, dynamic> json) {
    final properties = json['properties'] as Map<String, dynamic>;

    return IcomoonIcon(properties: IconProperties.fromJson(properties));
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
