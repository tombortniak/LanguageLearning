import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:language_learning/constants.dart';
import 'package:drift/drift.dart' as drift;
import 'package:language_learning/database/database.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';

class NewElementForm extends StatefulWidget {
  final Language language;
  final LanguageElement languageElement;
  final List<String> specialCharacters;

  const NewElementForm(
      {Key? key,
      required this.language,
      required this.languageElement,
      this.specialCharacters = const []})
      : super(key: key);

  @override
  State<NewElementForm> createState() => _NewElementFormState();
}

class _NewElementFormState extends State<NewElementForm> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _textControllers =
      List.generate(8, (index) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(8, (index) => FocusNode());
  List<Widget> _textFormFields = [];
  bool showSpecialCharacters = false;
  int _lastFocusedFieldIndex = 0;
  int? textForms;
  String? title;

  @override
  void initState() {
    super.initState();
    if (widget.languageElement == LanguageElement.verb) {
      textForms = 8;
      title = 'Nowy czasownik';
    } else {
      textForms = 2;
      if (widget.languageElement == LanguageElement.word) {
        title = 'Nowe słowo';
      } else {
        title = 'Nowa fraza';
      }
    }

    _focusNodes = List.generate(textForms!, (index) => FocusNode());
    _textControllers =
        List.generate(textForms!, (index) => TextEditingController());

    for (int i = 0; i < textForms!; i++) {
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

  void _onFieldSubmitted(String value) async {
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
      if (context
          .read<LanguageElementData>()
          .contains(_textControllers[0].text, widget.languageElement)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              '${_textControllers[0].text} już istnieje',
              textAlign: TextAlign.center,
            ),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        if (_formKey.currentState!.validate()) {
          var element;
          if (widget.languageElement == LanguageElement.word) {
            element = WordsCompanion(
                language: drift.Value(widget.language.name),
                content: drift.Value(_textControllers[0].text),
                translation: drift.Value(_textControllers[1].text));
          } else if (widget.languageElement == LanguageElement.phrase) {
            element = PhrasesCompanion(
                language: drift.Value(widget.language.name),
                content: drift.Value(_textControllers[0].text),
                translation: drift.Value(_textControllers[1].text));
          } else {
            element = VerbsCompanion(
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
          }
          await context
              .read<LanguageElementData>()
              .addElement(element, widget.languageElement);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(
                '${_textControllers[0].text} zostało dodane',
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
    }
  }

  List<Widget> _buildFormFields() {
    List<Widget> widgets = [];
    int personConjugation = 1;
    String hintText;
    TextInputAction textInputAction = TextInputAction.next;
    double width = MediaQuery.of(context).size.width * 0.8;
    for (int i = 0; i < textForms!; i++) {
      if (i == 0) {
        hintText = '${kLanguageElementTranslations[widget.languageElement]}';
      } else if (i == 1) {
        hintText = 'tłumaczenie';
      } else {
        width = MediaQuery.of(context).size.width * 0.4;
        if (i == 7) {
          textInputAction = TextInputAction.done;
        }
        hintText = '$personConjugation. osoba';
        personConjugation++;
        if (personConjugation == 4) {
          personConjugation = 1;
        }
      }
      widgets.add(
        FocusTraversalOrder(
          order: NumericFocusOrder((i + 1).toDouble()),
          child: ConstrainedBox(
            constraints: BoxConstraints.tight(
              Size(width, 60),
            ),
            child: TextFormField(
              textInputAction: textInputAction,
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
              onFieldSubmitted: (value) {
                if (Platform.isWindows ||
                    Platform.isMacOS ||
                    Platform.isLinux) {
                  _onFieldSubmitted(value);
                  _focusNodes.first.requestFocus();
                }
              },
            ),
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      child: const SizedBox(),
                    ),
                    Expanded(
                      child: Text(
                        title!,
                        style: Theme.of(context).textTheme.headline5,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.close_rounded,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: _textFormFields[0],
              ),
              SizedBox(
                height: 8.0,
              ),
              Align(
                alignment: Alignment.center,
                child: _textFormFields[1],
              ),
              SizedBox(
                height: 15.0,
              ),
              if (widget.languageElement == LanguageElement.verb)
                Align(
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text('l. pojedyncza',
                              style: Theme.of(context).textTheme.headline5),
                          _textFormFields[2],
                          _textFormFields[3],
                          _textFormFields[4],
                        ],
                      ),
                      SizedBox(
                        width: 12.0,
                      ),
                      Column(
                        children: [
                          Text('l. mnoga',
                              style: Theme.of(context).textTheme.headline5),
                          _textFormFields[5],
                          _textFormFields[6],
                          _textFormFields[7],
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Tooltip(
                  message: 'Zatwierdź',
                  child: Center(
                    child: FloatingActionButton(
                      onPressed: () {
                        _onFieldSubmitted('');
                      },
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
