import 'package:flutter/material.dart';
import 'package:language_learning/constants.dart';

class ElementCard extends StatefulWidget {
  final Text content;
  final Text translation;
  final int index;
  final Function()? onEditTapped;
  final Function()? onDeleteTapped;
  final Function()? onDetailsTapped;

  const ElementCard({
    Key? key,
    required this.content,
    required this.translation,
    required this.index,
    required this.onEditTapped,
    required this.onDeleteTapped,
    required this.onDetailsTapped,
  }) : super(key: key);

  @override
  State<ElementCard> createState() => _ElementCardState();
}

class _ElementCardState extends State<ElementCard> {
  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 3, child: widget.content),
        Expanded(flex: 3, child: widget.translation),
        Expanded(
          flex: 1,
          child: PopupMenuButton(
            tooltip: '',
            itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              PopupMenuItem(
                child: Text(
                  'edytuj',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                value: PopupAction.edit,
                onTap: () {
                  WidgetsBinding.instance!.addPostFrameCallback((_) {
                    widget.onEditTapped!();
                  });
                },
              ),
              PopupMenuItem(
                child: const Text(
                  'usuń',
                ),
                value: PopupAction.delete,
                onTap: widget.onDeleteTapped,
              ),
              PopupMenuItem(
                  child: const Text(
                    'szczegóły',
                  ),
                  value: PopupAction.details,
                  onTap: () {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      widget.onDetailsTapped!();
                    });
                  })
            ],
          ),
        )
      ],
    );
  }
}
