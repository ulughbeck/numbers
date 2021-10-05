import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:numbers/app_basic/home1.dart';
import 'package:numbers/app_basic/home2.dart';
import 'package:numbers/app_basic/home3.dart';
import 'package:numbers/app_basic/home4.dart';

class BasicApp extends StatelessWidget {
  const BasicApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //* <HTML>
    return MaterialApp(
      debugShowCheckedModeBanner: false,
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
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //* <BODY>
    return Scaffold(
      //* <HEADER>
      appBar: AppBar(
        title: const Text('Numbers API'),
      ),
      //* <CONTENT>
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 50),

            //? number trivia
            const Text(
              'Start searching!',
              style: TextStyle(fontSize: 30),
            ),

            const SizedBox(height: 50),

            //? input
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: 'Input any Number',
              ),
            ),

            const SizedBox(height: 10),

            //? buttons

            //1 button
            ElevatedButton(
              child: const Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                //todo
              },
            ),

            // 2 buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    child: const Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      //todo
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: const Text(
                      'Random Number',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
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
