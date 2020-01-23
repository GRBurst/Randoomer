import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randoomer',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: GeneratorWidget(title: 'Random Number Generator'),
    );
  }
}

class GeneratorWidget extends StatefulWidget {
  GeneratorWidget({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Generator createState() => _Generator();
}

class _Generator extends State<GeneratorWidget> {
  var rng = new Random();
  int _result = 1;

  final lowerController = TextEditingController.fromValue(TextEditingValue(text: "1"));
  final upperController = TextEditingController.fromValue(TextEditingValue(text: "6"));

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    lowerController.dispose();
    upperController.dispose();
    super.dispose();
  }

  void _generate() {
    setState(() {
      int min = int.parse(lowerController.text);
      int max = int.parse(upperController.text);
      int range = max - min;
      _result = min + rng.nextInt( 1 + range);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Lower limit: ${lowerController.text}"),
            Text("Upper limit :${upperController.text}"),
            Text(
              'Result:',
            ),
            Text(
              '$_result',
              style: Theme.of(context).textTheme.display1,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter lowest number"),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              controller: lowerController,
            ),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Enter highest number"),
              inputFormatters: <TextInputFormatter>[
                WhitelistingTextInputFormatter.digitsOnly
              ], // Only numbers can be entered
              controller: upperController,
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _generate,
        tooltip: 'Generate',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
