import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:language_learning/database/database.dart';
import 'package:provider/provider.dart';
import 'package:language_learning/constants.dart';

class AddPhraseForm extends StatefulWidget {
  Function(PhrasesCompanion) onPressedSubmitButton;
  final Language language;
  final List<String> specialCharacters;
  AddPhraseForm(
      {required this.onPressedSubmitButton,
      required this.language,
      this.specialCharacters = const []});

  @override
  State<AddPhraseForm> createState() => _AddPhraseFormState();
}

class _AddPhraseFormState extends State<AddPhraseForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPhraseController = TextEditingController();
  final _newTranslationController = TextEditingController();
  FocusNode textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.disabled,
      child: Column(
        children: [
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _newPhraseController,
            focusNode: textFieldFocusNode,
            decoration: InputDecoration(
              hintText: 'Podaj frazę',
              hintStyle: Theme.of(context).textTheme.bodyText2,
            ),
            style: Theme.of(context).textTheme.bodyText1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Fraza nie może być pusta';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            textInputAction: TextInputAction.go,
            controller: _newTranslationController,
            onFieldSubmitted: (value) async {
              var phrases =
                  await Provider.of<MyDatabase>(context, listen: false)
                      .allPhrases;
              if (phrases.any(
                  (element) => element.content == _newPhraseController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fraza już istnieje'),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                if (_formKey.currentState!.validate()) {
                  var phrase = PhrasesCompanion(
                      language: drift.Value(widget.language.name),
                      content: drift.Value(_newPhraseController.text),
                      polish_translation:
                          drift.Value(_newTranslationController.text));
                  widget.onPressedSubmitButton(phrase);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fraza została dodana'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                if (_newTranslationController.text.isNotEmpty) {
                  _newPhraseController.clear();
                }
                _newTranslationController.clear();
              }
              textFieldFocusNode.requestFocus();
            },
            decoration: InputDecoration(
              hintText: 'Podaj tłumaczenie',
              hintStyle: Theme.of(context).textTheme.bodyText2,
            ),
            style: Theme.of(context).textTheme.bodyText1,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Tłumaczenie nie może być puste';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          Wrap(
            children: [
              for (int i = 0; i < widget.specialCharacters.length; ++i)
                InkWell(
                  child: Container(
                    child: Center(
                      child: Text(
                        widget.specialCharacters[i],
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  onTap: () {
                    textFieldFocusNode.requestFocus();
                    _newPhraseController.text += widget.specialCharacters[i];
                  },
                ),
            ],
          ),
          const SizedBox(
            height: 30.0,
          ),
          ElevatedButton(
            onPressed: () async {
              var phrases =
                  await Provider.of<MyDatabase>(context, listen: false)
                      .allPhrases;
              if (phrases.any(
                  (element) => element.content == _newPhraseController.text)) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Fraza już istnieje'),
                    backgroundColor: Colors.redAccent,
                    duration: Duration(seconds: 2),
                  ),
                );
              } else {
                if (_formKey.currentState!.validate()) {
                  var phrase = PhrasesCompanion(
                      language: drift.Value(widget.language.name),
                      content: drift.Value(_newPhraseController.text),
                      polish_translation:
                          drift.Value(_newTranslationController.text));
                  widget.onPressedSubmitButton(phrase);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fraza została dodana'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
                if (_newTranslationController.text.isNotEmpty) {
                  _newPhraseController.clear();
                }
                _newTranslationController.clear();
              }
              textFieldFocusNode.requestFocus();
            },
            child: const Text('Dodaj'),
          ),
        ],
      ),
    );
  }
}
