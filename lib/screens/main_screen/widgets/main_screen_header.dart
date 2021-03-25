import 'package:budget_app_prelimm/bloc/cubit/selected_range_cubit/selected_range_cubit.dart';
import 'package:budget_app_prelimm/constants/apps_router.dart';
import 'package:budget_app_prelimm/global_widgets/add_button.dart';
import 'package:budget_app_prelimm/screens/main_screen/widgets/settings_button.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreenHeader extends StatelessWidget {
  final DatabaseService databaseService;

  const MainScreenHeader({
    Key key,
    this.databaseService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SettingsButton(settingsOnPressed: () {
          Scaffold.of(context).openDrawer();
        }),
        BlocBuilder<SelectedRangeCubit, SelectedRangeState>(
          builder: (context, state) {
            Widget _widget = AddButton(
              addOnPressed: () {
                Navigator.pushNamed(
                  context,
                  AppRouter.addEditCategorySCreen,
                  arguments: {
                    'databaseService': databaseService,
                    'isEdit': false,
                  },
                );
              },
            );

            if (state is SelectedRangeInitial) {
              _widget = SizedBox.shrink();
            }

            return _widget;
          },
        ),
      ],
    );
  }
}
