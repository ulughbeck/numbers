import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

///The page is changed from Stateless to Statefull in order to dynamicly change title and output result from API call
///
///[TextEditingController] is added to control [TextField]
///
///[FutureBuilder] is used to dynamic change title in response to result of API call
///
///API repository and fucntion for button to search number trivia for number inputted in [TextField]

class HomePage2 extends StatefulWidget {
  @override
  _HomePage2State createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
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
      ),
    );
  }

  /// API repository
  Future<String> _searchNumberAPI(String number) async {
    //API endpoint
    const String API = 'http://numbersapi.com';

    try {
      // compose GET request to API and pass number provided
      final response = await http.get('$API/$number');

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
    if (_controller.text.length > 0) {
      setState(() {
        _searchFuture = _searchNumberAPI(_controller.text);
      });
    }
  }
}
