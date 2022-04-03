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
    fieldsNumber = elementsToLearn.elementAt(0).element is Verb ? 7 : 1;
    setState(() {});
  }

  bool checkField(int index) {
    var learningElement = elementsToLearn.elementAt(0);
    switch (index) {
      case 0:
        return textControllers[0].text == learningElement.element.translation;
      case 1:
        return textControllers[1].text ==
            learningElement.element.firstPersonSingular;
      case 2:
        return textControllers[2].text ==
            learningElement.element.secondPersonSingular;
      case 3:
        return textControllers[3].text ==
            learningElement.element.thirdPersonSingular;
      case 4:
        return textControllers[4].text ==
            learningElement.element.firstPersonPlural;
      case 5:
        return textControllers[5].text ==
            learningElement.element.secondPersonPlural;
      case 6:
        return textControllers[6].text ==
            learningElement.element.thirdPersonPlural;
      default:
        return false;
    }
  }

  bool checkAnswer() {
    var learningElement = elementsToLearn.elementAt(0);
    bool answer = true;

    for (int i = 0; i < fieldsNumber; ++i) {
      if (checkField(i)) {
        fieldsColors[i] = Colors.greenAccent;
      } else {
        fieldsColors[i] = Colors.redAccent;
        answer = false;
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
              enabled: answerStatus == AnswerStatus.none,
              controller: textControllers[i],
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                ),
                disabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: fieldsColors[i]),
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
