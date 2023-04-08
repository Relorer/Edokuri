abstract class Translator {
  bool get needInternet;
  String get source;
  Future<List<String>> translate(String text, String from, String to);
}
