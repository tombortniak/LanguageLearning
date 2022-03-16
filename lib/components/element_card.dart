import 'package:flutter/material.dart';
import 'package:language_learning/constants.dart';

class ElementCard extends StatefulWidget {
  final Text content;
  final Text translation;
  final Function()? onEditTapped;
  final Function()? onDeleteTapped;
  final bool showOptions;
  ElementCard(
      {Key? key,
      required this.content,
      required this.translation,
      this.onEditTapped,
      this.onDeleteTapped,
      required this.showOptions})
      : super(key: key);

  @override
  State<ElementCard> createState() => _ElementCardState();
}

class _ElementCardState extends State<ElementCard> {
  bool showOptions = false;
  bool isEdited = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(child: widget.content),
          Expanded(child: widget.translation),
          widget.showOptions
              ? Expanded(
                  child: PopupMenuButton(
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                      PopupMenuItem(
                        child: Text('edytuj'),
                        value: PopupAction.edit,
                        onTap: () {
                          setState(() {
                            isEdited = !isEdited;
                          });
                        },
                      ),
                      PopupMenuItem(
                        child: Text('usuń'),
                        value: PopupAction.delete,
                        onTap: widget.onDeleteTapped,
                      ),
                    ],
                  ),
                )
              : Expanded(
                  child: SizedBox(),
                )
        ],
      ),
    );
  }
}
