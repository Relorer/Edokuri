class WordIndex {
  final int paragraph;
  final int piece;

  WordIndex(this.paragraph, this.piece);
}

class PageIndex {
  final int paragraph;
  final WordIndex start;
  final WordIndex end;

  PageIndex(this.paragraph, this.start, this.end);
}
