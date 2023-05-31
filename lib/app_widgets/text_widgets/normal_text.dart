import 'package:flutter/material.dart';

class NormalText extends StatelessWidget {
  final String _text;
  final double _fontSize;
  const NormalText(this._text, this._fontSize);

  @override
  Widget build(BuildContext context) {
    return Text(
      _text,
      style: TextStyle(
        fontSize: _fontSize,
      ),
    );
  }
}
