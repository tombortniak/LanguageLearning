import 'package:flutter/material.dart';
import 'package:language_learning/components/element_card.dart';
import 'package:language_learning/models/edited_field.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';
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
  List<dynamic> elements = [];
  final _editElementTextController = TextEditingController();
  final _editTranslationTextController = TextEditingController();
  final _searchTextController = TextEditingController();
  List<bool> editedFields = [];
  Color color = Colors.red;

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

  @override
  void initState() {
    super.initState();
    editedFields = List.generate(
        context
            .read<LanguageElementData>()
            .getElements(widget.languageElement)
            .length,
        (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<LanguageElementData>(
        builder: (context, languageElementData, child) {
          var languageElements = [];
          if (widget.languageElement == LanguageElement.word) {
            languageElements = languageElementData.viewLanguageElements.item1;
          } else if (widget.languageElement == LanguageElement.verb) {
            languageElements = languageElementData.viewLanguageElements.item2;
          } else {
            languageElements = languageElementData.viewLanguageElements.item3;
          }
          return Scaffold(
            body: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  width: width * 0.7,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(5.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Szukaj',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.copyWith(color: Colors.grey),
                      prefixIcon: const Icon(Icons.search, color: Colors.grey),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      languageElementData.filter(value, widget.languageElement);
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    controller: _searchTextController,
                  ),
                ),
                ElementCard(
                  showOptions: false,
                  content: Text(
                      '${kLanguageElementTranslations[widget.languageElement]}',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5),
                  translation: Text('tłumaczenie',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5),
                ),
                Divider(),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: ((context, index) => const Divider()),
                    itemCount: languageElements.length,
                    itemBuilder: (BuildContext context, index) {
                      return Dismissible(
                        background: Container(
                          color: color,
                          alignment: AlignmentDirectional.centerStart,
                          child: Icon(Icons.delete),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: AlignmentDirectional.centerEnd,
                          child: Icon(Icons.delete),
                        ),
                        onDismissed: (direction) {
                          languageElementData.removeElement(
                            languageElements[index],
                            widget.languageElement,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: Colors.blueAccent,
                              content: Text(
                                'Usunięto ${languageElements[index].content}',
                                textAlign: TextAlign.center,
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        key: UniqueKey(),
                        child: ElementCard(
                            onEditTapped: () {
                              setEditedIndex(index);
                            },
                            onDeleteTapped: () {
                              languageElementData.removeElement(
                                  languageElements[index],
                                  widget.languageElement);
                            },
                            showOptions: true,
                            content: Text(languageElements[index].content,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1),
                            translation: Text(
                                languageElements[index].translation,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1)),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
