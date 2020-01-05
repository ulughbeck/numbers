import 'package:flutter/material.dart';
import 'package:numbers/app_bloc/presenters/number_bloc.dart';
import 'package:numbers/app_bloc/ui/home.dart';
import 'package:provider/provider.dart';

class BlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => NumberBloc(),
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.orange),
        title: 'Numbers',
        home: HomePage(),
      ),
    );
  }
}
