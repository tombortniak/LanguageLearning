import 'dart:collection';

import 'package:flutter/material.dart' hide Stack;
import 'package:language_learning/models/learning_element.dart';
import 'package:language_learning/pages/learning_results_page.dart';
import 'package:language_learning/constants.dart';
import 'package:language_learning/database/database.dart';

class LearningPage extends StatefulWidget {
  List<dynamic> learningContent;

  LearningPage({Key? key, required this.learningContent}) : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  int fieldsNumber = 0;
  List<dynamic> learnedElements = [];
  Queue<LearningElement> elementsToLearn = Queue<LearningElement>();
  List<TextEditingController> textControllers =
      List.generate(7, (index) => TextEditingController());
  List<Color> fieldsColors = List.generate(7, (index) => Colors.deepPurple);
  String buttonText = 'Sprawdź';
  AnswerStatus answerStatus = AnswerStatus.none;

  @override
  void initState() {
    widget.learningContent.shuffle();
    elementsToLearn.addAll(List.generate(
        widget.learningContent.length,
        (index) => LearningElement(
            element: widget.learningContent[index], repetitions: 3)));
    super.initState();
  }

  void nextElement() {
    for (var controller in textControllers) {
      controller.clear();
    }
    for (int i = 0; i < fieldsColors.length; ++i) {
      fieldsColors[i] = Colors.deepPurple;
    }
    answerStatus = AnswerStatus.none;
    setState(() {});
  }

  bool checkAnswer() {
    var learningElement = elementsToLearn.elementAt(0);
    if (textControllers[0].text != learningElement.element.translation) {
      fieldsColors[0] = Colors.redAccent;
      setState(() {});
      return false;
    }

    if (learningElement is Verb) {
      if (textControllers[1].text !=
          learningElement.element.firstPersonSingular) {
        return false;
      }

      if (textControllers[2].text !=
          learningElement.element.secondPersonSingular) {
        return false;
      }

      if (textControllers[3].text !=
          learningElement.element.thirdPersonSingular) {
        return false;
      }

      if (textControllers[4].text !=
          learningElement.element.firstPersonPlural) {
        return false;
      }

      if (textControllers[5].text !=
          learningElement.element.secondPersonPlural) {
        return false;
      }

      if (textControllers[6].text !=
          learningElement.element.thirdPersonPlural) {
        return false;
      }
    }

    for (int i = 0; i < fieldsColors.length; ++i) {
      fieldsColors[i] = Colors.greenAccent;
    }
    buttonText = 'Dalej';
    return true;
  }

  Form buildForm() {
    fieldsNumber = elementsToLearn.elementAt(0) is Verb ? 7 : 1;
    int personConjugation = 1;
    double width;
    String hint;
    List<ConstrainedBox> boxes = [];
    for (int i = 0; i < fieldsNumber; ++i) {
      if (i == 0) {
        width = MediaQuery.of(context).size.width * .7;
        hint = 'tłumaczenie';
      } else {
        width = MediaQuery.of(context).size.width * .4;
        hint = '$personConjugation. osoba';
      }

      boxes.add(
        ConstrainedBox(
          constraints: BoxConstraints.tight(
            Size(width, 60),
          ),
          child: TextFormField(
            showCursor: answerStatus == AnswerStatus.none ? true : false,
            controller: textControllers[i],
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: fieldsColors[i]),
              ),
              hintText: hint,
              hintStyle: Theme.of(context).textTheme.bodyText2,
            ),
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      );
      personConjugation++;
      if (personConjugation == 4) {
        personConjugation = 1;
      }
    }

    return Form(
      child: Column(
        children: [
          boxes[0],
          if (elementsToLearn.elementAt(0) is Verb)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    boxes[1],
                    boxes[2],
                    boxes[3],
                  ],
                ),
                Column(
                  children: [
                    boxes[4],
                    boxes[5],
                    boxes[6],
                  ],
                )
              ],
            )
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in textControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'nauczone: ${learnedElements.length}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text(
                    'liczba powtórzeń: ${elementsToLearn.elementAt(0).repetitions}',
                    style: Theme.of(context).textTheme.bodyText1),
              ],
            ),
            Column(
              children: [
                Center(
                  child: Text(
                    elementsToLearn.elementAt(0).element.content,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                buildForm(),
              ],
            ),
            answerStatus != AnswerStatus.none
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: answerStatus == AnswerStatus.correct
                          ? Colors.greenAccent
                          : Colors.redAccent,
                    ),
                    onPressed: () {
                      var learningElement = elementsToLearn.removeFirst();
                      if (answerStatus == AnswerStatus.correct) {
                        learningElement.decreaseRepetitions(1);
                      } else {
                        learningElement.increaseRepetitions(1);
                      }
                      if (learningElement.repetitions > 0) {
                        elementsToLearn.add(learningElement);
                      } else {
                        learnedElements.add(learningElement.element);
                      }

                      if (elementsToLearn.isEmpty) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const LearningResultsPage()));
                      } else {
                        nextElement();
                      }
                    },
                    child: Text(
                      buttonText,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black),
                    ),
                  )
                : ElevatedButton(
                    onPressed: () {
                      if (checkAnswer()) {
                        answerStatus = AnswerStatus.correct;
                      } else {
                        answerStatus = AnswerStatus.incorrect;
                      }
                      setState(() {});
                    },
                    child: Text(buttonText),
                  )
          ],
        ),
      ),
    );
  }
}
