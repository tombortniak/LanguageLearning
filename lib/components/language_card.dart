import 'package:flutter/material.dart';

class LanguageCard extends StatelessWidget {
  String text;
  Widget image;
  void Function()? onTap;

  LanguageCard({required this.image, required this.onTap, this.text = ''});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.0),
      child: Container(
        width: 160.0,
        height: 160.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            image,
            if (text != '')
              SizedBox(
                height: 15.0,
              ),
            if (text != '')
              Text(
                text,
                style: Theme.of(context).textTheme.bodyText1,
              ),
          ],
        ),
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(15.0)),
      ),
    );
  }
}
