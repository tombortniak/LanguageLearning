import 'package:flutter/material.dart';

class LearningResultsPage extends StatelessWidget {
  final int learnedElements;
  final int notLearnedElements;

  const LearningResultsPage(
      {Key? key,
      required this.learnedElements,
      required this.notLearnedElements})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Podsumowanie',
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          Column(
            children: [
              Text(
                'nauczone: $learnedElements',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
              Text(
                'nienauczone: $notLearnedElements',
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          SizedBox.shrink()
        ],
      ),
    );
  }
}
