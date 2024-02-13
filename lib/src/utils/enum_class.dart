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
  /// Constructor
  const EnumClass(this._map);

  /// The map that holds the enum values and their corresponding keys.
  /// This map is used to get the key for a value and vice versa.
  final Map<K, V> _map;

  /// Returns the key for a value.
  /// This method allows you to use the `getKeyForValue` method to get the key for a value.
  K? getKeyForValue(V value) {
    final entry =
        _map.entries.firstWhereOrNull((entry) => entry.value == value);

    return entry?.key;
  }

  /// Returns the value for a key.
  /// This method allows you to use the `getValueForKey` method to get the value for a key.
  V? getValueForKey(K key) {
    return _map[key];
  }

  /// Returns the keys of the enum.
  /// This method allows you to use the `keys` property to get the keys of the enum.
  Iterable<K> get keys => _map.keys;

  /// Returns the values of the enum.
  /// This method allows you to use the `values` property to get the values of the enum.
  Iterable<V> get values => _map.values;

  /// Returns the entries of the enum.
  Iterable<MapEntry<K, V>> get entries => _map.entries;

  /// Returns the map of the enum.
  /// This method allows you to use the `map` property to get the map of the enum.
  Map<K, V> get map => _map;

  /// Returns the value for a key.
  /// This method allows you to use the `[]` operator to get the value for a key.
  V? operator [](K key) => _map[key];
}
