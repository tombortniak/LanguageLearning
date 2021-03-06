import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:language_learning/components/element_card.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';
import 'package:language_learning/components/element_form.dart';
import 'package:language_learning/constants.dart' hide Language;
import 'package:language_learning/database/database.dart';

class LanguageManagementPage extends StatefulWidget {
  final LanguageElement languageElement;
  final Language language;

  LanguageManagementPage({
    required this.languageElement,
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
  final _searchTextController = TextEditingController();
  Color color = Colors.red;
  FToast? fToast;

  String capitalize(String value) {
    return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
  }

  Widget buildDetailsView(dynamic element) {
    String elementName = '';
    if (widget.languageElement == LanguageElement.verb) {
      elementName = 'czasownik';
    } else if (widget.languageElement == LanguageElement.word) {
      elementName = 'słowo';
    } else {
      elementName = 'fraza';
    }
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    elementName,
                  ),
                  const Text(
                    'tłumaczenie',
                  ),
                  const Text('kategoria'),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    element.content,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    element.translation,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Text(
                    element.category == null
                        ? 'brak'
                        : context
                            .read<LanguageElementData>()
                            .categories
                            .where((e) => e.id == element.category)
                            .toList()
                            .first
                            .name,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
            ],
          ),
          if (widget.languageElement == LanguageElement.verb)
            Column(
              children: [
                const SizedBox(
                  height: 10.0,
                ),
                const Text('Liczba pojedyncza'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('1. osoba'),
                        Text('2. osoba'),
                        Text('3. osoba'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          element.firstPersonSingular,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          element.secondPersonSingular,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          element.thirdPersonSingular,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                const Text('Liczba mnoga'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('1. osoba'),
                        Text('2. osoba'),
                        Text('3. osoba'),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          element.firstPersonPlural,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          element.secondPersonPlural,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        Text(
                          element.thirdPersonPlural,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast?.init(context);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final width = MediaQuery.of(context).size.width * 0.9;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Consumer<LanguageElementData>(
        builder: (context, languageElementData, child) {
          var languageElements = [];
          if (widget.languageElement == LanguageElement.word) {
            languageElements = languageElementData.getWords(widget.language);
          } else if (widget.languageElement == LanguageElement.verb) {
            languageElements = languageElementData.getVerbs(widget.language);
          } else {
            languageElements = languageElementData.getPhrases(widget.language);
          }
          return Scaffold(
            body: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10.0),
                  width: width,
                  child: TextField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(5.0),
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
                    onChanged: (value) async {
                      await languageElementData.filter(
                          value, widget.languageElement);
                    },
                    onEditingComplete: () {
                      FocusScope.of(context).unfocus();
                    },
                    controller: _searchTextController,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                          '${kLanguageElementTranslations[widget.languageElement]}',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text('tłumaczenie',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.headline4),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: ((context, index) => const Divider()),
                    itemCount: languageElements.length,
                    itemBuilder: (BuildContext context, index) {
                      return Dismissible(
                        dismissThresholds: const {
                          DismissDirection.startToEnd: 0.4,
                          DismissDirection.endToStart: 0.4
                        },
                        movementDuration: Duration(seconds: 1),
                        background: Container(
                          color: color,
                          alignment: AlignmentDirectional.centerStart,
                          child: const Icon(Icons.delete),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: AlignmentDirectional.centerEnd,
                          child: const Icon(Icons.delete),
                        ),
                        onDismissed: (direction) {
                          languageElementData.removeElement(
                            languageElements[index],
                            widget.languageElement,
                          );
                          String message = '';
                          if (widget.languageElement == LanguageElement.word) {
                            message = 'zostało usunięte';
                          } else if (widget.languageElement ==
                              LanguageElement.verb) {
                            message = 'został usunięty';
                          } else {
                            message = 'została usunięta';
                          }
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
                                    '${capitalize(kLanguageElementTranslations[widget.languageElement]!)} $message',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(color: Colors.black),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        key: UniqueKey(),
                        child: ElementCard(
                          onEditTapped: () {
                            showModalBottomSheet(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0),
                                ),
                              ),
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return ElementForm(
                                    initialValue: languageElements[index],
                                    languageElement: widget.languageElement,
                                    language: widget.language);
                              },
                            );
                          },
                          onDeleteTapped: () {
                            languageElementData.removeElement(
                                languageElements[index],
                                widget.languageElement);
                          },
                          onDetailsTapped: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return SimpleDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20.0)),
                                    children: [
                                      Center(
                                        child: Text(
                                          'Szczegóły',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15.0,
                                      ),
                                      buildDetailsView(languageElements[index])
                                    ],
                                  );
                                });
                          },
                          index: index,
                          content: Text(languageElements[index].content,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1),
                          translation: Text(languageElements[index].translation,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1),
                        ),
                      );
                    },
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    child: FloatingActionButton(
                      child: Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        showModalBottomSheet(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25.0)),
                          ),
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return ElementForm(
                                languageElement: widget.languageElement,
                                language: widget.language);
                          },
                        );
                      },
                    ),
                    margin: EdgeInsets.all(25.0),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
