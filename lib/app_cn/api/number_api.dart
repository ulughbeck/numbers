import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:numbers/app_cn/api/number_model.dart';

class NumberApi {
  /// API endpoint
  static const String api = 'http://numbersapi.com';

  /// API repository
  Future<NumberModel> searchNumberAPI({String? number}) async {
    try {
      String url;

      // compose request url to API and pass number if provided, otherwise request random
      if (number != null) {
        url = '$api/$number';
      } else {
        url = '$api/random';
      }

      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return NumberModel.fromJson(jsonDecode(response.body));
      } else {
        throw NumberException(
            'Ups, Network Error Code ${response.statusCode} :(');
      }
    } catch (e) {
      // handle unexpected exceptions
      print(e);

      throw NumberException('Ups, Unexpected Error :(');
    }
  }
}

class NumberException {
  final String message;

  NumberException(this.message);
}
