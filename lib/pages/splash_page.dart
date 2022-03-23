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
  Future<Tuple4<List<Word>, List<Verb>, List<Phrase>, List<Category>>>
      getLanguageElements() async {
    var words = await Provider.of<LanguageDatabase>(context, listen: false)
        .getAllWords();
    var verbs = await Provider.of<LanguageDatabase>(context, listen: false)
        .getAllVerbs();
    var phrases = await Provider.of<LanguageDatabase>(context, listen: false)
        .getAllPhrases();
    var categories = await Provider.of<LanguageDatabase>(context, listen: false)
        .getAllCategories();

    return Tuple4<List<Word>, List<Verb>, List<Phrase>, List<Category>>(
        words, verbs, phrases, categories);
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
