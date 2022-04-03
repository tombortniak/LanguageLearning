import 'package:flutter/material.dart';
import 'package:language_learning/pages/question_page.dart';
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
  dynamic currentElement;
  List<dynamic> learnedElements = [];
  List<dynamic> otherElements = [];
  int errors = 0;

  @override
  void initState() {
    widget.learningContent.shuffle();
    currentElement = widget.learningContent.first;
    otherElements.addAll(widget.learningContent);
    super.initState();
  }

  Form buildForm() {
    int fieldsNumber = currentElement is Verb ? 7 : 1;
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
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
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
          if (currentElement is Verb)
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
  Widget build(BuildContext context) {
    final mainWidth = MediaQuery.of(context).size.width * .6;
    final width = MediaQuery.of(context).size.width * .4;
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Column(
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
            SizedBox(
              height: 30.0,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Center(
                        child: Text(
                          currentElement.content,
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      ),
                      buildForm()
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Sprawdź'),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
