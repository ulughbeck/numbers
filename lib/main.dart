import 'package:flutter/material.dart';

import 'package:numbers/app_basic/app.dart';
import 'package:numbers/app_bloc/app.dart';
import 'package:numbers/app_cn/app.dart';

void main() => runApp(const FlutterExamplesApp());

class FlutterExamplesApp extends StatelessWidget {
  const FlutterExamplesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Numbers',
      home: FlutterExamplesPage(),
    );
  }
}

class FlutterExamplesPage extends StatelessWidget {
  const FlutterExamplesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Example apps'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Basic App'),
              onPressed: () => _openExampleApp(context, BasicApp()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('App with ChangeNotifier'),
              onPressed: () => _openExampleApp(context, CnApp()),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              child: const Text('App with BLoC'),
              onPressed: () => _openExampleApp(context, BlocApp()),
            ),
          ],
        ),
      ),
    );
  }

  _openExampleApp(BuildContext context, Widget app) {
    return Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => app),
    );
  }
}
