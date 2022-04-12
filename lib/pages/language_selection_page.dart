import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:language_learning/database/database.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';
import 'language_page.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:language_learning/constants.dart' hide Language;

class LanguageSelectionPage extends StatefulWidget {
  LanguageSelectionPage({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionPage> createState() => _LanguageSelectionPageState();
}

class _LanguageSelectionPageState extends State<LanguageSelectionPage> {
  TextEditingController _languageTextController = TextEditingController();
  FToast? _fToast;

  void showMessage(MessageType messageType, String message) {
    Color backgroundColor;
    Color textColor;
    IconData iconData;
    if (messageType == MessageType.error) {
      backgroundColor = Colors.redAccent;
      textColor = Colors.white;
      iconData = Icons.error;
    } else {
      backgroundColor = Colors.greenAccent;
      textColor = Colors.black;
      iconData = Icons.check;
    }
    _fToast?.showToast(
        gravity: ToastGravity.BOTTOM,
        child: Container(
          padding: const EdgeInsets.all(15.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              color: backgroundColor),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                iconData,
                color: textColor,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(
                message,
                style: Theme.of(context)
                    .textTheme
                    .bodyText1!
                    .copyWith(color: textColor),
              ),
            ],
          ),
        ));
  }

  void showDetailsDialog(Language language) {
    var words = context.read<LanguageElementData>().words;
    var verbs = context.read<LanguageElementData>().verbs;
    var phrases = context.read<LanguageElementData>().phrases;
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            children: [
              Center(
                child: Text(
                  'Szczegóły',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'słowa:',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text('czasowniki:',
                            style: Theme.of(context).textTheme.bodyText1),
                        Text('frazy:',
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('${words.length}',
                            style: Theme.of(context).textTheme.bodyText1),
                        Text('${verbs.length}',
                            style: Theme.of(context).textTheme.bodyText1),
                        Text('${phrases.length}',
                            style: Theme.of(context).textTheme.bodyText1),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  void showNewLanguageDialog() {
    _languageTextController.clear();
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            children: [
              Center(
                child: Text(
                  'Nowy język',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: _languageTextController,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    hintText: 'język',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                  onSubmitted: (value) {
                    if (Platform.isMacOS ||
                        Platform.isLinux ||
                        Platform.isWindows) {
                      onAddLanguageDialogSubmitted();
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 65.0),
                child: FloatingActionButton.extended(
                  heroTag: 'btn5',
                  label: Text(
                    'Dodaj',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: () {
                    setState(() {
                      onAddLanguageDialogSubmitted();
                    });
                  },
                ),
              ),
            ],
          );
        });
  }

  void showEditLanguageDialog(Language language) {
    _languageTextController.text = language.name;
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            children: [
              Center(
                child: Text(
                  'Edycja języka',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: _languageTextController,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    hintText: 'język',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                  onSubmitted: (value) {
                    if (Platform.isMacOS ||
                        Platform.isLinux ||
                        Platform.isWindows) {
                      onEditLanguageDialogSubmitted(Language(
                          id: language.id, name: _languageTextController.text));
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 65.0),
                child: FloatingActionButton.extended(
                  heroTag: 'btn6',
                  label: Text('Edytuj',
                      style: Theme.of(context).textTheme.bodyText1),
                  onPressed: () {
                    setState(() {
                      onEditLanguageDialogSubmitted(Language(
                          id: language.id, name: _languageTextController.text));
                    });
                  },
                ),
              ),
            ],
          );
        });
  }

  void showDeleteLanguageDialog(Language language) {
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            children: [
              Padding(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(
                      'Czy na pewno chcesz usunąć język ${language.name}?',
                      style: Theme.of(context).textTheme.headline5,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              deleteLanguage(language);
                            });
                            Navigator.pop(context);
                            showMessage(MessageType.success,
                                'Usunięto język ${language.name}');
                          },
                          child: Text(
                            'tak',
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('nie',
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          );
        });
  }

  void onAddLanguageDialogSubmitted() async {
    var languages = context.read<LanguageElementData>().languages;
    if (_languageTextController.text.isNotEmpty) {
      if (languages
          .any((element) => element.name == _languageTextController.text)) {
        showMessage(MessageType.error, 'Podany język już istnieje');
      } else {
        context.read<LanguageElementData>().addLanguage(LanguagesCompanion(
              name: Value(_languageTextController.text),
            ));
        setState(() {});
        showMessage(MessageType.success,
            'Język ${_languageTextController.text} został dodany');
        Navigator.pop(context);
      }
    } else {
      showMessage(MessageType.error, 'Nazwa języka nie może być pusta');
    }
  }

  void onEditLanguageDialogSubmitted(Language language) {
    if (context
        .read<LanguageElementData>()
        .languages
        .any((element) => element.name == _languageTextController.text)) {
      showMessage(MessageType.error, 'Podany język już istnieje');
    } else {
      context.read<LanguageElementData>().updateLanguage(language);
      showMessage(MessageType.success, 'Język został zmieniony');
      Navigator.pop(context);
    }
  }

  void deleteLanguage(Language language) async {
    Provider.of<LanguageElementData>(context, listen: false)
        .removeWordsOf(language);
    Provider.of<LanguageElementData>(context, listen: false)
        .removeVerbsOf(language);
    Provider.of<LanguageElementData>(context, listen: false)
        .removePhrasesOf(language);
    Provider.of<LanguageElementData>(context, listen: false)
        .removeCategories(language);
    Provider.of<LanguageElementData>(context, listen: false)
        .removeLanguage(language);
  }

  @override
  void initState() {
    super.initState();
    _fToast = FToast();
    _fToast?.init(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Wybierz język',
            style: Theme.of(context).textTheme.headline4,
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            Tooltip(
              message: 'Dodaj język',
              child: IconButton(
                onPressed: () {
                  showNewLanguageDialog();
                },
                icon: Icon(Icons.add),
              ),
            ),
          ],
        ),
        body: Consumer<LanguageElementData>(
            builder: ((context, languageData, child) {
          return ListView.builder(
            itemCount: languageData.languages.length,
            itemBuilder: (context, index) {
              return Card(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LanguagePage(
                              language: languageData.languages[index]),
                        ));
                  },
                  child: ListTile(
                    title: Text(
                      languageData.languages[index].name,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    trailing: PopupMenuButton(
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
                              showEditLanguageDialog(
                                  languageData.languages[index]);
                            });
                          },
                        ),
                        PopupMenuItem(
                          child: Text(
                            'usuń',
                          ),
                          value: PopupAction.delete,
                          onTap: () {
                            WidgetsBinding.instance!.addPostFrameCallback((_) {
                              showDeleteLanguageDialog(
                                  languageData.languages[index]);
                            });
                          },
                        ),
                        PopupMenuItem(
                            child: Text(
                              'szczegóły',
                            ),
                            value: PopupAction.details,
                            onTap: () {
                              WidgetsBinding.instance!
                                  .addPostFrameCallback((_) {
                                showDetailsDialog(
                                    languageData.languages[index]);
                              });
                            })
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        })));
  }
}
