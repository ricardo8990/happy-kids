import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:happykids/sentences.dart';

const List<Map<String, String>> OPTIONS = [
  {'first': 'b', 'second': 'p'},
  {'first': 'a', 'second': 'c'},
  {'first': 'm', 'second': 'n'}
];

void main() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Happy Kids',
      theme: ThemeData(
        fontFamily: 'Indie Flower',
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Happy Kids'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int firstLetterCount = 0;
  int secondLetterCount = 0;
  String firstLetter;
  String secondLetter;
  int firstCorrectCount;
  int secondCorrectCount;
  List<CustomBlock> blocs;

  @override
  void initState() {
    final _random = Random();
    var constant = OPTIONS[_random.nextInt(OPTIONS.length)];
    firstLetter = constant['first'];
    secondLetter = constant['second'];
    firstCorrectCount = _random.nextInt(7) + 1;
    secondCorrectCount = 9 - firstCorrectCount;
    var positions = List<int>.generate(9, (i) => i);
    positions.shuffle();
    positions = positions.sublist(0, firstCorrectCount);
    blocs = List<CustomBlock>();
    for (var i = 0; i <= 8; i++) {
      if (positions.contains(i)) {
        blocs.add(CustomBlock(
          letter: firstLetter,
          alternativeColor: Colors.redAccent,
        ));
      } else {
        blocs.add(CustomBlock(
          letter: secondLetter,
          alternativeColor: Colors.blueAccent,
        ));
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            color: Colors.greenAccent,
            height: 360.0,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10.0),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 3,
              children: blocs,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${firstLetter.toUpperCase()} ¿Cuantas hay?',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                    ),
                    DropdownButton<int>(
                      value: firstLetterCount,
                      onChanged: (int newValue) {
                        setState(() {
                          firstLetterCount = newValue;
                          evaluteResult();
                        });
                      },
                      items: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString(),
                              style: TextStyle(fontSize: 30.0)),
                        );
                      }).toList(),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '${secondLetter.toUpperCase()} ¿Cuantas hay?',
                      style: TextStyle(fontSize: 30.0),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                    ),
                    DropdownButton<int>(
                      value: secondLetterCount,
                      onChanged: (int newValue) {
                        setState(() {
                          secondLetterCount = newValue;
                          evaluteResult();
                        });
                      },
                      items: <int>[0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
                          .map<DropdownMenuItem<int>>((int value) {
                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(value.toString(),
                              style: TextStyle(fontSize: 30.0)),
                        );
                      }).toList(),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  evaluteResult() async {
    if (firstLetterCount <= 0 || secondLetterCount <= 0) return;

    if (firstLetterCount != firstCorrectCount) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¡Ups!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Ese no es el número correcto de ${firstLetter.toUpperCase()}'),
                  Text('Intenta de nuevo'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    if (secondLetterCount != secondCorrectCount) {
      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¡Ups!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Ese no es el número correcto de ${secondLetter.toUpperCase()}'),
                  Text('Intenta de nuevo'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('¡Genial!'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Salir'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Sentence()));
                },
                child: const Text('Siguiente reto'),
              ),
            ],
          );
        });
  }
}

class CustomBlock extends StatefulWidget {
  final String letter;
  final Color alternativeColor;

  const CustomBlock({this.letter, this.alternativeColor});

  @override
  _CustomBlockState createState() => _CustomBlockState();
}

class _CustomBlockState extends State<CustomBlock> {
  Color color;

  @override
  void initState() {
    color = Colors.deepPurple;
    super.initState();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () {
          setState(() {
            color = widget.alternativeColor;
          });
        },
        child: Container(
          color: color,
          child: Center(
            child: Center(
                child: Text(
              widget.letter,
              style: TextStyle(fontSize: 60.0, color: Colors.white),
            )),
          ),
        ),
      );
}
