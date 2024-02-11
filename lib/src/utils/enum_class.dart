import 'package:collection/collection.dart';

/// `EnumClass` is a class that provides a way to work with enums in a more
/// flexible way.
///
/// It provides a way to get the key for a value and vice versa.
///
/// It also provides a way to get the keys, values and entries of the enum.
///
/// Example:
///
/// ```dart
/// enum Fruit {
///  apple,
///  banana,
/// }
///
/// final fruitEnum = EnumClass({
///  Fruit.apple: 'apple',
///   Fruit.banana: 'banana',
/// });
///
/// final key = fruitEnum.getKeyForValue('apple');
/// final value = fruitEnum.getValueForKey(Fruit.apple);
///
/// print(key); // Fruit.apple
/// print(value); // apple
/// ```
class EnumClass<K, V> {
  const EnumClass(this._map);

  final Map<K, V> _map;

  K? getKeyForValue(V value) {
    final entry =
        _map.entries.firstWhereOrNull((entry) => entry.value == value);

    return entry?.key;
  }

  V? getValueForKey(K key) {
    return _map[key];
  }

  Iterable<K> get keys => _map.keys;

  Iterable<V> get values => _map.values;

  Iterable<MapEntry<K, V>> get entries => _map.entries;

  Map<K, V> get map => _map;

  V? operator [](K key) => _map[key];
}
