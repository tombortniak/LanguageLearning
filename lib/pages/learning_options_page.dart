import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:language_learning/components/labeled_checkbox.dart';
import 'package:language_learning/components/labeled_radio.dart';
import 'package:language_learning/constants.dart' hide Language;
import 'package:language_learning/database/database.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';
import 'learning_page.dart';

class LearningOptionsPage extends StatefulWidget {
  const LearningOptionsPage({Key? key}) : super(key: key);

  @override
  State<LearningOptionsPage> createState() => _LearningOptionsPageState();
}

class _LearningOptionsPageState extends State<LearningOptionsPage> {
  LearningOption learningOption = LearningOption.all;
  Language? selectedLanguage;
  bool wordOptionValue = false;
  bool verbOptionValue = false;
  bool phraseOptionValue = false;
  List<bool> categoriesSelectedValues = [];
  List<FilterChip> categoryChips = [];
  List<Category> categories = [];
  TextEditingController searchTextController = TextEditingController();
  FocusNode searchFieldNode = FocusNode();
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
        gravity: ToastGravity.TOP,
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
              const SizedBox(
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

  void updateCategories() {
    categories =
        context.read<LanguageElementData>().getCategories(selectedLanguage!);
    categoriesSelectedValues =
        List.generate(categories.length, (index) => false);
  }

  List<Widget> buildCategoryChips() {
    categoryChips = List.generate(
      categories.length,
      (index) => FilterChip(
        selected: categoriesSelectedValues[index],
        showCheckmark: true,
        label: Text(categories[index].name),
        onSelected: (bool value) {
          setState(() {
            if (learningOption != LearningOption.all) {
              categoriesSelectedValues[index] = value;
            }
          });
        },
      ),
    );

    return categoryChips;
  }

  bool optionElementsEmpty() {
    return wordOptionValue && verbOptionValue && phraseOptionValue;
  }

  bool categoriesEmpty() {
    return categoriesSelectedValues.every((element) => element == false);
  }

  void onOptionsSubmitted() {
    if (learningOption == LearningOption.custom &&
        optionElementsEmpty() &&
        categoriesEmpty()) {
      showMessage(
          MessageType.error, 'Musisz wybra?? cz????ci j??zyka\n lub kategorie');
    } else {
      var learningContent = createLearningContent();
      if (learningContent.isEmpty) {
        showMessage(MessageType.error, 'Brak s????wek do nauki');
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LearningPage(
                learningContent: learningContent,
              ),
            ));
      }
    }
  }

  List<Category> getSelectedCategories() {
    List<Category> selectedCategories = [];
    for (int i = 0; i < categories.length; ++i) {
      if (categoriesSelectedValues[i]) {
        selectedCategories.add(categories[i]);
      }
    }

    return selectedCategories;
  }

  List<dynamic> createLearningContent() {
    List<dynamic> learningContent = [];
    var allWords =
        context.read<LanguageElementData>().getWords(selectedLanguage!);
    var allVerbs =
        context.read<LanguageElementData>().getVerbs(selectedLanguage!);
    var allPhrases =
        context.read<LanguageElementData>().getPhrases(selectedLanguage!);
    if (learningOption == LearningOption.all) {
      return [...allWords, ...allVerbs, ...allPhrases];
    } else {
      var selectedCategories = getSelectedCategories();
      if (selectedCategories.isNotEmpty) {
        for (var selectedCategory in selectedCategories) {
          learningContent.addAll(allWords
              .where((element) => element.category == selectedCategory.id)
              .toList());
          learningContent.addAll(allVerbs
              .where((element) => element.category == selectedCategory.id)
              .toList());
          learningContent.addAll(allPhrases
              .where((element) => element.category == selectedCategory.id)
              .toList());
        }
      } else {
        if (wordOptionValue) {
          learningContent.addAll(allWords);
        }

        if (verbOptionValue) {
          learningContent.addAll(allVerbs);
        }

        if (phraseOptionValue) {
          learningContent.addAll(allPhrases);
        }
      }
      return learningContent;
    }
  }

  @override
  void initState() {
    super.initState();
    _fToast = FToast();
    _fToast!.init(context);
    selectedLanguage = Provider.of<LanguageElementData>(context, listen: false)
        .languages
        .first;
    updateCategories();
    categoriesSelectedValues =
        List.generate(categories.length, (index) => false);
    buildCategoryChips();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        searchFieldNode.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    children: [
                      const Text(
                        'j??zyk',
                        textAlign: TextAlign.center,
                      ),
                      const Divider(),
                      DropdownButton(
                        value: selectedLanguage,
                        elevation: 0,
                        isExpanded: false,
                        items: context
                            .read<LanguageElementData>()
                            .languages
                            .map((Language language) {
                          return DropdownMenuItem(
                            child: Center(
                              child: Text(
                                language.name,
                              ),
                            ),
                            value: language,
                          );
                        }).toList(),
                        onChanged: (Language? language) {
                          setState(() {
                            selectedLanguage = language;
                            updateCategories();
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Column(
                    children: [
                      const Text(
                        'elementy do nauki',
                        textAlign: TextAlign.center,
                      ),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          LabeledRadio(
                            value: LearningOption.all,
                            groupValue: learningOption,
                            label: 'wszystko',
                            onChanged: (LearningOption? value) {
                              setState(() {
                                learningOption = value!;
                              });
                            },
                          ),
                          LabeledRadio(
                            value: LearningOption.custom,
                            groupValue: learningOption,
                            label: 'niestandardowo',
                            onChanged: (LearningOption? value) {
                              setState(() {
                                learningOption = value!;
                              });
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'cz????ci j??zyka',
                    textAlign: TextAlign.center,
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LabeledCheckbox(
                        onChanged: () {
                          setState(() {
                            wordOptionValue = !wordOptionValue;
                          });
                        },
                        isDisabled: learningOption == LearningOption.custom
                            ? false
                            : true,
                        label: 's??owa',
                        isChecked: wordOptionValue,
                      ),
                      LabeledCheckbox(
                        onChanged: () {
                          setState(() {
                            verbOptionValue = !verbOptionValue;
                          });
                        },
                        isDisabled: learningOption == LearningOption.custom
                            ? false
                            : true,
                        label: 'czasowniki',
                        isChecked: verbOptionValue,
                      ),
                      LabeledCheckbox(
                        onChanged: () {
                          setState(() {
                            phraseOptionValue = !phraseOptionValue;
                          });
                        },
                        isDisabled: learningOption == LearningOption.custom
                            ? false
                            : true,
                        label: 'frazy',
                        isChecked: phraseOptionValue,
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'kategorie',
                      textAlign: TextAlign.center,
                    ),
                    const Divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 10.0,
                          direction: Axis.horizontal,
                          children: buildCategoryChips(),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: onOptionsSubmitted,
                child: const Text('Rozpocznij nauk??'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
