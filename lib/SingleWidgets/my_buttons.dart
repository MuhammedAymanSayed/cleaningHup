import 'package:flutter/material.dart';

class MyOutlinedButton extends StatelessWidget {
  const MyOutlinedButton({
    Key? key,
    required String text,
    required Color color,
    required Function onpressed,
    required double fontsize,
  })  : _myColor = color,
        _myText = text,
        _myFunction = onpressed,
        _myFontSize = fontsize,
        super(key: key);

  final Color _myColor;
  final String _myText;
  final Function _myFunction;
  final double _myFontSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OutlinedButton(
        onPressed: () => _myFunction(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _myText,
            style: TextStyle(
              fontSize: _myFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          side: BorderSide(color: _myColor, width: 2),
          onPrimary: _myColor,
          primary: Colors.white,
        ),
      ),
    );
  }
}

class MyElevatedIcicatorButton extends StatelessWidget {
  const MyElevatedIcicatorButton({
    Key? key,
    required Color myColor,
    required String text,
    required Function onpressed,
    required bool pressed,
  })  : _myColor = myColor,
        _myText = text,
        _myFunction = onpressed,
        _pressed = pressed,
        super(key: key);

  final Color _myColor;
  final String _myText;
  final Function _myFunction;
  final bool _pressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => _myFunction(),
        child: _pressed
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: CircularProgressIndicator(
                              color: Colors.white,
                            ),
                          )
                        : Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            _myText,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: _myColor,
        ),
      ),
    );
  }
}
