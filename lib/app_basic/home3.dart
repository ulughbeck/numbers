import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

///API repository and fucntion for button to search random number trivia

class HomePage3 extends StatefulWidget {
  const HomePage3({Key? key}) : super(key: key);

  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  /// API repository
  Future<String> _searchNumberAPI({String? number}) async {
    //API endpoint
    const String api = 'http://numbersapi.com';

    try {
      String url;

      // compose request url to API and pass number if provided, otherwise request random
      if (number != null) {
        url = '$api/$number';
      } else {
        url = '$api/random';
      }

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        return response.body;
      } else {
        return 'Ups, Network Error Code ${response.statusCode} :(';
      }
    } catch (e) {
      // handle exceptions
      print(e);

      // custom exception text
      return 'Ups, Unexpected Error :(';
    }
  }

  /// instance of [Future] for [FutureBuilder]
  Future<String>? _searchFuture;

  /// change `_searchFuture` [Future] with new API call using `setState` when there is value in [TextField]
  _searchNumber() {
    if ((_controller?.text ?? '').isNotEmpty) {
      setState(() {
        _searchFuture = _searchNumberAPI(number: _controller?.text ?? '');
      });
    }
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
        title: const Text('Numbers'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),

              /// builds every time `_searchFuture` [Future] is changed by button click with `setState`
              FutureBuilder<String>(
                future: _searchFuture,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    // when future has not finished
                    case ConnectionState.active:
                    case ConnectionState.waiting:
                      return const CircularProgressIndicator();

                    // when future has finished
                    case ConnectionState.done:
                      return Text(
                        snapshot.data ?? '',
                        style: const TextStyle(fontSize: 30),
                      );

                    // initial title
                    default:
                      return const Text(
                        'Start searching!',
                        style: TextStyle(fontSize: 30),
                      );
                  }
                },
              ),

              const SizedBox(height: 50),

              //input
              TextField(
                controller: _controller,
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

              //buttons
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      child: const Text(
                        'Search',
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.blue),
                      onPressed: _searchNumber,
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
