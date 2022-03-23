import 'package:flutter/material.dart';
import 'package:language_learning/components/labeled_checkbox.dart';
import 'package:language_learning/components/labeled_radio.dart';
import 'package:language_learning/constants.dart';
import 'package:language_learning/database/database.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:provider/provider.dart';

class LearningOptionsPage extends StatefulWidget {
  const LearningOptionsPage({Key? key}) : super(key: key);

  @override
  State<LearningOptionsPage> createState() => _LearningOptionsPageState();
}

class _LearningOptionsPageState extends State<LearningOptionsPage> {
  LearningOption _learningOption = LearningOption.all;
  bool wordOptionValue = false;
  bool verbOptionValue = false;
  bool phraseOptionValue = false;
  List<bool> categoriesSelectedValues = [];
  List<FilterChip> categoryChips = [];
  TextEditingController searchTextController = TextEditingController();

  void buildCategoryChips([String query = '']) {
    List<Category> categories = [];
    if (query.isNotEmpty) {
      categories = context.read<LanguageElementData>().filterCategories(query);
    } else {
      categories = context.read<LanguageElementData>().getCategories();
    }
    categoriesSelectedValues =
        List.generate(categories.length, (index) => false);
    categoryChips = List.generate(
      categories.length,
      (index) => FilterChip(
        label: Text(categories[index].name),
        onSelected: (value) {
          categoriesSelectedValues[index] = value;
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    buildCategoryChips();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        child: Column(
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
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
                          groupValue: _learningOption,
                          label: 'wszystko',
                          onChanged: (LearningOption? value) {
                            setState(() {
                              _learningOption = value!;
                            });
                          },
                        ),
                        LabeledRadio(
                          value: LearningOption.custom,
                          groupValue: _learningOption,
                          label: 'niestandardowo',
                          onChanged: (LearningOption? value) {
                            setState(() {
                              _learningOption = value!;
                            });
                          },
                        )
                      ],
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
                        isDisabled: _learningOption == LearningOption.custom
                            ? false
                            : true,
                        label: 'słowa',
                        isChecked: wordOptionValue,
                      ),
                      LabeledCheckbox(
                        isDisabled: _learningOption == LearningOption.custom
                            ? false
                            : true,
                        label: 'czasowniki',
                        isChecked: verbOptionValue,
                      ),
                      LabeledCheckbox(
                        isDisabled: _learningOption == LearningOption.custom
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
                  TextField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.deepPurple),
                          borderRadius: BorderRadius.circular(20.0)),
                      hintText: 'Szukaj',
                      hintStyle: Theme.of(context)
                          .textTheme
                          .bodyText2
                          ?.copyWith(color: Colors.grey, fontSize: 14.0),
                      prefixIcon: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20.0),
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // viewCategories = context
                        //     .read<LanguageElementData>()
                        //     .filterCategories(value);
                        buildCategoryChips(value);
                      });
                    },
                    onEditingComplete: () {},
                    controller: searchTextController,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Wrap(
                        spacing: 10.0,
                        direction: Axis.horizontal,
                        children: categoryChips,
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
