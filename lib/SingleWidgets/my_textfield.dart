import 'package:flutter/material.dart';

class NormalTextField extends StatelessWidget {
  const NormalTextField({
    Key? key,
    required Color myColor,
    required String text,
    required TextEditingController controller,
    required TextInputType keyboardType,
    required Icon icon,
  })  : _myColor = myColor,
        _myText = text,
        _myController = controller,
        _myKeyboardType = keyboardType,
        _myIcon = icon,
        super(key: key);

  final Color _myColor;
  final String _myText;
  final TextEditingController _myController;
  final TextInputType _myKeyboardType;
  final Icon _myIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _myController,
        keyboardType: _myKeyboardType,
        decoration: InputDecoration(
          prefixIcon: _myIcon,
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: _myColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: _myColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: _myColor,
            ),
          ),
          label: Text(_myText),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  const PasswordTextField({
    Key? key,
    required Color myColor,
    required String text,
    required TextEditingController controller,
  })  : _myColor = myColor,
        _myText = text,
        _myController = controller,
        super(key: key);

  final Color _myColor;
  final String _myText;
  final TextEditingController _myController;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  IconData _myIcon = Icons.visibility_off;

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: widget._myController,
        obscureText: _obscureText,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
                if (_myIcon == Icons.visibility) {
                  _myIcon = Icons.visibility_off;
                } else {
                  _myIcon = Icons.visibility;
                }
              });
            },
            icon: Icon(_myIcon),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: widget._myColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: widget._myColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: widget._myColor,
            ),
          ),
          label: Text(widget._myText),
        ),
      ),
    );
  }
}
