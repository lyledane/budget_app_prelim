import 'package:budget_app_prelimm/screens/main_screen/widgets/settings_button.dart';
import 'package:flutter/material.dart';

class MainScreenHeader extends StatelessWidget {
  const MainScreenHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SettingsButton(settingsOnPressed: () {
          Scaffold.of(context).openDrawer();
        }),
      ],
    );
  }
}
