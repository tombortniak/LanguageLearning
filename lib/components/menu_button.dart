import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  String _text;
  void Function()? _onPressed;

  MenuButton({required text, required onPressed})
      : _text = text,
        _onPressed = onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _onPressed,
      child: Text(_text),
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.all(25.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
      ),
    );
  }
}
