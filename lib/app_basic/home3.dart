import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

///API repository and fucntion for button to search random number trivia

class HomePage3 extends StatefulWidget {
  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
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
                      return Text(
                        snapshot.data,
                        style: TextStyle(fontSize: 30),
                      );

                    // initial title
                    default:
                      return Text(
                        'Start searching!',
                        style: TextStyle(fontSize: 30),
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
                  Expanded(
                    child: RaisedButton(
                      child: Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.blue,
                      onPressed: _searchNumber,
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
                      onPressed: _randomNumber,
                    ),
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
