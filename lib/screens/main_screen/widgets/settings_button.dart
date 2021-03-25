import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  final Function settingsOnPressed;

  const SettingsButton({
    Key key,
    @required this.settingsOnPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
        ),
        child: IconButton(
          onPressed: settingsOnPressed,
          icon: Icon(
            Icons.settings,
            size: 30,
          ),
        ),
      ),
    );
  }
}
