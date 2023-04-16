extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    final tempThis = toLocal();
    final tempOther = other.toLocal();
    return tempThis.year == tempOther.year &&
        tempThis.month == tempOther.month &&
        tempThis.day == tempOther.day;
  }
}
