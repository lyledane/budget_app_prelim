import 'package:budget_app_prelimm/bloc/cubit/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:budget_app_prelimm/constants/apps_router.dart';
import 'package:budget_app_prelimm/constants/style.dart';
import 'package:budget_app_prelimm/screens/main_screen/widgets/bar_graph_section.dart';
import 'package:budget_app_prelimm/screens/main_screen/widgets/category_list.dart';
import 'package:budget_app_prelimm/screens/main_screen/widgets/main_screen_header.dart';
import 'package:budget_app_prelimm/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  DatabaseService _databaseService = DatabaseService();
  Color color = kColorViolet1;
  bool darkMode = false;

  @override
  void initState() {
    _databaseService.initializeDB().then((value) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DarkModeCubit, DarkModeState>(
      builder: (context, state) {
        String status = 'Off';
        IconData icon = Icons.brightness_5;

        if (state is DarkModeSuccess) {
          darkMode = state.isDarkModeEnabled;
          status = darkMode == true ? 'On' : 'Off';
          icon = darkMode == true ? Icons.brightness_4 : Icons.brightness_5;
          color = darkMode == true ? kColorDarkModeBG : kColorViolet1;
        }

        return Scaffold(
          backgroundColor: kColorTransparent,
          endDrawerEnableOpenDragGesture: false,
          drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: darkMode == true ? kColorDarkModeSurface : null,
            ),
            child: Drawer(
              child: BlocBuilder<DarkModeCubit, DarkModeState>(
                builder: (context, state) {
                  return ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[
                      Material(
                        color: color,
                        elevation: 10.0,
                        child: DrawerHeader(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.settings,
                                size: 32,
                                color: kColorWhite,
                              ),
                              SizedBox(width: 10),
                              Text('Settings', style: ktitleHeader),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        leading: Icon(
                          icon,
                          color: darkMode == true ? kColorWhite : kColorViolet1,
                        ),
                        title: Text(
                          'Dark Mode ($status)',
                          style: TextStyle(
                            color: darkMode == true ? kColorWhite : kColorBlack,
                          ),
                        ),
                        onTap: () {
                          //Exexute dark mode
                          BlocProvider.of<DarkModeCubit>(context)
                              .toggleDarkMode(darkMode);

                          Navigator.pop(context);
                        },
                      ),
                      ListTile(
                        leading: Icon(
                          Icons.info_outline_rounded,
                          color: darkMode == true ? kColorWhite : kColorViolet1,
                        ),
                        title: Text(
                          'About Budget App',
                          style: TextStyle(
                            color: darkMode == true ? kColorWhite : kColorBlack,
                          ),
                        ),
                        onTap: () {
                          Navigator.pop(context);

                          showAboutDialog(
                            context: context,
                            applicationVersion: '1.0',
                            children: [
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Developed by: John Doe'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Section: BSIT 1-1'),
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('Submitted to: John Mike'),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          body: SafeArea(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: darkMode == true
                      ? [kColorDarkModeBG, kColorDarkModeBG, kColorDarkModeBG]
                      : [kColorViolet1, kColorViolet1, kColorViolet2],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 27.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MainScreenHeader(databaseService: _databaseService),
                        SizedBox(height: 15),
                        Text('Budget App', style: ktitleHeader),
                        SizedBox(height: 17),
                        BarGraphSection(databaseService: _databaseService),
                      ],
                    ),
                  ),
                  CategoryList(databaseService: _databaseService),
                ],
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: darkMode == true ? kColorTeal : kColorViolet1,
            onPressed: () {
              Navigator.pushNamed(context, AppRouter.calendarScreen);
            },
            child: Icon(
              Icons.calendar_today,
              color: darkMode == true ? kColorBlack : kColorWhite,
            ),
          ),
        );
      },
    );
  }
}
