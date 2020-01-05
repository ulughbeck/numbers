import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:numbers/app_basic/home1.dart';
import 'package:numbers/app_basic/home2.dart';
import 'package:numbers/app_basic/home3.dart';
import 'package:numbers/app_basic/home4.dart';

class BasicApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //* <HTML>
    return MaterialApp(
      title: 'Numbers',

      // step 1
      // home: HomePage1(),

      // step 2
      // home: HomePage2(),

      // step 3
      // home: HomePage3(),

      // step 4 - final
      home: HomePage4(),
    );
  }
}

// Starting point explaining hierarchy of widgets
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //* <BODY>
    return Scaffold(
      //* <HEADER>
      appBar: AppBar(
        title: Text('Numbers API'),
      ),
      //* <CONTENT>
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),

            //? number trivia
            Text(
              'Start searching!',
              style: TextStyle(fontSize: 30),
            ),

            SizedBox(height: 50),

            //? input
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: 'Input any Number',
              ),
            ),

            SizedBox(height: 10),

            //? buttons

            //1 button
            RaisedButton(
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
              onPressed: () {
                //todo
              },
            ),

            // 2 buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      //todo
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: RaisedButton(
                    child: Text(
                      'Random Number',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.blueGrey,
                    onPressed: () {
                      //todo
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
