import 'package:drift/drift.dart' as d;
import 'package:flutter/material.dart';
import 'package:language_learning/database/database.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';
import 'package:language_learning/constants.dart';

class NewElementForm extends StatefulWidget {
  final LanguageElement languageElement;
  final Language language;
  final List<String> specialCharacters;
  NewElementForm(
      {required this.languageElement,
      required this.language,
      this.specialCharacters = const []});

  @override
  State<NewElementForm> createState() => _NewElementFormState();
}

class _NewElementFormState extends State<NewElementForm> {
  final _formKey = GlobalKey<FormState>();
  final elementController = TextEditingController();
  final translationController = TextEditingController();
  final elementFocusNode = FocusNode();
  final translationFocusNode = FocusNode();
  bool showSpecialCharacters = false;

  String capitalizeFirstLetter(String element) {
    return '${element[0].toUpperCase()}${element.substring(1)}';
  }

  void _onSubmitButtonPressed() {
    _onFieldSubmitted('');
  }

  void _onFieldSubmitted(String value) async {
    String successMessage;
    if (widget.languageElement == LanguageElement.word) {
      successMessage = 'zostało dodane';
    } else {
      successMessage = 'została dodana';
    }

    if (elementController.text.isEmpty || translationController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Wszystkie pola muszą być wypełnione',
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      if (context
          .read<LanguageElementData>()
          .contains(elementController.text, widget.languageElement)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${capitalizeFirstLetter(kLanguageElementTranslations[widget.languageElement]!)} już istnieje',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.redAccent,
            duration: const Duration(seconds: 2),
          ),
        );
      } else {
        if (_formKey.currentState!.validate()) {
          if (widget.languageElement == LanguageElement.word) {
            var word = WordsCompanion(
                language: d.Value(widget.language.name),
                content: d.Value(elementController.text),
                translation: d.Value(translationController.text));
            await context
                .read<LanguageElementData>()
                .addElement(word, LanguageElement.word);
          } else {
            var phrase = PhrasesCompanion(
                language: d.Value(widget.language.name),
                content: d.Value(elementController.text),
                translation: d.Value(translationController.text));
            await context
                .read<LanguageElementData>()
                .addElement(phrase, LanguageElement.phrase);
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${capitalizeFirstLetter(kLanguageElementTranslations[widget.languageElement]!)} $successMessage',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.green,
              duration: const Duration(seconds: 2),
            ),
          );
        }
        elementController.clear();
        translationController.clear();
        elementFocusNode.requestFocus();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    elementFocusNode.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    elementController.dispose();
    translationController.dispose();
    elementFocusNode.dispose();
    translationFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (showSpecialCharacters)
            AnimatedContainer(
              duration: const Duration(milliseconds: 500),
              child: Wrap(
                alignment: WrapAlignment.center,
                children: [
                  for (int i = 0; i < widget.specialCharacters.length; ++i)
                    InkWell(
                      child: Container(
                        child: Center(
                          child: Text(
                            widget.specialCharacters[i],
                            style: Theme.of(context).textTheme.headline4,
                          ),
                        ),
                        width: 30.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                      ),
                      onTap: () {
                        elementFocusNode.requestFocus();
                        elementController.text += widget.specialCharacters[i];
                        elementController.selection =
                            TextSelection.fromPosition(
                          TextPosition(offset: elementController.text.length),
                        );
                      },
                    ),
                ],
              ),
            ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: elementController,
                  focusNode: elementFocusNode,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    hintText:
                        kLanguageElementTranslations[widget.languageElement],
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
              ),
              const SizedBox(
                width: 20.0,
              ),
              Expanded(
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: translationController,
                  decoration: InputDecoration(
                    hintText: 'tłumaczenie',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                  ),
                  style: Theme.of(context).textTheme.bodyText1,
                  onFieldSubmitted: _onFieldSubmitted,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Tooltip(
                message: showSpecialCharacters
                    ? 'Ukryj znaki specjalne'
                    : 'Pokaż znaki specjalne',
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      elementFocusNode.requestFocus();
                      showSpecialCharacters = !showSpecialCharacters;
                    });
                  },
                  child: const Icon(
                    Icons.keyboard,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(
                width: 15.0,
              ),
              Tooltip(
                message: 'Zatwierdź',
                child: FloatingActionButton(
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                  ),
                  onPressed: _onSubmitButtonPressed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
