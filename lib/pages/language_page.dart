import 'package:flutter/material.dart';

import 'package:language_learning/constants.dart';
import 'package:language_learning/pages/language_management_page.dart';
import 'new_element_page.dart';

class LanguagePage extends StatefulWidget {
  final Language language;
  final List<String> specialCharacters;

  const LanguagePage(
      {Key? key, required this.language, this.specialCharacters = const []})
      : super(key: key);

  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              tabs: const [
                Tab(
                  child: Text('słowa'),
                ),
                Tab(
                  child: Text('czasowniki'),
                ),
                Tab(
                  child: Text('frazy'),
                ),
              ],
            ),
            title: Text('Język ${kLanguageNameTranslations[widget.language]}'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return NewElementPage(
                        languageElement:
                            LanguageElement.values[_tabController.index],
                        language: widget.language,
                        specialCharacters: widget.specialCharacters,
                      );
                    },
                  );
                },
              ),
            ],
          ),
          body: TabBarView(
            controller: _tabController,
            children: [
              LanguageManagementPage(
                languageElement: LanguageElement.word,
                language: widget.language,
                specialCharacters: widget.specialCharacters,
              ),
              LanguageManagementPage(
                languageElement: LanguageElement.verb,
                language: widget.language,
                specialCharacters: widget.specialCharacters,
              ),
              LanguageManagementPage(
                languageElement: LanguageElement.phrase,
                language: widget.language,
                specialCharacters: widget.specialCharacters,
              ),
            ],
          ),
        );
      }),
    );
  }
}
