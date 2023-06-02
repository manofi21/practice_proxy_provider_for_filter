T? convertType<T>(dynamic value) {
  final _value = value;
  if (_value is T) {
    return _value!;
  }
  return null;
}