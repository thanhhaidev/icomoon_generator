# Example

File structure:
```
project
└───fonts
│   │   icomoon.tff
│   │   selection.json
│   
└───lib
│   │   ui
│   │   main.dart
```
Run command:
```
$ flutter pub run icomoon_generator:generator
```
Generates:
```
project
└───fonts
│   │   icomoon.tff
│   │   selection.json
│   
└───lib
│   └───ui
│   |   │   icons.dart
│   │
│   │   main.dart
```
Generated icons.dart:
```dart
// GENERATED CODE - DO NOT MODIFY BY HAND

import 'package:flutter/widgets.dart';

class UiIcons {
  UiIcons._();

  static const iconFontFamily = 'Icomoon';

/// Font icon named "__home__"
  static const IconData home = IconData(0xe900, fontFamily: iconFontFamily);

  /// Font icon named "__home2__"
  static const IconData home2 = IconData(0xe901, fontFamily: iconFontFamily);

  /// Font icon named "__home3__"
  static const IconData home3 = IconData(0xe902, fontFamily: iconFontFamily);

  /// Font icon named "__office__"
  static const IconData office = IconData(0xe903, fontFamily: iconFontFamily);
}
```
And also need add font to pubspec.yaml:
```yaml
...

flutter:
  fonts:
    - family: Icomoon
      fonts:
        - asset: fonts/icomoon.ttf
```