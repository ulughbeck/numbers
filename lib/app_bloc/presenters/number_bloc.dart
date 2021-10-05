import 'dart:async';

import 'package:numbers/app_bloc/api/number_api.dart';
import 'package:numbers/app_bloc/api/number_model.dart';

/// Number Bloc
class NumberBloc {
  final NumberApi _api = NumberApi();

  // State
  final _state = StreamController<NumberState>();

  Stream<NumberState> get state => _state.stream;

  void _setState(NumberState state) {
    _state.sink.add(state);
  }

  /// returns initial state of page
  NumberState get initialState =>
      NumberInitialState(message: 'Start searching!');

  // input
  String? _numberInput;

  setNumberInput(String value) {
    _numberInput = value;
  }

  // Actions

  /// search for number provided in input
  Future<void>? searchNumber() {
    //validation of input
    if (_numberInput != null && _numberInput!.isNotEmpty) {
      return _performSearch(_api.searchNumberAPI(number: _numberInput ?? ''));
    }

    return null;
  }

  /// search for random number
  Future<void> randomNumber() => _performSearch(_api.searchNumberAPI());

  ///runs provided api call function `searchFunction` and changes state of app according response
  Future<void> _performSearch(Future<NumberModel> searchFunction) async {
    try {
      //change state of page to loading
      _setState(NumberLoadingState());

      //call provided function
      final result = await searchFunction;

      //if success result was received change state to successfull / loaded
      if (result is NumberModel) {
        _setState(NumberLoadedState(numberModel: result));
      }
    } on NumberException catch (e) {
      //if error / exception occured during call change state to error
      _setState(NumberErrorState(errorMessage: e.message));
    }
  }

  dispose() {
    //close stream
    _state.close();
  }
}

/// Page State
class NumberState {}

class NumberInitialState extends NumberState {
  final String? message;

  NumberInitialState({this.message});
}

class NumberLoadingState extends NumberState {}

class NumberLoadedState extends NumberState {
  final NumberModel? numberModel;

  NumberLoadedState({this.numberModel});
}

class NumberErrorState extends NumberState {
  final String? errorMessage;

  NumberErrorState({this.errorMessage});
}
