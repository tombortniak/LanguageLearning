import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:language_learning/models/edited_field.dart';
import 'package:provider/provider.dart';
import 'package:language_learning/database/database.dart';
import 'package:language_learning/constants.dart';

class LanguageManagementPage extends StatefulWidget {
  final LanguageElement languageElement;
  final List<String> specialCharacters;
  final Language language;

  LanguageManagementPage({
    required this.languageElement,
    required this.specialCharacters,
    required this.language,
  });

  @override
  State<LanguageManagementPage> createState() => _LanguageManagementPageState();
}

class _LanguageManagementPageState extends State<LanguageManagementPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  List<dynamic> viewElements = [];
  List<dynamic> elements = [];
  final _editElementTextController = TextEditingController();
  final _editTranslationTextController = TextEditingController();
  final _searchTextController = TextEditingController();

  Future<List<dynamic>> getElements() async {
    var languageElements =
        await Provider.of<LanguageDatabase>(context, listen: false)
            .getElements(widget.language, widget.languageElement);

    return languageElements;
  }

  Future updateElement(int index) async {
    if (widget.languageElement == LanguageElement.word) {
      await Provider.of<LanguageDatabase>(context, listen: false).updateWord(
        Word(
            id: viewElements[index].id,
            language: widget.language.name,
            content: _editElementTextController.text,
            translation: _editTranslationTextController.text),
      );
    } else if (widget.languageElement == LanguageElement.verb) {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .updateVerb(Verb(
        id: viewElements[index].id,
        language: widget.language.name,
        content: _editElementTextController.text,
        translation: _editTranslationTextController.text,
        firstPersonSingular: viewElements[index].firstPersonSingular,
        secondPersonSingular: viewElements[index].firstPersonSingular,
        thirdPersonSingular: viewElements[index].firstPersonSingular,
        firstPersonPlural: viewElements[index].firstPersonSingular,
        secondPersonPlural: viewElements[index].secondPersonSingular,
        thirdPersonPlural: viewElements[index].thirdPersonSingular,
      ));
    } else {
      await Provider.of<LanguageDatabase>(context, listen: false).updatePhrase(
          Phrase(
              id: viewElements[index].id,
              language: widget.language.name,
              content: _editElementTextController.text,
              translation: _editTranslationTextController.text));
    }
  }

  Future removeElement(int index) async {
    if (widget.languageElement == LanguageElement.word) {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .removeWord(elements[index].content);
    } else if (widget.languageElement == LanguageElement.verb) {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .removeVerb(elements[index].content);
    } else {
      await Provider.of<LanguageDatabase>(context, listen: false)
          .removePhrase(elements[index].content);
    }

    setState(() {});
  }

  int getEditedIndex() {
    if (widget.languageElement == LanguageElement.word) {
      return Provider.of<EditedField>(context, listen: false).wordIndex;
    } else if (widget.languageElement == LanguageElement.verb) {
      return Provider.of<EditedField>(context, listen: false).verbIndex;
    } else {
      return Provider.of<EditedField>(context, listen: false).phraseIndex;
    }
  }

  void setEditedIndex(int index) {
    if (widget.languageElement == LanguageElement.word) {
      Provider.of<EditedField>(context, listen: false).wordIndex = index;
    } else if (widget.languageElement == LanguageElement.verb) {
      Provider.of<EditedField>(context, listen: false).verbIndex = index;
    } else {
      Provider.of<EditedField>(context, listen: false).phraseIndex = index;
    }
  }

  void resetEditedIndex() {
    if (widget.languageElement == LanguageElement.word) {
      Provider.of<EditedField>(context, listen: false).wordIndex = -1;
    } else if (widget.languageElement == LanguageElement.verb) {
      Provider.of<EditedField>(context, listen: false).verbIndex = -1;
    } else {
      Provider.of<EditedField>(context, listen: false).phraseIndex = -1;
    }
  }

  void filterSearchResults(String query) async {
    if (query.isNotEmpty) {
      var elementSearchResults = [];

      for (var element in viewElements) {
        if (element.content.toLowerCase().contains(query)) {
          elementSearchResults.add(element);
        }
      }
      setState(() {
        viewElements.clear();
        viewElements.addAll(elementSearchResults);
      });
    } else {
      setState(() {
        viewElements.clear();
        viewElements.addAll(elements);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FutureBuilder<List<dynamic>>(
        future: getElements(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            elements = snapshot.data;
            viewElements = snapshot.data;
            final width = MediaQuery.of(context).size.width;
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Scaffold(
                body: Container(
                  margin: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const Expanded(
                                  child: SizedBox.shrink(),
                                ),
                                Expanded(
                                  flex: 6,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: const BorderSide(
                                              color: Colors.deepPurple),
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      hintText: 'Szukaj',
                                      hintStyle: Theme.of(context)
                                          .textTheme
                                          .bodyText1
                                          ?.copyWith(color: Colors.grey),
                                      prefixIcon: const Icon(Icons.search,
                                          color: Colors.grey),
                                      border: const OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(25.0),
                                        ),
                                      ),
                                    ),
                                    onChanged: (value) {
                                      filterSearchResults(value);
                                    },
                                    onEditingComplete: () {
                                      FocusScope.of(context).unfocus();
                                    },
                                    controller: _searchTextController,
                                  ),
                                ),
                                const Expanded(
                                  child: SizedBox.shrink(),
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  DataTable(
                                    showCheckboxColumn: false,
                                    columns: <DataColumn>[
                                      DataColumn(
                                        label: Text(
                                            '${kLanguageElementTranslations[widget.languageElement]}'),
                                      ),
                                      const DataColumn(
                                        label: Expanded(
                                            child: Text('tłumaczenie')),
                                      ),
                                      const DataColumn(
                                        label: Text(''),
                                      )
                                    ],
                                    rows: List<DataRow>.generate(
                                      viewElements.length,
                                      (int index) => DataRow(
                                        cells: <DataCell>[
                                          DataCell(
                                            getEditedIndex() == index
                                                ? Builder(
                                                    builder: ((context) {
                                                      _editElementTextController
                                                              .text =
                                                          viewElements[index]
                                                              .content;

                                                      _editElementTextController
                                                              .selection =
                                                          TextSelection
                                                              .fromPosition(
                                                        TextPosition(
                                                            offset:
                                                                _editElementTextController
                                                                    .text
                                                                    .length),
                                                      );
                                                      return Container(
                                                        width: width * .3,
                                                        child: TextFormField(
                                                          decoration:
                                                              InputDecoration(
                                                            focusedBorder:
                                                                const UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .deepPurple),
                                                            ),
                                                            hintText:
                                                                _editElementTextController
                                                                    .text,
                                                            hintStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2,
                                                          ),
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                          controller:
                                                              _editElementTextController,
                                                          autofocus: true,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .search,
                                                          onFieldSubmitted:
                                                              (String?
                                                                  value) async {
                                                            await updateElement(
                                                                index);
                                                            setState(() {
                                                              resetEditedIndex();
                                                            });
                                                          },
                                                        ),
                                                      );
                                                    }),
                                                  )
                                                : Builder(builder: (context) {
                                                    String text;
                                                    if (viewElements[index]
                                                            .content
                                                            .length >
                                                        30) {
                                                      text = viewElements[index]
                                                              .content
                                                              .substring(
                                                                  0, 30) +
                                                          '...';
                                                    } else {
                                                      text = viewElements[index]
                                                          .content;
                                                    }
                                                    return Text(text);
                                                  }),
                                          ),
                                          DataCell(
                                            getEditedIndex() == index
                                                ? Builder(
                                                    builder: ((context) {
                                                      _editTranslationTextController
                                                              .text =
                                                          viewElements[index]
                                                              .translation;

                                                      _editTranslationTextController
                                                              .selection =
                                                          TextSelection.fromPosition(
                                                              TextPosition(
                                                                  offset: _editTranslationTextController
                                                                      .text
                                                                      .length));
                                                      return Container(
                                                        width: width * .3,
                                                        child: TextFormField(
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1,
                                                          decoration:
                                                              InputDecoration(
                                                            focusedBorder:
                                                                const UnderlineInputBorder(
                                                              borderSide: BorderSide(
                                                                  color: Colors
                                                                      .deepPurple),
                                                            ),
                                                            hintText:
                                                                _editTranslationTextController
                                                                    .text,
                                                            hintStyle: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .bodyText2,
                                                          ),
                                                          controller:
                                                              _editTranslationTextController,
                                                          autofocus: true,
                                                          textInputAction:
                                                              TextInputAction
                                                                  .search,
                                                          onFieldSubmitted:
                                                              (String?
                                                                  value) async {
                                                            await updateElement(
                                                                index);
                                                            resetEditedIndex();
                                                            setState(() {});
                                                          },
                                                        ),
                                                      );
                                                    }),
                                                  )
                                                : Builder(builder: (context) {
                                                    String text;
                                                    if (viewElements[index]
                                                            .translation
                                                            .length >
                                                        30) {
                                                      text = viewElements[index]
                                                              .translation
                                                              .substring(
                                                                  0, 30) +
                                                          '...';
                                                    } else {
                                                      text = viewElements[index]
                                                          .translation;
                                                    }
                                                    return Text(text);
                                                  }),
                                          ),
                                          DataCell(
                                            getEditedIndex() == index
                                                ? InkWell(
                                                    child: const FaIcon(
                                                      FontAwesomeIcons.check,
                                                      color: Colors.greenAccent,
                                                      size: 20.0,
                                                    ),
                                                    hoverColor:
                                                        Colors.transparent,
                                                    onTap: () async {
                                                      await updateElement(
                                                          index);
                                                      setState(() {
                                                        resetEditedIndex();
                                                      });
                                                    },
                                                  )
                                                : Row(
                                                    children: [
                                                      InkWell(
                                                        child: const FaIcon(
                                                          FontAwesomeIcons.pen,
                                                          color: Colors.blue,
                                                          size: 18.0,
                                                        ),
                                                        hoverColor:
                                                            Colors.transparent,
                                                        onTap: () {
                                                          setState(() {
                                                            setEditedIndex(
                                                                index);
                                                          });
                                                        },
                                                      ),
                                                      const SizedBox(
                                                        width: 20.0,
                                                      ),
                                                      InkWell(
                                                        child: const FaIcon(
                                                          FontAwesomeIcons
                                                              .solidTrashAlt,
                                                          color:
                                                              Colors.redAccent,
                                                          size: 18.0,
                                                        ),
                                                        hoverColor:
                                                            Colors.transparent,
                                                        onTap: () async {
                                                          removeElement(index);
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
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Przy pobieraniu danych wystąpił błąd'),
            );
          } else {
            return const Center(
              child: Text('Trwa pobieranie danych'),
            );
          }
        });
  }
}
