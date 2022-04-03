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
  List<Color> fieldsColors = List.generate(7, (index) => Colors.grey);
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
      fieldsColors[i] = Colors.grey;
    }
    answerStatus = AnswerStatus.none;
    setState(() {});
  }

  bool checkAnswer() {
    var learningElement = elementsToLearn.elementAt(0);
    bool answer = true;
    if (textControllers[0].text != learningElement.element.translation) {
      fieldsColors[0] = Colors.redAccent;
      answer = false;
    }

    if (learningElement.element is Verb) {
      if (textControllers[1].text !=
          learningElement.element.firstPersonSingular) {
        fieldsColors[1] = Colors.redAccent;
        answer = false;
      }

      if (textControllers[2].text !=
          learningElement.element.secondPersonSingular) {
        fieldsColors[2] = Colors.redAccent;
        answer = false;
      }

      if (textControllers[3].text !=
          learningElement.element.thirdPersonSingular) {
        fieldsColors[3] = Colors.redAccent;
        answer = false;
      }

      if (textControllers[4].text !=
          learningElement.element.firstPersonPlural) {
        fieldsColors[4] = Colors.redAccent;
        answer = false;
      }

      if (textControllers[5].text !=
          learningElement.element.secondPersonPlural) {
        fieldsColors[5] = Colors.redAccent;
        answer = false;
      }

      if (textControllers[6].text !=
          learningElement.element.thirdPersonPlural) {
        fieldsColors[6] = Colors.redAccent;
        answer = false;
      }
    }

    if (answer) {
      for (int i = 0; i < fieldsColors.length; ++i) {
        fieldsColors[i] = Colors.greenAccent;
      }
    }

    buttonText = 'Dalej';
    setState(() {});

    return answer;
  }

  FocusTraversalGroup buildForm() {
    fieldsNumber = elementsToLearn.elementAt(0).element is Verb ? 7 : 1;
    int personConjugation = 1;
    double width;
    String hint;
    List<FocusTraversalOrder> fields = [];
    for (int i = 0; i < fieldsNumber; ++i) {
      if (i == 0) {
        width = MediaQuery.of(context).size.width * .7;
        hint = 'tłumaczenie';
      } else {
        width = MediaQuery.of(context).size.width * .4;
        hint = '$personConjugation. osoba';
      }

      fields.add(
        FocusTraversalOrder(
          order: NumericFocusOrder((i + 1).toDouble()),
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(
              Size(width, 60),
            ),
            child: TextFormField(
              showCursor: answerStatus == AnswerStatus.none ? true : false,
              controller: textControllers[i],
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: fieldsColors[i]),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                hintText: hint,
                hintStyle: Theme.of(context).textTheme.bodyText2,
              ),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      );
      if (i > 0) {
        personConjugation++;
        if (personConjugation == 4) {
          personConjugation = 1;
        }
      }
    }

    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Form(
        child: Column(
          children: [
            fields[0],
            if (elementsToLearn.elementAt(0).element is Verb)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      fields[1],
                      fields[2],
                      fields[3],
                    ],
                  ),
                  Column(
                    children: [
                      fields[4],
                      fields[5],
                      fields[6],
                    ],
                  )
                ],
              )
          ],
        ),
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
                      FocusScope.of(context).unfocus();
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
