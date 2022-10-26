class WordIndex {
  final int paragraph;
  final int piece;

  WordIndex(this.paragraph, this.piece);
}

class PageIndex {
  final WordIndex start;
  final WordIndex end;

  PageIndex(this.start, this.end);
}
