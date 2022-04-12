import 'package:flutter/material.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';
import 'package:language_learning/constants.dart';
import 'package:language_learning/database/database.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:drift/drift.dart' as drift;

class CategoriesPage extends StatefulWidget {
  final Language language;
  const CategoriesPage({Key? key, required this.language}) : super(key: key);

  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  TextEditingController _categoryTextController = TextEditingController();
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

  void onAddCategoryDialogSubmitted() async {
    var categories =
        context.read<LanguageElementData>().getCategories(widget.language);
    if (_categoryTextController.text.isNotEmpty) {
      if (categories
          .any((element) => element.name == _categoryTextController.text)) {
        showMessage(MessageType.error, 'Podana kategoria już istnieje');
      } else {
        context.read<LanguageElementData>().addCategory(CategoriesCompanion(
              name: drift.Value(_categoryTextController.text),
              language: drift.Value(widget.language.id),
            ));
        setState(() {});
        showMessage(MessageType.success,
            'Kategoria ${_categoryTextController.text} została dodana');
        Navigator.pop(context);
      }
    } else {
      showMessage(MessageType.error, 'Nazwa kategorii nie może być pusta');
    }
  }

  void onEditCategoryDialogSubmitted(Category category) {
    if (context
        .read<LanguageElementData>()
        .categories
        .any((element) => element.name == _categoryTextController.text)) {
      showMessage(MessageType.error, 'Podany język już istnieje');
    } else {
      context.read<LanguageElementData>().updateCategory(category);
      showMessage(MessageType.success, 'Język został zmieniony');
      Navigator.pop(context);
    }
  }

  void deleteCategory(Category category) async {
    Provider.of<LanguageElementData>(context, listen: false)
        .removeCategory(category);
    for (var word in context.read<LanguageElementData>().words) {
      if (word.category == category.id) {
        context.read<LanguageElementData>().updateElement(
            Word(
                id: word.id,
                language: widget.language.id,
                content: word.content,
                translation: word.translation,
                category: null),
            LanguageElement.word);
      }
    }

    for (var verb in context.read<LanguageElementData>().verbs) {
      if (verb.category == category.id) {
        context.read<LanguageElementData>().updateElement(
            Verb(
                id: verb.id,
                language: widget.language.id,
                content: verb.content,
                translation: verb.translation,
                firstPersonSingular: verb.firstPersonSingular,
                secondPersonSingular: verb.secondPersonSingular,
                thirdPersonSingular: verb.thirdPersonSingular,
                firstPersonPlural: verb.firstPersonPlural,
                secondPersonPlural: verb.secondPersonPlural,
                thirdPersonPlural: verb.thirdPersonPlural,
                category: null),
            LanguageElement.word);
      }
    }

    for (var phrase in context.read<LanguageElementData>().phrases) {
      if (phrase.category == category.id) {
        context.read<LanguageElementData>().updateElement(
            Phrase(
                id: phrase.id,
                language: widget.language.id,
                content: phrase.content,
                translation: phrase.translation,
                category: null),
            LanguageElement.phrase);
      }
    }
  }

  void showNewCategoryDialog() {
    _categoryTextController.clear();
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            children: [
              Center(
                child: Text(
                  'Nowa kategoria',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: _categoryTextController,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    hintText: 'kategoria',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                  onSubmitted: (value) {},
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 65.0),
                child: FloatingActionButton.extended(
                  heroTag: 'btn2',
                  label: Text(
                    'Dodaj',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  onPressed: () {
                    setState(() {
                      onAddCategoryDialogSubmitted();
                    });
                  },
                ),
              ),
            ],
          );
        });
  }

  void showEditCategoryDialog(Category category) {
    _categoryTextController.text = category.name;
    showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            children: [
              Center(
                child: Text(
                  'Edycja kategorii',
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: TextField(
                  controller: _categoryTextController,
                  autofocus: true,
                  decoration: InputDecoration(
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.deepPurple),
                    ),
                    hintText: 'kategoria',
                    hintStyle: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 65.0),
                child: FloatingActionButton.extended(
                  heroTag: 'btn3',
                  label: Text('Edytuj',
                      style: Theme.of(context).textTheme.bodyText1),
                  onPressed: () {
                    setState(() {
                      onEditCategoryDialogSubmitted(Category(
                          id: category.id,
                          name: _categoryTextController.text,
                          language: widget.language.id));
                    });
                  },
                ),
              ),
            ],
          );
        });
  }

  void showDeleteCategoryDialog(Category category) {
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
                      'Czy na pewno chcesz usunąć kategorię ${category.name}?',
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
                              deleteCategory(category);
                            });
                            Navigator.pop(context);
                            showMessage(MessageType.success,
                                'Usunięto kategorię ${category.name}');
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
        title: Text('Kategorie'),
      ),
      body: Column(
        children: [
          Consumer<LanguageElementData>(
            builder: (context, languageElementData, child) {
              return Expanded(
                child: ListView.builder(
                  itemCount: languageElementData.categories.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(languageElementData.categories[index].name),
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
                              WidgetsBinding.instance!
                                  .addPostFrameCallback((_) {
                                showEditCategoryDialog(
                                    languageElementData.categories[index]);
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
                                showDeleteCategoryDialog(
                                    languageElementData.categories[index]);
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              child: FloatingActionButton(
                heroTag: 'btn4',
                child: Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  showNewCategoryDialog();
                },
              ),
              margin: EdgeInsets.all(25.0),
            ),
          ),
        ],
      ),
    );
  }
}
