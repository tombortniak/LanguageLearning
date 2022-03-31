import 'package:flutter/material.dart';
import 'package:language_learning/pages/question_page.dart';
import 'package:language_learning/constants.dart';
import 'package:tuple/tuple.dart';
import 'package:language_learning/database/database.dart';

class LearningPage extends StatefulWidget {
  final Tuple3<List<Word>, List<Verb>, List<Phrase>> learningContent;

  const LearningPage({Key? key, required this.learningContent})
      : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Text(widget.learningContent.toString()),
    );
  }
}
