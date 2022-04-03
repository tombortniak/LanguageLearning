import 'package:flutter/material.dart';
import 'package:language_learning/pages/learning_results_page.dart';
import 'package:language_learning/constants.dart';
import 'package:tuple/tuple.dart';
import 'package:language_learning/database/database.dart';

class LearningPage extends StatefulWidget {
  List<dynamic> learningContent;

  LearningPage({Key? key, required this.learningContent}) : super(key: key);

  @override
  State<LearningPage> createState() => _LearningPageState();
}

class _LearningPageState extends State<LearningPage> {
  final formKey = GlobalKey<FormState>();
  int currentElementIndex = 0;
  int fieldsNumber = 0;
  List<dynamic> learnedElements = [];
  List<dynamic> otherElements = [];
  List<TextEditingController> textControllers =
      List.generate(7, (index) => TextEditingController());
  List<Color> fieldsColors = List.generate(7, (index) => Colors.deepPurple);
  int errors = 0;
  String buttonText = 'Sprawdź';
  bool isCurrentCorrect = false;

  @override
  void initState() {
    widget.learningContent.shuffle();
    otherElements.addAll(widget.learningContent);
    super.initState();
  }

  void nextElement() {
    learnedElements.add(widget.learningContent[currentElementIndex]);
    otherElements.remove(widget.learningContent[currentElementIndex]);
    currentElementIndex++;
    for (var controller in textControllers) {
      controller.clear();
    }
    for (int i = 0; i < fieldsColors.length; ++i) {
      fieldsColors[i] = Colors.deepPurple;
    }
    isCurrentCorrect = false;
    setState(() {});
  }

  bool checkAnswer() {
    var element = widget.learningContent[currentElementIndex];
    if (textControllers[0].text !=
        widget.learningContent[currentElementIndex].translation) {
      fieldsColors[0] = Colors.redAccent;
      setState(() {});
      return false;
    }

    if (element is Verb) {
      if (textControllers[1].text != element.firstPersonSingular) {
        return false;
      }

      if (textControllers[2].text != element.secondPersonSingular) {
        return false;
      }

      if (textControllers[3].text != element.thirdPersonSingular) {
        return false;
      }

      if (textControllers[4].text != element.firstPersonPlural) {
        return false;
      }

      if (textControllers[5].text != element.secondPersonPlural) {
        return false;
      }

      if (textControllers[6].text != element.thirdPersonPlural) {
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
    fieldsNumber = currentElementIndex is Verb ? 7 : 1;
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
      key: formKey,
      child: Column(
        children: [
          boxes[0],
          if (currentElementIndex is Verb)
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'nauczone: ${learnedElements.length}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Text('pozostałe: ${otherElements.length}',
                    style: Theme.of(context).textTheme.bodyText1),
                Text('błędy: $errors',
                    style: Theme.of(context).textTheme.bodyText1)
              ],
            ),
            Column(
              children: [
                Center(
                  child: Text(
                    widget.learningContent[currentElementIndex].content,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
                buildForm(),
              ],
            ),
            isCurrentCorrect
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.greenAccent,
                    ),
                    onPressed: () {
                      nextElement();
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
                      setState(() {
                        if (checkAnswer()) {
                          if (currentElementIndex ==
                              widget.learningContent.length - 1) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const LearningResultsPage()));
                          } else {
                            isCurrentCorrect = true;
                          }
                        }
                      });
                    },
                    child: Text(buttonText),
                  )
          ],
        ),
      ),
    );
  }
}
