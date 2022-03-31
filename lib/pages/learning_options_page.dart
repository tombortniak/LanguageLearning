import 'package:flutter/material.dart';
import 'package:language_learning/components/labeled_checkbox.dart';
import 'package:language_learning/components/labeled_radio.dart';
import 'package:language_learning/constants.dart' hide Language;
import 'package:language_learning/database/database.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';

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

  void updateCategories() {
    categories =
        context.read<LanguageElementData>().getCategoriesBy(selectedLanguage!);
    categoriesSelectedValues =
        List.generate(categories.length, (index) => false);
  }

  List<Widget> buildCategoryChips([String query = '']) {
    categoryChips = List.generate(
      categories.length,
      (index) => FilterChip(
        selected: categoriesSelectedValues[index],
        showCheckmark: true,
        label: Text(categories[index].name),
        onSelected: (bool value) {
          setState(() {
            categoriesSelectedValues[index] = value;
          });
        },
      ),
    );

    return categoryChips;
  }

  @override
  void initState() {
    super.initState();
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
          margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Język',
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              child: Divider(),
                            ),
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
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Elementy do nauki',
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              child: Divider(),
                            ),
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
                      ),
                    ]),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Części języka',
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: Divider(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        LabeledCheckbox(
                          isDisabled: learningOption == LearningOption.custom
                              ? false
                              : true,
                          label: 'słowa',
                          isChecked: wordOptionValue,
                        ),
                        LabeledCheckbox(
                          isDisabled: learningOption == LearningOption.custom
                              ? false
                              : true,
                          label: 'czasowniki',
                          isChecked: verbOptionValue,
                        ),
                        LabeledCheckbox(
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
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Kategorie',
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: Divider(),
                    ),
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
              ElevatedButton(onPressed: () {}, child: Text('Rozpocznij naukę'))
            ],
          ),
        ),
      ),
    );
  }
}
