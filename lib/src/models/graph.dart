class GraphData {
  final List<GraphDayData> days;

  GraphData(this.days);
}

class GraphDayData {
  final int newSavedRecords;
  final int newKnownRecords;
  final int reviewedWords;
  final DateTime date;

  int get total => newSavedRecords + newKnownRecords + reviewedWords;

  GraphDayData(this.date,
      {this.newSavedRecords = 0,
      this.newKnownRecords = 0,
      this.reviewedWords = 0});
}
