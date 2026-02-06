import 'package:test/test.dart';
import 'package:dart_practice_projects/unit_converter_functions.dart';

void main() {
        final List<List<double>> cases = [
            [0,32],[100, 212],[-100,-148],[37.778,100]
        ];
        for (var case_ in cases) {
        test('Convert ${case_[0]} Celsius to ${case_[1]} Fahrenheit', () {
        final celsius = case_[0] as double;
        final expectedFahrenheit = case_[1] as double;
        expect(convertCelsiusToFahrenheit(celsius), closeTo(expectedFahrenheit, 0.001)); // 0.001 tolerance
        }
    );
    };

}