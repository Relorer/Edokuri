class GraphData {
  final List<GraphDayData> days;

  GraphData(this.days);
}

class GraphDayData {
  final int newSavedWords;
  final int newKnownWords;
  final int reviewedWords;
  final DateTime date;

  GraphDayData(
      this.newSavedWords, this.newKnownWords, this.reviewedWords, this.date);
}
