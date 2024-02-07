# icomoon_generator

[![pub package](https://img.shields.io/pub/v/icomoon_generator.svg)](https://pub.dartlang.org/packages/icomoon_generator)

The icomoon_generator package provides an easy way to generate Flutter-compatible class. This class contains static const IconData fields for each icon in your IcoMoon selection.

The package is written fully in Dart and doesn't require any external dependency.

## Font generation

### Install via dev dependency

```shell
$ flutter pub add --dev icomoon_generator

# And it's ready to go:
$ flutter pub run icomoon_generator:generate <input-json-file> <output-class-file> [options]
```

### or [Globally activate][] the package:

[globally activate]: https://dart.dev/tools/pub/cmd/pub-global

```shell
$ pub global activate icomoon_generator

# And it's ready to go:
$ icomoon_generator <input-svg-dir> <output-font-file> [options]
```

Required positional arguments:
- `<input-svg-dir>`
Path to the input directory that contains .svg files.
- `<output-class-file>`
Path to the output class file. Should have .json extension.

Flutter class options:
- `-c` or `--class-name=<name>`
Name for a generated class.
- `-p` or `--package=<name>`
Name of a package that provides a font. Used to provide a font through package dependency.
- `--[no-]format`
Format dart generated code.

Other options:
- `-z` or `--config-file=<path>`
Path to icomoon_generator yaml configuration file.
pubspec.yaml and icon_font.yaml files are used by default.
- `-v` or `--verbose`
Display every logging message.
- `-h` or `--help`
Shows usage information.

*Usage example:*

```shell
$ icomoon_generator fonts/selection.json lib/my_icons.dart --class-file=MyIcons -v
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

icomoon_generator's configuration can also be placed in yaml file.
Add _icomoon_generator_ section to either `pubspec.yaml` or `icomoon_generator.yaml` file:

```yaml
icon_font:
  input_json_file: "fonts/selection.json"
  output_class_file: "lib/my_icons.dart"
  
  class_name: "MyIcons"
  package: my_font_package
  format: true

  verbose: false
```

`input_json_file` and `output_class_file` keys are required.
It's possible to specify any other config file by using `--config-file` option.

## Contributing

Any suggestions, issues, pull requests are welcomed.

## License

[MIT](https://github.com/thanhhaidev/icomoon_generator/blob/master/LICENSE)
