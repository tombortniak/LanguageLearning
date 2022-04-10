import 'package:flutter/material.dart';
import 'package:language_learning/components/element_form.dart';
import 'package:language_learning/constants.dart' hide Language;
import 'package:language_learning/models/language_element_data.dart';
import 'package:language_learning/pages/language_management_page.dart';
import 'package:language_learning/database/database.dart';
import 'package:provider/provider.dart';

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
                icon: const Icon(Icons.category),
                onPressed: () {
                  var categories = context
                      .read<LanguageElementData>()
                      .getCategoriesBy(widget.language);
                  showModalBottomSheet(
                    shape: const RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.0)),
                    ),
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    'Kategorie',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.close_rounded,
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: categories.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                        title: Text(categories[index].name));
                                  }),
                            ),
                          ],
                        ),
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
