import 'package:args/args.dart';

import 'arguments.dart';

void defineOptions(ArgParser argParser) {
  argParser
    ..addSeparator('Flutter class options:')
    ..addOption(
      kOptionNames[CliArgument.className]!,
      abbr: 'c',
      help: 'Name for a generated class.',
      valueHelp: 'name',
    )
    ..addOption(
      kOptionNames[CliArgument.fontPackage]!,
      abbr: 'f',
      help:
          'Name of a package that provides a font. Used to provide a font through package dependency.',
      valueHelp: 'name',
    )
    ..addOption(
      kOptionNames[CliArgument.familyName]!,
      help: 'Font family name used by generated IconData.',
      valueHelp: 'name',
    )
    ..addOption(
      kOptionNames[CliArgument.fontFileName]!,
      help: 'Font asset file name used in generated documentation.',
      valueHelp: 'name',
    )
    ..addFlag(
      kOptionNames[CliArgument.format]!,
      help: 'Formate dart generated code.',
      defaultsTo: kDefaultFormat,
    )
    ..addSeparator('Other options:')
    ..addOption(
      kOptionNames[CliArgument.configFile]!,
      abbr: 'z',
      help:
          'Path to icomoon_generator yaml configuration file. pubspec.yaml and icomoon_generator.yaml files are used by default.',
      valueHelp: 'path',
    )
    ..addFlag(
      kOptionNames[CliArgument.verbose]!,
      abbr: 'v',
      help: 'Display every logging message.',
      defaultsTo: kDefaultVerbose,
      negatable: false,
    )
    ..addFlag(
      kOptionNames[CliArgument.help]!,
      abbr: 'h',
      help: 'Shows this usage information.',
      negatable: false,
    );
}
