import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:language_learning/database/database.dart';
import 'package:language_learning/components/add_phrase_form.dart';
import 'package:language_learning/constants.dart';
import 'package:drift/drift.dart' as drift;

class ManagementPage extends StatefulWidget {
  final Language language;
  final List<String> specialCharacters;
  List<Phrase> initialPhrases;

  ManagementPage(
      {required this.language,
      required this.initialPhrases,
      this.specialCharacters = const []});

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  List<bool> edited = [];
  List<Phrase> originPhrases = [];
  List<Phrase> phrases = [];
  final _editPhraseTextController = TextEditingController();
  final _editTranslationTextController = TextEditingController();
  final _searchTextController = TextEditingController();

  Future getOriginPhrases() async {
    originPhrases = await Provider.of<MyDatabase>(context, listen: false)
        .getPhrases(widget.language);
    return phrases;
  }

  Future<List<Phrase>> getPhrases() async {
    var updatedPhrases = await Provider.of<MyDatabase>(context, listen: false)
        .getPhrases(widget.language);
    return updatedPhrases;
  }

  Future addPhrase(PhrasesCompanion phrase) async {
    Provider.of<MyDatabase>(context, listen: false).add(PhrasesCompanion(
      language: drift.Value(widget.language.name),
      content: drift.Value(phrase.content.value),
      polish_translation: drift.Value(
        phrase.polish_translation.value,
      ),
    ));
    widget.initialPhrases = await getPhrases();
    phrases = await getPhrases();
    setState(() {
      edited = List.filled(phrases.length, false);
    });
  }

  Future updatePhrase(int index) async {
    var updatedPhrase = Phrase(
        id: phrases[index].id,
        language: widget.language.name,
        content: _editPhraseTextController.text,
        polish_translation: _editTranslationTextController.text);
    await Provider.of<MyDatabase>(context, listen: false)
        .updatePhrase(updatedPhrase);
    widget.initialPhrases = await getPhrases();
    phrases = await getPhrases();
    setState(() {
      edited[index] = false;
    });
  }

  Future removePhrase(String phrase) async {
    await Provider.of<MyDatabase>(context, listen: false).remove(phrase);
    widget.initialPhrases = await getPhrases();
    phrases = await getPhrases();
    setState(() {});
  }

  void filterPhraseSearchResults(String query) {
    if (query.isNotEmpty) {
      List<Phrase> phraseSearchResults = [];

      for (var phrase in originPhrases) {
        if (phrase.content.toLowerCase().contains(query)) {
          phraseSearchResults.add(phrase);
        }
      }
      setState(() {
        phrases.clear();
        phrases.addAll(phraseSearchResults);
      });
    } else {
      setState(() {
        phrases.clear();
        phrases.addAll(originPhrases);
      });
    }
  }

  void refresh() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    phrases = List.from(widget.initialPhrases);
    edited = List.filled(phrases.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getOriginPhrases(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                actions: [
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              automaticallyImplyLeading: false,
                              title: Text('Nowa fraza'),
                              actions: [
                                IconButton(
                                  icon: Icon(Icons.close),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                              elevation: 0,
                            ),
                            body: Row(
                              children: [
                                Expanded(child: SizedBox.shrink()),
                                Expanded(
                                  flex: 4,
                                  child: AddPhraseForm(
                                    language: widget.language,
                                    specialCharacters: widget.specialCharacters,
                                    onPressedSubmitButton:
                                        (PhrasesCompanion phrase) {
                                      addPhrase(phrase);
                                    },
                                  ),
                                ),
                                Expanded(child: SizedBox.shrink()),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ],
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                elevation: 0,
              ),
              body: Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  ?.copyWith(color: Colors.grey),
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(25.0),
                                ),
                              ),
                            ),
                            onChanged: (value) {
                              filterPhraseSearchResults(value);
                            },
                            controller: _searchTextController,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                DataTable(
                                  showCheckboxColumn: false,
                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Text('fraza'),
                                    ),
                                    DataColumn(
                                      label: Text('tłumaczenie'),
                                    ),
                                    DataColumn(
                                      label: Text(''),
                                    )
                                  ],
                                  rows: List<DataRow>.generate(
                                    phrases.length,
                                    (int index) => DataRow(
                                      cells: <DataCell>[
                                        DataCell(
                                          edited[index]
                                              ? Builder(
                                                  builder: ((context) {
                                                    _editPhraseTextController
                                                            .text =
                                                        phrases[index].content;
                                                    _editPhraseTextController
                                                            .selection =
                                                        TextSelection
                                                            .fromPosition(
                                                      TextPosition(
                                                          offset:
                                                              _editPhraseTextController
                                                                  .text.length),
                                                    );
                                                    return TextFormField(
                                                      style: const TextStyle(
                                                        fontSize: 14.0,
                                                      ),
                                                      controller:
                                                          _editPhraseTextController,
                                                      autofocus: true,
                                                      textInputAction:
                                                          TextInputAction
                                                              .search,
                                                      onFieldSubmitted: (String?
                                                          value) async {
                                                        await updatePhrase(
                                                            index);
                                                      },
                                                    );
                                                  }),
                                                )
                                              : Text(phrases[index].content),
                                        ),
                                        DataCell(
                                          edited[index]
                                              ? Builder(
                                                  builder: ((context) {
                                                    _editTranslationTextController
                                                            .text =
                                                        phrases[index]
                                                            .polish_translation;
                                                    _editTranslationTextController
                                                            .selection =
                                                        TextSelection.fromPosition(
                                                            TextPosition(
                                                                offset:
                                                                    _editTranslationTextController
                                                                        .text
                                                                        .length));
                                                    return TextFormField(
                                                      style: const TextStyle(
                                                        fontSize: 14.0,
                                                      ),
                                                      controller:
                                                          _editTranslationTextController,
                                                      autofocus: true,
                                                      textInputAction:
                                                          TextInputAction
                                                              .search,
                                                      onFieldSubmitted: (String?
                                                          value) async {
                                                        await updatePhrase(
                                                            index);
                                                      },
                                                    );
                                                  }),
                                                )
                                              : Text(phrases[index]
                                                  .polish_translation),
                                        ),
                                        DataCell(
                                          edited[index]
                                              ? InkWell(
                                                  child: const FaIcon(
                                                    FontAwesomeIcons.check,
                                                    color: Colors.greenAccent,
                                                    size: 15.0,
                                                  ),
                                                  hoverColor:
                                                      Colors.transparent,
                                                  onTap: () async {
                                                    updatePhrase(index);
                                                  },
                                                )
                                              : Row(
                                                  children: [
                                                    InkWell(
                                                      child: const FaIcon(
                                                        FontAwesomeIcons.pen,
                                                        color: Colors.blue,
                                                        size: 15.0,
                                                      ),
                                                      hoverColor:
                                                          Colors.transparent,
                                                      onTap: () {
                                                        setState(() {
                                                          edited[index] = true;
                                                        });
                                                      },
                                                    ),
                                                    const SizedBox(
                                                      width: 10.0,
                                                    ),
                                                    InkWell(
                                                      child: const FaIcon(
                                                        FontAwesomeIcons
                                                            .solidTrashAlt,
                                                        color: Colors.redAccent,
                                                        size: 15.0,
                                                      ),
                                                      hoverColor:
                                                          Colors.transparent,
                                                      onTap: () async {
                                                        setState(() {
                                                          removePhrase(
                                                              phrases[index]
                                                                  .content);
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Center(
              child: Text('Trwa pobieranie danych...'),
            );
          }
        });
  }
}
