import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:language_learning/constants.dart';
import 'package:drift/drift.dart' as drift;
import 'package:language_learning/database/database.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';

class NewVerbForm extends StatefulWidget {
  final Language language;
  final List<String> specialCharacters;
  final onSubmittedForm;

  const NewVerbForm(
      {Key? key,
      required this.language,
      this.onSubmittedForm,
      this.specialCharacters = const []})
      : super(key: key);

  @override
  State<NewVerbForm> createState() => _NewVerbFormState();
}

class _NewVerbFormState extends State<NewVerbForm> {
  final _formKey = GlobalKey<FormState>();
  final List<TextEditingController> _textControllers =
      List.generate(8, (index) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(8, (index) => FocusNode());
  List<Widget> _textFormFields = [];
  bool showSpecialCharacters = false;
  int _lastFocusedFieldIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < _focusNodes.length; i++) {
      _focusNodes[i].addListener(() {
        setState(() {
          _lastFocusedFieldIndex = i;
        });
      });
    }
    _focusNodes.first.requestFocus();
  }

  @override
  void dispose() {
    super.dispose();
    for (var controller in _textControllers) {
      controller.dispose();
    }

    for (var node in _focusNodes) {
      node.dispose();
    }
  }

  void _onSubmitButtonPressed() {
    _onFieldSubmitted('');
  }

  void _onFieldSubmitted(String value) async {
    var verbs = await Provider.of<LanguageDatabase>(context, listen: false)
        .getVerbs(widget.language);
    if (_textControllers.any((element) => element.text.isEmpty)) {
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
      if (verbs.any((element) => element.content == _textControllers[0].text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'Czasownik już istnieje',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if (_formKey.currentState!.validate()) {
          var verb = VerbsCompanion(
            language: drift.Value(widget.language.name),
            content: drift.Value(_textControllers[0].text),
            translation: drift.Value(_textControllers[1].text),
            firstPersonSingular: drift.Value(_textControllers[2].text),
            secondPersonSingular: drift.Value(_textControllers[3].text),
            thirdPersonSingular: drift.Value(_textControllers[4].text),
            firstPersonPlural: drift.Value(_textControllers[5].text),
            secondPersonPlural: drift.Value(_textControllers[6].text),
            thirdPersonPlural: drift.Value(_textControllers[7].text),
          );
          await context
              .read<LanguageElementData>()
              .addElement(verb, LanguageElement.verb);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Czasownik został dodany',
                textAlign: TextAlign.center,
              ),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
        for (var controller in _textControllers) {
          controller.clear();
        }
        _focusNodes[0].requestFocus();
      }
      widget.onSubmittedForm();
    }
  }

  List<Widget> _buildFormFields() {
    List<Widget> widgets = [];
    int personConjugation = 1;
    String hintText;
    String validatorText = 'Pole nie może być puste';
    for (int i = 0; i < 8; i++) {
      if (i == 0) {
        hintText = 'czasownik';
        validatorText = 'Pole nie może być puste';
      } else if (i == 1) {
        hintText = 'tłumaczenie';
        validatorText = 'Tłumaczenie nie może być puste';
      } else {
        hintText = '$personConjugation. osoba';
        personConjugation++;
        if (personConjugation == 4) {
          personConjugation = 1;
        }
      }
      widgets.add(
        FocusTraversalOrder(
          order: NumericFocusOrder((i + 1).toDouble()),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            controller: _textControllers[i],
            focusNode: _focusNodes[i],
            decoration: InputDecoration(
              focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple),
              ),
              hintText: hintText,
              hintStyle: Theme.of(context).textTheme.bodyText2,
            ),
            style: Theme.of(context).textTheme.bodyText1,
            onFieldSubmitted: _onFieldSubmitted,
          ),
        ),
      );
    }
    return widgets;
  }

  @override
  Widget build(BuildContext context) {
    _textFormFields = _buildFormFields();
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: Form(
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
                          _focusNodes[_lastFocusedFieldIndex].requestFocus();
                          _textControllers[_lastFocusedFieldIndex].text +=
                              widget.specialCharacters[i];
                          _textControllers[_lastFocusedFieldIndex].selection =
                              TextSelection.fromPosition(
                            TextPosition(
                                offset: _textControllers[_lastFocusedFieldIndex]
                                    .text
                                    .length),
                          );
                        },
                      ),
                  ],
                ),
              ),
            Row(
              children: [
                Expanded(
                  child: _textFormFields[0],
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: _textFormFields[1],
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('l. pojedyncza',
                          style: Theme.of(context).textTheme.headline5),
                      _textFormFields[2],
                      _textFormFields[3],
                      _textFormFields[4],
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20.0,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('l. mnoga',
                          style: Theme.of(context).textTheme.headline5),
                      _textFormFields[5],
                      _textFormFields[6],
                      _textFormFields[7],
                    ],
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
                        _focusNodes[_lastFocusedFieldIndex].requestFocus();
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
      ),
    );
  }
}
