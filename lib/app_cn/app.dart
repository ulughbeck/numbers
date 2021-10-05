import 'package:flutter/material.dart';
import 'package:numbers/app_cn/presenters/number_notifier.dart';
import 'package:numbers/app_cn/ui/home.dart';
import 'package:provider/provider.dart';

class CnApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NumberNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.red),
        title: 'Numbers',
        home: HomePage(),
      ),
    );
  }
}
