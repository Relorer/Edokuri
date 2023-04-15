extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    final tempThis = toUtc();
    final tempOther = other.toUtc();
    return tempThis.year == tempOther.year &&
        tempThis.month == tempOther.month &&
        tempThis.day == tempOther.day;
  }
}
