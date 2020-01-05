import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numbers/app_bloc/presenters/number_bloc.dart';
import 'package:numbers/app_bloc/ui/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<NumberBloc>(context);

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

              // dynamic text output according to state
              StreamBuilder<NumberState>(
                stream: bloc.state,
                initialData: bloc.initialState,
                builder: (context, stateSstream) {
                  final state = stateSstream.data;

                  if (state is NumberInitialState) {
                    return NumberResultText(
                      title: state.message,
                      titleColor: Colors.blue,
                    );
                  } else if (state is NumberLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is NumberLoadedState) {
                    return NumberResultText(
                      title: state.numberModel.number.toString(),
                      titleSize: 50,
                      titleColor: Colors.cyan,
                      subTitle: state.numberModel.text,
                      subTitleSize: 20,
                      subTitleColor: Colors.blueGrey,
                    );
                  } else if (state is NumberErrorState) {
                    return NumberResultText(
                      title: state.errorMessage,
                      titleColor: Colors.red,
                    );
                  } else {
                    //if unexpected state *should not occur idealy
                    return NumberResultText(
                      title: 'Unexpected error :(',
                      titleColor: Colors.red,
                    );
                  }
                },
              ),

              SizedBox(height: 50),

              //input
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                onChanged: bloc.setNumberInput,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input any Number',
                ),
              ),

              SizedBox(height: 10),

              //buttons
              Row(
                children: <Widget>[
                  NumbersButton(
                    bgColor: Colors.amber,
                    text: 'Search',
                    onTap: bloc.searchNumber,
                  ),
                  SizedBox(width: 16),
                  NumbersButton(
                    bgColor: Colors.deepOrange,
                    text: 'Random Number',
                    onTap: bloc.randomNumber,
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
