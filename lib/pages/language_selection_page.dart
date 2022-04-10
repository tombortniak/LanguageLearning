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

  Future showDetailsDialog(Language language) async {
    var words = await context.read<LanguageDatabase>().getWords(language);
    var verbs = await context.read<LanguageDatabase>().getVerbs(language);
    var phrases = await context.read<LanguageDatabase>().getPhrases(language);
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
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
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    onAddLanguageDialogSubmitted();
                  });
                },
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
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
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    onEditLanguageDialogSubmitted(Language(
                        id: language.id, name: _languageTextController.text));
                  });
                },
                child: const Icon(
                  Icons.check,
                  color: Colors.white,
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
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
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
    var languages = await context.read<LanguageDatabase>().getLanguages();
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
  }

  void onEditLanguageDialogSubmitted(Language language) {
    if (context
        .read<LanguageElementData>()
        .languages
        .any((element) => element.name == _languageTextController.text)) {
      showMessage(MessageType.error, 'Podany język już istnieje');
    } else {
      context.read<LanguageDatabase>().updateLanguage(language);
      showMessage(MessageType.success, 'Język został zmieniony');
      Navigator.pop(context);
    }
  }

  void deleteLanguage(Language language) async {
    context.read<LanguageDatabase>().removeWordsOf(language);
    context.read<LanguageDatabase>().removeVerbsOf(language);
    context.read<LanguageDatabase>().removePhrasesOf(language);
    context.read<LanguageDatabase>().removeLanguage(language);
  }

  @override
  void initState() {
    super.initState();
    _fToast = FToast();
    _fToast!.init(context);
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
      body: FutureBuilder<List<Language>>(
        future: context.read<LanguageDatabase>().getLanguages(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Language>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LanguagePage(language: snapshot.data![index]),
                            ));
                      },
                      child: ListTile(
                        title: Text(
                          snapshot.data![index].name,
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        trailing: PopupMenuButton(
                          tooltip: '',
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry>[
                            PopupMenuItem(
                              child: Text(
                                'edytuj',
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              value: PopupAction.edit,
                              onTap: () {
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  showEditLanguageDialog(snapshot.data![index]);
                                });
                              },
                            ),
                            PopupMenuItem(
                              child: Text(
                                'usuń',
                              ),
                              value: PopupAction.delete,
                              onTap: () {
                                WidgetsBinding.instance!
                                    .addPostFrameCallback((_) {
                                  showDeleteLanguageDialog(
                                      snapshot.data![index]);
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
                                      .addPostFrameCallback((_) async {
                                    await showDetailsDialog(
                                        snapshot.data![index]);
                                  });
                                })
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Błąd przy pobieraniu danych'),
            );
          } else {
            return Center(
              child: Text('Trwa pobieranie danych'),
            );
          }
        },
      ),
    );
  }
}
