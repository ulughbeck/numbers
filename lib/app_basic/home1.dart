import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

///This widget represents page with final UI elements of the numbers app
///
///It consists of [Text] for title, [TextField] for user input and 2 [RaisedButton]s for interaction

class HomePage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Numbers'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            SizedBox(height: 50),

            //number trivia
            Text(
              'Start searching!',
              style: TextStyle(fontSize: 30),
            ),

            SizedBox(height: 50),

            //input
            TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintText: 'Input any Number',
              ),
            ),

            SizedBox(height: 10),

            //buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    child: Text(
                      'Search',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () {
                      //todo
                    },
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    child: Text(
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
