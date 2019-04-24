import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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

  @override
  void initState() {

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
            color: Colors.green,
            height: 360.0,
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10.0),
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
              crossAxisCount: 3,
              children: <Widget>[
                Container(
                  color: Colors.deepPurple,
                  child: Center(
                    child: const Text('b',
                        style: TextStyle(fontSize: 60.0, color: Colors.white)),
                  ),
                ),
                Container(
                  color: Colors.deepPurple,
                  child: Center(
                    child: const Text('p',
                        style: TextStyle(fontSize: 60.0, color: Colors.white)),
                  ),
                ),
                Container(
                  color: Colors.deepPurple,
                  child: Center(
                    child: const Text('b',
                        style: TextStyle(fontSize: 60.0, color: Colors.white)),
                  ),
                ),
                Container(
                  color: Colors.deepPurple,
                  child: Center(
                    child: const Text('p',
                        style: TextStyle(fontSize: 60.0, color: Colors.white)),
                  ),
                ),
                Container(
                  color: Colors.deepPurple,
                  child: Center(
                    child: const Text('b',
                        style: TextStyle(fontSize: 60.0, color: Colors.white)),
                  ),
                ),
                Container(
                  color: Colors.deepPurple,
                  child: Center(
                    child: const Text('p',
                        style: TextStyle(fontSize: 60.0, color: Colors.white)),
                  ),
                ),
                Container(
                  color: Colors.deepPurple,
                  child: Center(
                    child: const Text('p',
                        style: TextStyle(fontSize: 60.0, color: Colors.white)),
                  ),
                ),
                Container(
                  color: Colors.deepPurple,
                  child: Center(
                    child: const Text('p',
                        style: TextStyle(fontSize: 60.0, color: Colors.white)),
                  ),
                ),
                Container(
                  color: Colors.deepPurple,
                  child: Center(
                    child: const Text('b',
                        style: TextStyle(fontSize: 60.0, color: Colors.white)),
                  ),
                ),
              ],
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
                      'P ¿Cuantas hay?',
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
                        });
                      },
                      items: <int>[0, 1, 2, 3, 4, 5]
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
                      'B ¿Cuantas hay?',
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
                        });
                      },
                      items: <int>[0, 1, 2, 3, 4, 5]
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
}
