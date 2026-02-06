import 'package:dart_practice_projects/unit_converter_functions.dart';
import 'package:args/args.dart';

void main (List<String> arguments) {
    final parser = ArgParser()
    ..addOption('celsius', abbr: 'c', mandatory: true);
    final results = parser.parse(arguments);
    String celsius_parsed = results['celsius'];
    final celsius_double = double.parse(celsius_parsed);

    print(convertCelsiusToFahrenheit(celsius_double));
}