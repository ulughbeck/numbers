import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:numbers/app_cn/presenters/number_notifier.dart';
import 'package:numbers/app_cn/ui/widgets.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberNotifier = Provider.of<NumberNotifier>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(title: const Text('Numbers')),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 50),

              /// dynamic text output according to state
              Consumer<NumberNotifier>(
                builder: (context, numberNotifier, child) {
                  switch (numberNotifier.state) {
                    case NumberState.initial:
                      return const NumberResultText(
                        title: 'Start searching!',
                        titleColor: Colors.orange,
                      );

                    case NumberState.loading:
                      return const CircularProgressIndicator();

                    case NumberState.loaded:
                      return NumberResultText(
                        title: (numberNotifier.numberModel?.number).toString(),
                        titleSize: 50,
                        titleColor: Colors.amberAccent,
                        subTitle: numberNotifier.numberModel?.text,
                        subTitleSize: 20,
                        subTitleColor: Colors.blueGrey,
                      );

                    case NumberState.error:
                      return NumberResultText(
                        title: numberNotifier.error ?? '',
                        titleColor: Colors.black,
                      );

                    //if unexpected state *should not occur idealy
                    default:
                      return const NumberResultText(
                        title: 'Unexpected error :(',
                        titleColor: Colors.black,
                      );
                  }
                },
              ),

              const SizedBox(height: 50),

              //input
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: numberNotifier.setNumberInput,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Input any Number',
                ),
              ),

              const SizedBox(height: 10),

              //buttons
              Row(
                children: <Widget>[
                  NumbersButton(
                    bgColor: Colors.red,
                    text: 'Search',
                    onTap: numberNotifier.searchNumber,
                  ),
                  const SizedBox(width: 16),
                  NumbersButton(
                    bgColor: Colors.blueGrey,
                    text: 'Random Number',
                    onTap: numberNotifier.randomNumber,
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
