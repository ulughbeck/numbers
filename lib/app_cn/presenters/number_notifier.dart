import 'package:flutter/foundation.dart';
import 'package:numbers/app_cn/api/number_api.dart';
import 'package:numbers/app_cn/api/number_model.dart';

enum NumberState { initial, loading, loaded, error }

class NumberNotifier extends ChangeNotifier {
  final NumberApi _api = NumberApi();

  // State
  NumberState _state = NumberState.initial;
  NumberState get state => _state;
  void _setState(NumberState state) {
    _state = state;
    notifyListeners();
  }

  // input
  String _numberInput;
  setNumberInput(String value) {
    _numberInput = value;
  }

  // Number model
  NumberModel _numberModel;
  NumberModel get numberModel => _numberModel;

  // Error message
  NumberException _exception;
  String get error => _exception.message;

  // Actions

  /// search for number provided in input
  Future<void> searchNumber() {
    //validation of input
    if (_numberInput != null && _numberInput.length > 0)
      return _performSearch(_api.searchNumberAPI(number: _numberInput));

    return null;
  }

  /// search for random number
  Future<void> randomNumber() => _performSearch(_api.searchNumberAPI());

  /// runs provided api call function `searchFunction` and changes state of app according response
  Future<void> _performSearch(Future<NumberModel> searchFunction) async {
    try {
      //change state of page to loading
      _setState(NumberState.loading);

      //call provided function
      final result = await searchFunction;

      //if success result was received change state to successfull / loaded
      if (result is NumberModel) {
        //save result locally
        _numberModel = result;
        _setState(NumberState.loaded);
      }
    } on NumberException catch (e) {
      //save error result locally
      _exception = e;

      //if error / exception occured during call change state to error
      _setState(NumberState.error);
    }
  }
}
