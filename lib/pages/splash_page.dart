import 'package:flutter/material.dart';
import 'package:language_learning/models/language_element_data.dart';
import 'package:language_learning/pages/home_page.dart';
import 'package:tuple/tuple.dart';
import 'package:language_learning/database/database.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<
      Tuple5<List<Word>, List<Verb>, List<Phrase>, List<Category>,
          List<Language>>> getLanguageElements() async {
    var words = await context.read<LanguageDatabase>().getAllWords();
    var verbs = await context.read<LanguageDatabase>().getAllVerbs();
    var phrases = await context.read<LanguageDatabase>().getAllPhrases();
    var categories = await context.read<LanguageDatabase>().getAllCategories();
    var languages = await context.read<LanguageDatabase>().getLanguages();

    return Tuple5<List<Word>, List<Verb>, List<Phrase>, List<Category>,
        List<Language>>(words, verbs, phrases, categories, languages);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLanguageElements(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          Provider.of<LanguageElementData>(context, listen: false)
              .initalize(snapshot.data);
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomePage()));
          });
          return Container(
            color: Colors.deepPurple,
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Wystąpił błąd przy pobieraniu danych'),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
