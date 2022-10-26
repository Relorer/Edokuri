import 'package:flutter/cupertino.dart';

class WordOfText extends StatelessWidget {
  const WordOfText({Key? key, required this.word}) : super(key: key);

  final String word;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        color: const Color.fromARGB(255, 193, 187, 255),
      ),
      child: Text(word),
    );
  }
}
