
extension NonNullString on String? {
  String orEmpty() {
    return this ?? "";
  }
}

extension NonNullInterger on int? {
  int orZero() {
    return this ?? 0;
  }
}

extension NonNullDouble on double? {
  double orZero() {
    return this ?? 0.0;
  }
}

extension NonNullBolean on bool? {
  bool orFalse() {
    return this ?? false;
  }
}
