import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:provider/provider.dart';
import 'package:language_learning/database/database.dart';
import 'package:path/path.dart';
import 'package:language_learning/components/menu_button.dart';
import 'package:language_learning/components/add_phrase_form.dart';
import 'package:drift/drift.dart' as drift;

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  List<bool> selected = [];
  List<bool> edited = [];
  List<Phrase> phrases = [];
  final _editPhraseTextController = TextEditingController();
  final _editTranslationTextController = TextEditingController();

  Future<List<Phrase>> getAllPhrases(context) async {
    phrases = await Provider.of<MyDatabase>(context, listen: false).allPhrases;
    return phrases;
  }

  Future removePhrase(BuildContext context, String phrase) async {
    await Provider.of<MyDatabase>(context, listen: false).remove(phrase);
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: getAllPhrases(context),
          builder:
              (BuildContext context, AsyncSnapshot<List<Phrase>> snapshot) {
            Widget widget;
            if (snapshot.hasData) {
              selected.addAll(
                List<bool>.generate(phrases.length, (index) => false),
              );
              edited.addAll(
                List<bool>.generate(phrases.length, (index) => false),
              );
              widget = SingleChildScrollView(
                child: DataTable(
                  showCheckboxColumn: true,
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Text('fraza'),
                    ),
                    DataColumn(
                      label: Text('tłumaczenie'),
                    ),
                    DataColumn(label: Text(''))
                  ],
                  rows: List<DataRow>.generate(
                    phrases.length,
                    (int index) => DataRow(
                      color: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.selected))
                          return Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(0.08);
                        return Colors.transparent;
                      }),
                      selected: selected[index],
                      onSelectChanged: (bool? value) {
                        setState(() {
                          selected[index] = value!;
                        });
                      },
                      cells: <DataCell>[
                        DataCell(
                          edited[index]
                              ? Builder(
                                  builder: ((context) {
                                    _editPhraseTextController.text =
                                        phrases[index].content;
                                    return TextFormField(
                                      style: TextStyle(fontSize: 14.0),
                                      controller: _editPhraseTextController,
                                      autofocus: true,
                                      textInputAction: TextInputAction.go,
                                    );
                                  }),
                                )
                              : Text(phrases[index].content),
                        ),
                        DataCell(
                          edited[index]
                              ? Builder(
                                  builder: ((context) {
                                    _editTranslationTextController.text =
                                        phrases[index].polish_translation;
                                    return TextFormField(
                                      style: TextStyle(fontSize: 14.0),
                                      controller:
                                          _editTranslationTextController,
                                      autofocus: true,
                                      textInputAction: TextInputAction.go,
                                    );
                                  }),
                                )
                              : Text(phrases[index].polish_translation),
                        ),
                        DataCell(
                          edited[index]
                              ? InkWell(
                                  child: const FaIcon(
                                    FontAwesomeIcons.check,
                                    color: Colors.greenAccent,
                                    size: 15.0,
                                  ),
                                  hoverColor: Colors.transparent,
                                  onTap: () async {
                                    var updatedPhrase = Phrase(
                                        id: phrases[index].id,
                                        language: 'spanish',
                                        content: _editPhraseTextController.text,
                                        polish_translation:
                                            _editTranslationTextController
                                                .text);
                                    await Provider.of<MyDatabase>(context,
                                            listen: false)
                                        .updatePhrase(updatedPhrase);
                                    setState(() {
                                      edited[index] = false;
                                    });
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
                                      hoverColor: Colors.transparent,
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
                                        FontAwesomeIcons.solidTrashAlt,
                                        color: Colors.redAccent,
                                        size: 15.0,
                                      ),
                                      hoverColor: Colors.transparent,
                                      onTap: () async {
                                        setState(() {
                                          removePhrase(
                                              context, phrases[index].content);
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
              );
            } else if (snapshot.hasError) {
              widget = const Icon(Icons.error);
            } else {
              widget = const Center(
                child: Text('Pobieranie danych...'),
              );
            }
            return Container(
              margin: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 2,
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          padding: EdgeInsets.all(15.0),
                          child: AddPhraseForm(
                            onPressedSubmitButton: () {
                              refresh();
                            },
                          ),
                        ),
                        Expanded(
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      child: widget,
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
