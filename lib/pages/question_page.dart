import 'package:flutter/material.dart';
import 'package:language_learning/constants.dart';
import 'package:language_learning/models/language_element_data.dart';

class QuestionPage extends StatelessWidget {
  final element;
  final LanguageElement languageElement;

  const QuestionPage(
      {Key? key, required this.element, required this.languageElement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Pytanie'),
    );
  }
}
