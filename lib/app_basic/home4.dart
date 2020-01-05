import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

/// Final version with UI refactoring
class HomePage4 extends StatefulWidget {
  @override
  _HomePage4State createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// API repository
  Future<String> _searchNumberAPI({String number}) async {
    //API endpoint
    const String API = 'http://numbersapi.com';

    try {
      String url;

      // compose request url to API and pass number if provided, otherwise request random
      if (number != null)
        url = '$API/$number';
      else
        url = '$API/random';

      final response = await http.get(url);

      if (response.statusCode == 200)
        // return response body
        return response.body;
      else
        // return error code
        return 'Ups, Network Error Code ${response.statusCode} :(';
    } catch (e) {
      // handle exceptions
      print(e);

      // custom exception text
      return 'Ups, Unexpected Error :(';
    }
  }

  /// instance of [Future] for [FutureBuilder]
  Future<String> _searchFuture;

  /// change `_searchFuture` [Future] with new API call using `setState` when there is value in [TextField]
  _searchNumber() {
    if (_controller.text.length > 0)
      setState(() {
        _searchFuture = _searchNumberAPI(number: _controller.text);
      });
  }

  /// change `_searchFuture` [Future] with new API call using `setState` for random number trivia
  _randomNumber() {
    setState(() {
      _searchFuture = _searchNumberAPI();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Numbers'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              SizedBox(height: 50),

              /// builds every time `_searchFuture` [Future] is changed by button click with `setState`
              FutureBuilder<String>(
                future: _searchFuture,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {

                    // when future has not finished
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return CircularProgressIndicator();

                    // when future has finished
                    case ConnectionState.done:
                      return NumbersResultText(
                        text: snapshot.data,
                        textSize: 25,
                        textColor: Colors.deepPurple,
                      );

                    // initial title
                    default:
                      return NumbersResultText(
                        text: 'Start searching!',
                        textColor: Colors.deepOrange,
                      );
                  }
                },
              ),

              SizedBox(height: 50),

              //input
              TextField(
                controller: _controller,
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

              //buttons
              Row(
                children: <Widget>[
                  NumbersButton(
                    bgColor: Colors.blue,
                    text: 'Search',
                    onTap: _searchNumber,
                  ),
                  SizedBox(width: 16),
                  NumbersButton(
                    bgColor: Colors.blueGrey,
                    text: 'Random Number',
                    onTap: _randomNumber,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NumbersResultText extends StatelessWidget {
  final String text;
  final double textSize;
  final Color textColor;

  const NumbersResultText({
    Key key,
    this.text,
    this.textSize = 30,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
      ),
    );
  }
}

class NumbersButton extends StatelessWidget {
  final Color bgColor;
  final String text;
  final VoidCallback onTap;

  const NumbersButton({Key key, this.bgColor, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RaisedButton(
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        color: bgColor,
        onPressed: onTap,
      ),
    );
  }
}
