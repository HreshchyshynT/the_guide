import "dart:math";

extension DoubleExtension on double {
  double get sqr => this * this;

  bool isInRange(double a, double b) => a <= this && this <= b;
}

extension NumberExtension on num {
  num get sqr => this * this;

  bool isInRange(num a, num b) => a <= this && this <= b;

  num coerceIn(num minValue, num maxValue) =>
      max(minValue, min(this, maxValue));

  double radians() {
    return this * pi / 180;
  }

  double turns() => radians() / (2 * pi);
}

extension DurationExtension on int {
  Duration get ms => Duration(milliseconds: this);

  Duration get sec => Duration(seconds: this);

  Duration get min => Duration(minutes: this);

  Duration get h => Duration(hours: this);
}
