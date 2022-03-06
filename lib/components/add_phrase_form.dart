import 'package:drift/drift.dart' as drift;
import 'package:flutter/material.dart';
import 'package:language_learning/database/database.dart';
import 'package:provider/provider.dart';

class AddPhraseForm extends StatefulWidget {
  final Function _onPressedSubmitButton;
  const AddPhraseForm({Key? key, onPressedSubmitButton})
      : _onPressedSubmitButton = onPressedSubmitButton,
        super(key: key);

  @override
  State<AddPhraseForm> createState() => _AddPhraseFormState();
}

class _AddPhraseFormState extends State<AddPhraseForm> {
  final _formKey = GlobalKey<FormState>();
  final _newPhraseController = TextEditingController();
  final _newTranslationController = TextEditingController();
  final _specialCharacters = ['á', 'é', 'í', 'ñ', 'ó', 'ú', 'ü', '¿', '¡'];
  FocusNode textFieldFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          Text(
            'Nowa fraza',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _newPhraseController,
            focusNode: textFieldFocusNode,
            decoration: const InputDecoration(
              hintText: 'Podaj frazę',
              hintStyle: TextStyle(fontSize: 13.0),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Fraza nie może być pusta';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 20.0,
          ),
          TextFormField(
            textInputAction: TextInputAction.next,
            controller: _newTranslationController,
            decoration: const InputDecoration(
              hintText: 'Podaj tłumaczenie',
              hintStyle: TextStyle(
                fontSize: 13.0,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Tłumaczenie nie może być puste';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 30.0,
          ),
          Wrap(
            children: [
              for (var character in _specialCharacters)
                InkWell(
                  child: Container(
                    child: Center(
                      child: Text(character),
                    ),
                    width: 30.0,
                    height: 30.0,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                  ),
                  onTap: () {
                    textFieldFocusNode.requestFocus();
                    _newPhraseController.text += _specialCharacters[1];
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
                  Provider.of<MyDatabase>(context, listen: false).add(
                      PhrasesCompanion(
                          language: drift.Value('spanish'),
                          content: drift.Value(_newPhraseController.text),
                          polish_translation:
                              drift.Value(_newTranslationController.text)));
                  widget._onPressedSubmitButton();
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
            },
            child: const Text('Dodaj'),
          )
        ],
      ),
    );
  }
}
