import 'package:flutter/material.dart';

class LabeledCheckbox extends StatefulWidget {
  String label;
  bool isDisabled;
  bool isChecked;
  Function onChanged;
  LabeledCheckbox(
      {Key? key,
      required this.onChanged,
      required this.isChecked,
      required this.label,
      this.isDisabled = false})
      : super(key: key);

  @override
  State<LabeledCheckbox> createState() => _LabeledCheckboxState();
}

class _LabeledCheckboxState extends State<LabeledCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: widget.isChecked,
          onChanged: widget.isDisabled
              ? null
              : (bool? value) {
                  widget.onChanged();
                },
        ),
        const SizedBox(
          width: 5.0,
        ),
        Text(
          widget.label,
          style: widget.isDisabled
              ? Theme.of(context).textTheme.bodyText2
              : Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}
