import 'package:flutter/material.dart';
import 'package:language_learning/components/element_form.dart';
import 'package:language_learning/constants.dart' hide Language;
import 'package:language_learning/pages/language_management_page.dart';
import 'package:language_learning/database/database.dart';

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
            title: Text('Język ${widget.language.name}'),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    isScrollControlled: true,
                    context: context,
                    builder: (context) {
                      LanguageElement languageElement;
                      if (_tabController.index == 1) {
                        languageElement = LanguageElement.verb;
                      } else {
                        if (_tabController.index == 0) {
                          languageElement = LanguageElement.word;
                        } else {
                          languageElement = LanguageElement.phrase;
                        }
                      }
                      return ElementForm(
                          languageElement: languageElement,
                          language: widget.language);
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
              ),
              LanguageManagementPage(
                languageElement: LanguageElement.verb,
                language: widget.language,
              ),
              LanguageManagementPage(
                languageElement: LanguageElement.phrase,
                language: widget.language,
              ),
            ],
          ),
        );
      }),
    );
  }
}
