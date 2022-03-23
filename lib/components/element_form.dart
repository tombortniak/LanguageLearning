import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:language_learning/constants.dart';
import 'package:drift/drift.dart' as drift;
import 'package:language_learning/database/database.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tuple/tuple.dart';

class ElementForm extends StatefulWidget {
  final Language language;
  final LanguageElement languageElement;
  dynamic initialValue;
  final List<String> specialCharacters;

  ElementForm(
      {Key? key,
      required this.language,
      required this.languageElement,
      this.initialValue,
      this.specialCharacters = const []})
      : super(key: key);

  @override
  State<ElementForm> createState() => _ElementFormState();
}

class _ElementFormState extends State<ElementForm> {
  final _formKey = GlobalKey<FormState>();
  List<TextEditingController> _textControllers =
      List.generate(8, (index) => TextEditingController());
  List<FocusNode> _focusNodes = List.generate(8, (index) => FocusNode());
  List<Widget> _textFormFields = [];
  bool showSpecialCharacters = false;
  int? textForms;
  FToast? fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast?.init(context);
    if (widget.languageElement == LanguageElement.verb) {
      textForms = 8;
    } else {
      textForms = 2;
    }
    _focusNodes = List.generate(textForms!, (index) => FocusNode());
    _textControllers =
        List.generate(textForms!, (index) => TextEditingController());

    for (int i = 0; i < textForms!; i++) {
      _focusNodes[i].addListener(() {
        _textControllers[i].selection = TextSelection.fromPosition(
          TextPosition(offset: _textControllers[i].text.length),
        );
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

  String capitalize(String value) {
    return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
  }

  void setFieldsInitialValues() {
    _textControllers[0].text = widget.initialValue.content;
    _textControllers[0].selection = TextSelection.fromPosition(
      TextPosition(offset: _textControllers[0].text.length),
    );
    _textControllers[1].text = widget.initialValue.translation;
    if (widget.languageElement == LanguageElement.verb) {
      _textControllers[2].text = widget.initialValue.firstPersonSingular;
      _textControllers[3].text = widget.initialValue.secondPersonSingular;
      _textControllers[4].text = widget.initialValue.thirdPersonSingular;
      _textControllers[5].text = widget.initialValue.firstPersonPlural;
      _textControllers[6].text = widget.initialValue.secondPersonPlural;
      _textControllers[7].text = widget.initialValue.thirdPersonPlural;
    }
  }

  Tuple2<dynamic, String> makeNewElement() {
    String message = '';
    var element;
    if (widget.languageElement == LanguageElement.word) {
      message = 'zostało dodane';
      element = WordsCompanion(
          language: drift.Value(widget.language.name),
          content: drift.Value(_textControllers[0].text),
          translation: drift.Value(_textControllers[1].text));
    } else if (widget.languageElement == LanguageElement.phrase) {
      message = 'została dodana';
      element = PhrasesCompanion(
          language: drift.Value(widget.language.name),
          content: drift.Value(_textControllers[0].text),
          translation: drift.Value(_textControllers[1].text));
    } else {
      message = 'został dodany';
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

    return Tuple2(element, message);
  }

  Tuple2<dynamic, String> makeEditedElement() {
    String message = '';
    var element;
    if (widget.languageElement == LanguageElement.word) {
      message = 'zostało zmienione';
      element = Word(
          id: widget.initialValue.id,
          language: widget.language.name,
          content: _textControllers[0].text,
          translation: _textControllers[1].text,
          category: widget.initialValue.category);
    } else if (widget.languageElement == LanguageElement.phrase) {
      message = 'została zmieniona';
      element = Phrase(
          id: widget.initialValue.id,
          language: widget.language.name,
          content: _textControllers[0].text,
          translation: _textControllers[1].text,
          category: widget.initialValue.category);
    } else {
      message = 'został zmieniony';
      element = Verb(
        id: widget.initialValue.id,
        language: widget.language.name,
        content: _textControllers[0].text,
        translation: _textControllers[1].text,
        firstPersonSingular: _textControllers[2].text,
        secondPersonSingular: _textControllers[3].text,
        thirdPersonSingular: _textControllers[4].text,
        firstPersonPlural: _textControllers[5].text,
        secondPersonPlural: _textControllers[6].text,
        thirdPersonPlural: _textControllers[7].text,
        category: widget.initialValue.category,
      );
    }

    return Tuple2(element, message);
  }

  void _onFieldSubmitted(String value) async {
    if (_textControllers.any((element) => element.text.isEmpty)) {
      fToast?.showToast(
          gravity: ToastGravity.TOP,
          child: Container(
            padding: const EdgeInsets.all(15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: Colors.redAccent,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  'Wszystkie pola muszą być wypełnione',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ));
    } else {
      if (_formKey.currentState!.validate()) {
        if (widget.initialValue != null) {
          var result = makeEditedElement();
          await context
              .read<LanguageElementData>()
              .updateElement(result.item1, widget.languageElement);
          fToast?.showToast(
              gravity: ToastGravity.TOP,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.greenAccent),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${capitalize(kLanguageElementTranslations[widget.languageElement]!)} ${result.item2}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ));
          Navigator.pop(context);
        } else {
          if (context
              .read<LanguageElementData>()
              .contains(_textControllers[0].text, widget.languageElement)) {
            fToast?.showToast(
                gravity: ToastGravity.TOP,
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.redAccent,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.error),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        '${capitalize(kLanguageElementTranslations[widget.languageElement]!)} już istnieje',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ));
          }
          var result = makeNewElement();
          await context
              .read<LanguageElementData>()
              .addElement(result.item1, widget.languageElement);
          fToast?.showToast(
              gravity: ToastGravity.TOP,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.greenAccent,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.check,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      '${capitalize(kLanguageElementTranslations[widget.languageElement]!)} ${result.item2}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Colors.black),
                    ),
                  ],
                ),
              ));
        }
      }
      for (var controller in _textControllers) {
        controller.clear();
      }
      _focusNodes[0].requestFocus();
    }
  }

  List<Widget> _buildFormFields() {
    List<Widget> widgets = [];
    int personConjugation = 1;
    String hintText;
    TextInputAction textInputAction = TextInputAction.next;
    double width = MediaQuery.of(context).size.width * 0.7;
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
              onTap: () {
                _textControllers[i].selection = TextSelection.fromPosition(
                  TextPosition(offset: _textControllers[i].text.length),
                );
              },
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
    if (widget.initialValue != null) {
      setFieldsInitialValues();
    }
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
                        '${kLanguageElementTranslations[widget.languageElement]}',
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
