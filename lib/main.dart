import 'package:budget_app_prelimm/bloc/category_bloc/category_bloc.dart';
import 'package:budget_app_prelimm/bloc/cubit/bar_graph_cubit/bar_graph_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/current_amount_cubit/current_amount_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/dark_mode_cubit/dark_mode_cubit.dart';
import 'package:budget_app_prelimm/bloc/cubit/selected_range_cubit/selected_range_cubit.dart';
import 'package:budget_app_prelimm/bloc/item_bloc/item_bloc.dart';
import 'package:budget_app_prelimm/constants/apps_router.dart';
import 'package:budget_app_prelimm/screens/main_screen/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider<ItemBloc>(
          create: (context) => ItemBloc(),
        ),
        BlocProvider<CurrentAmountCubit>(
          create: (context) => CurrentAmountCubit(),
        ),
        BlocProvider<SelectedRangeCubit>(
          create: (context) => SelectedRangeCubit(),
        ),
        BlocProvider<BarGraphCubit>(
          create: (context) => BarGraphCubit(),
        ),
        BlocProvider<DarkModeCubit>(
          create: (context) => DarkModeCubit(),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainScreen(),
    );
  }
}
