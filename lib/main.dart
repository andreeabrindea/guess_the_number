import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Guess my number',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Guess my number'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

Random random = new Random();

class _MyHomePageState extends State<MyHomePage> {
  int randomNumber = random.nextInt(100);
  String text = '';
  String tried = '';
  String message = '';


  void onPressed() {
    setState(() {
      text = controller.text;
      int number = int.parse(text);
      tried = 'You tried ' + text;
      if (number < randomNumber)
        message = "Try higher";
      if (number > randomNumber)
        message = 'Try lower';
      if (number == randomNumber) {
        _showDialog(context);

      }
    });
  }

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Text(
              "I'm thinking of a number between 1 and 100.",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const Text(
              "It's your turn to guess my number!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const Text("                        "),
            Text(
              tried,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            Text(
              message,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            Card(
                child: Column(
                  children: <Widget>[
                    ListTile(
                      title: const Text('Try a number!',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 25, color: Colors.grey)),
                      subtitle: TextField(
                          controller: controller,
                          keyboardType: TextInputType.number),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextButton(
                          child: const Text('Guess'),
                          onPressed: onPressed,
                        ),
                        const SizedBox(width: 30, height: 20)
                      ],
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("You guessed right"),
          content: new Text("It was "+text),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Try again"),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  controller.clear();
                  message = '';
                  tried = '';
                  randomNumber = random.nextInt(100);
                });

              },
            ),
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
