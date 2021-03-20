import 'package:flutter/material.dart';

class CustomSubmitButton extends StatelessWidget {
  final Function onPressed;
  final Widget child;
  final Color color;

  const CustomSubmitButton({
    Key key,
    this.onPressed,
    this.child,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
        ),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
