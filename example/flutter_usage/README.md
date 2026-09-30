# IcoMoon v1 and v2 example

This example renders both supported IcoMoon formats side by side:

- **IcoMoon v1 (legacy):** `icons[].properties`, `icomoon_v1.ttf`,
  `V1Icons`
- **IcoMoon v2 (current UI):** `glyphs[].extras`, `icomoon.ttf`, `V2Icons`

## IcoMoon v2 assets

The current IcoMoon export JSON is:

```text
https://i.icomoon.io/public/temp/536abd6d67/icomoon-generator/0/icomoon-generator.icomoon.json
```

The matching font is exposed by the same IcoMoon project at:

```text
https://i.icomoon.io/public/temp/536abd6d67/icomoon-generator/0/font/fonts/Untitled.ttf
```

It is checked in as `fonts/icomoon.ttf` because Flutter loads fonts from
declared local assets at runtime.

The matching v2 font is checked in as `fonts/icomoon.ttf`. The downloaded JSON
is configured in `icomoon_generator.yaml` so the example build does not depend
on the network. Regenerate the v2 class with:

```shell
cd example/flutter_usage
dart run ../../bin/generator.dart --config-file=icomoon_generator.yaml
```

The generated class is `lib/ui/icons_v2.dart`, and the Flutter screen displays
a selection of `V2Icons`.

## IcoMoon v1 assets

The legacy selection is stored in `fonts/selection_v1.json`, and its matching
font is stored in `fonts/icomoon_v1.ttf`. Regenerate the v1 class with:

```shell
dart run ../../bin/generator.dart \
  --config-file=icomoon_generator_v1.yaml
```

The generated class is `lib/ui/icons_v1.dart`.

File structure:

```
project
└───fonts
│   │   icomoon.ttf
│   │   icomoon_v1.ttf
│   │   selection.json
│   │   selection_v1.json
│
└───lib
│   │   ui
│   │   main.dart
│   │   ui/icons_v1.dart
│   │   ui/icons_v2.dart
```

Run command:

```
$ dart run icomoon_generator:generator
```

Generates:

```
project
└───fonts
│   │   icomoon.ttf
│   │   icomoon_v1.ttf
│   │   selection.json
│   │   selection_v1.json
│
└───lib
│   └───ui
│   |   │   icons_v1.dart
│   |   │   icons_v2.dart
│   │
│   │   main.dart
│   │   ui/icons_v1.dart
│   │   ui/icons_v2.dart
```

The generated classes are consumed by the Flutter app through `V1Icons` and
`V2Icons`. Both matching fonts are declared in `pubspec.yaml`:

```yaml
---
flutter:
  fonts:
    - family: IcomoonV1
      fonts:
        - asset: fonts/icomoon_v1.ttf
    - family: IcomoonV2
      fonts:
        - asset: fonts/icomoon.ttf
```
