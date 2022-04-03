import 'package:flutter/material.dart';
import 'package:language_learning/constants.dart';

class LabeledRadio extends StatefulWidget {
  LearningOption groupValue;
  String label;
  Function(LearningOption?)? onChanged;
  LearningOption value;
  LabeledRadio(
      {Key? key,
      required this.value,
      required this.groupValue,
      required this.label,
      required this.onChanged})
      : super(key: key);

  @override
  State<LabeledRadio> createState() => _LabeledRadioState();
}

class _LabeledRadioState extends State<LabeledRadio> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio<LearningOption>(
          value: widget.value,
          groupValue: widget.groupValue,
          onChanged: widget.onChanged,
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          widget.label,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
