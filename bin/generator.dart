import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:dart_style/dart_style.dart';
import 'package:icomoon_generator/src/cli/arguments.dart';
import 'package:icomoon_generator/src/cli/options.dart';
import 'package:icomoon_generator/src/common/api.dart';
import 'package:icomoon_generator/src/common/selection.dart';
import 'package:icomoon_generator/src/utils/logger.dart';
import 'package:yaml/yaml.dart';

final _argParser = ArgParser(allowTrailingOptions: true);
final formatter = DartFormatter(
  pageWidth: 80,
  fixes: StyleFix.all,
);

void main(List<String> args) {
  defineOptions(_argParser);

  late final CliArguments parsedArgs;

  try {
    parsedArgs = parseArgsAndConfig(_argParser, args);
  } on CliArgumentException catch (e) {
    _usageError(e.message);
  } on CliHelpException {
    _printHelp();
  } on YamlException catch (e) {
    logger.e(e.toString());
    exit(66);
  }

  try {
    _run(parsedArgs);
  } on Object catch (e) {
    logger.e(e.toString());
    exit(65);
  }
}

void _run(CliArguments parsedArgs) {
  final stopwatch = Stopwatch()..start();

  final isVerbose = parsedArgs.verbose ?? kDefaultVerbose;

  if (isVerbose) {
    logger.setFilterLevel(Level.trace);
  }

  if (!parsedArgs.classFile.existsSync()) {
    parsedArgs.classFile.createSync(recursive: true);
  } else {
    logger.t(
        'Output file for a Flutter class already exists (${parsedArgs.classFile.path}) - '
        'overwriting it');
  }

  if (!parsedArgs.jsonFile.existsSync()) {
    logger.e('Font file does not exist (${parsedArgs.jsonFile.path})');
    exit(66);
  } else {
    logger.t('Font file: ${parsedArgs.jsonFile.path} found');
  }

  try {
    File iconsJson = parsedArgs.jsonFile;
    final String rawJson = iconsJson.readAsStringSync();
    final selection = Selection.fromJson(
      jsonDecode(rawJson) as Map<String, dynamic>,
    );

    var classString = generateFlutterClass(
      iconsList: selection.icons,
      className: parsedArgs.className,
      package: parsedArgs.fontPackage,
    );

    if (parsedArgs.format ?? kDefaultFormat) {
      logger.t('Formatting Flutter class generation.');
      classString = formatter.format(classString);
    }

    parsedArgs.classFile.writeAsStringSync(classString);
  } on Object catch (e) {
    logger.e(e.toString());
  }

  logger.i('Generated in ${stopwatch.elapsedMilliseconds}ms');
}

void _printHelp() {
  _printUsage();
  exit(exitCode);
}

void _usageError(String error) {
  _printUsage(error);
  exit(64);
}

void _printUsage([String? error]) {
  final message = error ?? _kAbout;

  stdout.write('''
$message

$_kUsage
${_argParser.usage}
''');
  exit(64);
}

const _kAbout = 'A Dart package that generates Flutter-compatible class.';

const _kUsage = '''
Usage:   icomoon_generator <input-json-file> <output-class-file> [options]

Example: icomoon_generator fonts/selection.json lib/my_icons.dart
''';
