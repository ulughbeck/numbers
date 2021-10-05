import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

/// Final version with UI refactoring
class HomePage4 extends StatefulWidget {
  const HomePage4({Key? key}) : super(key: key);

  @override
  _HomePage4State createState() => _HomePage4State();
}

class _HomePage4State extends State<HomePage4> {
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
        _searchFuture = _searchNumberAPI(number: _controller?.text);
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
      resizeToAvoidBottomInset: false,
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
                      return NumbersResultText(
                        text: snapshot.data ?? '',
                        textSize: 25,
                        textColor: Colors.deepPurple,
                      );

                    // initial title
                    default:
                      return const NumbersResultText(
                        text: 'Start searching!',
                        textColor: Colors.deepOrange,
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
                  NumbersButton(
                    bgColor: Colors.blue,
                    text: 'Search',
                    onTap: _searchNumber,
                  ),
                  const SizedBox(width: 16),
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
  final String? text;
  final double? textSize;
  final Color? textColor;

  const NumbersResultText({
    Key? key,
    this.text,
    this.textSize = 30,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text ?? '',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: textSize,
        color: textColor,
      ),
    );
  }
}

class NumbersButton extends StatelessWidget {
  final Color? bgColor;
  final String? text;
  final VoidCallback? onTap;

  const NumbersButton({Key? key, this.bgColor, this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        child: Text(
          text ?? '',
          style: const TextStyle(color: Colors.white),
        ),
        style: ElevatedButton.styleFrom(primary: bgColor),
        onPressed: onTap,
      ),
    );
  }
}
