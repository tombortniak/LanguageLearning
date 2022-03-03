import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  String _text;
  Image _flag;

  LanguageCard({required text, required flag})
      : _text = text,
        _flag = flag;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _flag,
          Text(_text),
        ],
      ),
      padding: EdgeInsets.all(15.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
    );
  }
}
