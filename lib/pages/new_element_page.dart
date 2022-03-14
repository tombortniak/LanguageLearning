import 'package:flutter/material.dart';

import 'package:language_learning/components/new_element_form.dart';
import 'package:language_learning/components/new_verb_form.dart';
import 'package:language_learning/constants.dart';

class NewElementPage extends StatefulWidget {
  final Language language;
  final List<String> specialCharacters;
  final LanguageElement languageElement;
  final onSubmittedForm;

  const NewElementPage(
      {Key? key,
      required this.languageElement,
      required this.language,
      required this.onSubmittedForm,
      required this.specialCharacters})
      : super(key: key);

  @override
  State<NewElementPage> createState() => _NewElementPageState();
}

class _NewElementPageState extends State<NewElementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('${kLanguageElementTranslations[widget.languageElement]}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
        elevation: 0,
      ),
      body: Row(
        children: [
          const Expanded(
            child: SizedBox.shrink(),
          ),
          widget.languageElement == LanguageElement.verb
              ? Expanded(
                  flex: 6,
                  child: NewVerbForm(
                    language: widget.language,
                    specialCharacters: kSpanishSpecialCharacters,
                    onSubmittedForm: widget.onSubmittedForm,
                  ),
                )
              : Expanded(
                  flex: 6,
                  child: NewElementForm(
                    language: widget.language,
                    languageElement: widget.languageElement,
                    specialCharacters: widget.specialCharacters,
                    onSubmittedForm: widget.onSubmittedForm,
                  ),
                ),
          const Expanded(
            child: SizedBox.shrink(),
          ),
        ],
      ),
    );
  }
}
