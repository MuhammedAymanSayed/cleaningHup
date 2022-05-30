import 'package:flutter/material.dart';

class MyCategoryWidget extends StatelessWidget {
  const MyCategoryWidget({
    Key? key,
    required Color myColor,
    required Widget child,
  })  : _myColor = myColor,
        _myWidget = child,
        super(key: key);

  final Color _myColor;
  final Widget _myWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 99,
      child: Center(child: _myWidget),
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: _myColor,
        borderRadius: BorderRadius.circular(25),
      ),
    );
  }
}
