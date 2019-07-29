import 'dart:math' as math;
import 'common.dart';

class Aggregate {
  String key;
  Aggregate(this.key);

  Function _getValues () {
    List<String> steps = key.toString().split('__').toList();
    Function propertyName = deepPropertyName(steps);

    return propertyName;
  }

  double avg(List<Map> arr) {
    return sum(arr) / arr.length;
  }

  double min(List<Map> arr) {
    List<double> values = arr.map(this._getValues());
    return values.reduce(math.min);
  }

  double max(List<Map> arr) {
    List<double> values = arr.map(this._getValues());
    return values.reduce(math.max);
  }

  double sum(List<Map> arr) {
    List<double> values = arr.map(this._getValues());
    return values.fold(0, (a, b) => a + b);
  }

  int count(List<Map> arr) {
    return arr.map(this._getValues()).length;
  }
}
