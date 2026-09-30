# icomoon_generator

[![pub package](https://img.shields.io/pub/v/icomoon_generator.svg)](https://pub.dartlang.org/packages/icomoon_generator)

The icomoon_generator package provides an easy way to generate Flutter-compatible class. This class contains static const IconData fields for each icon in your IcoMoon selection.

The package is written fully in Dart and doesn't require any external dependency.

## Generate Flutter icons

The generator creates the Dart `IconData` class. The IcoMoon `.ttf` font is
downloaded separately and must be declared as a Flutter asset.

### Install via dev dependency

```shell
$ flutter pub add --dev icomoon_generator

# And it's ready to go:
$ dart run icomoon_generator:generator <input-json-file> <output-class-file> [options]
```

### or [Globally activate][] the package:

[globally activate]: https://dart.dev/tools/pub/cmd/pub-global

```shell
$ dart pub global activate icomoon_generator

# And it's ready to go:
$ icomoon_generator <input-json-file> <output-class-file> [options]
```

Required positional arguments:

- `<input-json-file>`
  Path to the local input JSON file. Should have a `.json` extension.
- `<output-class-file>`
  Path to the output class file. Should have .dart extension.

Flutter class options:

- `-c` or `--class-name=<name>`
  Name for a generated class.
- `-p` or `--package=<name>`
  Name of a package that provides a font. Used to provide a font through package dependency.
- `--family-name=<name>`
  Font family name used in generated `IconData`. Defaults to `Icomoon`.
- `--font-file-name=<name>`
  Font asset file name used in generated documentation. Defaults to `icomoon.ttf`.
- `--[no-]format`
  Format dart generated code.

Other options:

- `-z` or `--config-file=<path>`
  Path to icomoon_generator yaml configuration file.
  pubspec.yaml and icomoon_generator.yaml files are used by default.
- `-v` or `--verbose`
  Display every logging message.
- `-h` or `--help`
  Shows usage information.

_Usage example:_

```shell
$ icomoon_generator fonts/selection.json lib/my_icons.dart --class-name=MyIcons -v
```

Updated Flutter project's pubspec.yaml:

```yaml
flutter:
  fonts:
    - family: Icomoon
      fonts:
        - asset: fonts/icomoon.ttf
```

## Config file

icomoon*generator's configuration can also be placed in yaml file.
Add \_icomoon_generator* section to either `pubspec.yaml` or `icomoon_generator.yaml` file:

```yaml
icomoon_generator:
  input_json_file: "fonts/selection.json"
  output_class_file: "lib/my_icons.dart"

  class_name: "MyIcons"
  package: my_font_package
  family_name: Icomoon
  font_file_name: icomoon.ttf
  format: true

  verbose: false
```

`input_json_file` and `output_class_file` keys are required.
It's possible to specify any other config file by using `--config-file` option.

## IcoMoon v1 and v2

The generator accepts both IcoMoon JSON formats:

### v1 — Legacy IcoMoon UI

The legacy UI exports a selection file with `icons[].properties`:

```json
{
  "icons": [
    {
      "properties": {
        "name": "home",
        "code": 59648
      }
    },
    {
      "properties": {
        "name": "home2",
        "code": 59649
      }
    },
    {
      "properties": {
        "name": "home3",
        "code": 59650
      }
    },
    {
      "properties": {
        "name": "office",
        "code": 59651
      }
    }
  ],
  "metadata": {
    "name": "untitled-project"
  }
}
```

The v1 workflow uses two matching local files:

- `fonts/selection_v1.json`
- `fonts/icomoon_v1.ttf`

Generate the v1 class:

```shell
$ icomoon_generator \
  fonts/selection_v1.json \
  lib/my_icons_v1.dart \
  --class-name=V1Icons \
  --family-name=IcomoonV1 \
  --font-file-name=icomoon_v1.ttf
```

Declare the v1 font:

```yaml
flutter:
  fonts:
    - family: IcomoonV1
      fonts:
        - asset: fonts/icomoon_v1.ttf
```

The generated `V1Icons` class must use `fontFamily: IcomoonV1`.

### v2 — Current IcoMoon UI

The v2 UI exports `glyphs[].extras` instead of `icons[].properties`:

```json
{
  "formats": [
    {
      "item": {
        "tag": "ItemFont"
      }
    }
  ],
  "glyphs": [
    {
      "extras": {
        "name": "bookmark",
        "codePoint": 128278
      }
    }
  ]
}
```

Download the v2 JSON to a local file before running the generator:

```shell
$ curl -fsSL \
  https://i.icomoon.io/public/temp/<id>/<project>/0/<project>.icomoon.json \
  -o fonts/selection.json
$ icomoon_generator fonts/selection.json lib/my_icons_v2.dart
```

Download the matching v2 font from the same project and save it locally as
`fonts/icomoon.ttf` before declaring it as a Flutter asset.

Generate the v2 class:

```shell
$ icomoon_generator \
  fonts/selection.json \
  lib/my_icons_v2.dart \
  --class-name=V2Icons \
  --family-name=IcomoonV2 \
  --font-file-name=icomoon.ttf
```

Declare the v2 font:

```yaml
flutter:
  fonts:
    - family: IcomoonV2
      fonts:
        - asset: fonts/icomoon.ttf
```

The generated `V2Icons` class must use `fontFamily: IcomoonV2`.

### Using v1 and v2 together

Keep each version's JSON, font, generated class, and font family separate:

```text
fonts/
├── selection_v1.json
├── icomoon_v1.ttf
├── selection.json
└── icomoon.ttf

lib/
├── my_icons_v1.dart  # V1Icons, IcomoonV1
└── my_icons_v2.dart  # V2Icons, IcomoonV2
```

Always use the `.ttf` exported by the same IcoMoon project and selection as
the JSON. Do not use the v1 font with v2 code points, or the v2 font with v1
code points.

## Contributing

Any suggestions, issues, pull requests are welcomed.

## License

[MIT](https://github.com/thanhhaidev/icomoon_generator/blob/master/LICENSE)
