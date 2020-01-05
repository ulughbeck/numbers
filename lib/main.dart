import 'package:flutter/material.dart';

import 'package:numbers/app_basic/app.dart';
import 'package:numbers/app_bloc/app.dart';
import 'package:numbers/app_cn/app.dart';

void main() {
  runApp(FlutterExamplesApp());
}

class FlutterExamplesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Numbers',
      home: FlutterExamplesPage(),
    );
  }
}

class FlutterExamplesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Example apps'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Basic App'),
              onPressed: () => _openExampleApp(context, BasicApp()),
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text('App with ChangeNotifier'),
              onPressed: () => _openExampleApp(context, CnApp()),
            ),
            SizedBox(height: 10),
            RaisedButton(
              child: Text('App with BLoC'),
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
