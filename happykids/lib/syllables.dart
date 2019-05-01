import 'package:flutter/material.dart';

class Syllable{
  final image;
  final options;
  final answer;
  final optionAnswers;
  int index;

  Syllable(this.image, this.options, this.answer, this.optionAnswers);
}

List<Syllable> syllables = [
  Syllable('','','',''),
  Syllable('','','',''),
  Syllable('','','',''),
  Syllable('','','',''),
  Syllable('','','','')
];

class Syllables extends StatefulWidget{
  @override
  _SyllablesState createState() => _SyllablesState();
}

class _SyllablesState extends State<Syllables> {
  int _index=0;

  List<Syllable> _syllables;
  List<Step> _steps;

  @override
  void initState() {
    syllables.shuffle();
    _syllables = syllables.sublist(0, 5);
    _steps = List<Step>();
    var _index = 0;
    for (var syllable in _syllables) {
      syllable.index = _index;
      _steps.add(_buildStep(syllable));
      _index++;
    }
    super.initState();
  }

  @override
  void setState(fn) {
    super.setState(fn);
    _steps = List<Step>();
    var _index = 0;
    for (var syllable in _syllables) {
      syllable.index = _index;
      _steps.add(_buildStep(syllable));
      _index++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Kids'),
      ),
      body: Container(
        color: Colors.greenAccent,
        height: 600.0,
        child: Center(
          child: Stepper(
            currentStep: _index,
            type: StepperType.horizontal,
              onStepTapped: (index) {
                setState(() {
                  _index = index;
                });
              },
              onStepContinue: (){
                setState(() {
                  _index +=1;
                });
              },
              onStepCancel: (){
                setState(() {
                  _index -= 1;
                });
              },
              controlsBuilder: (BuildContext context,
                  {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                return Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      _index == 0 ? Center() :
                      FlatButton.icon(
                        icon: Icon(Icons.arrow_back_ios),
                        label: const Text('REGRESAR'),
                        onPressed: onStepCancel,
                      ),
                      _index == 4
                          ? RaisedButton.icon(
                        icon: Icon(Icons.create, color: Colors.white,),
                        onPressed: () {},
                        label: Text('EVALUAR', style: TextStyle(color: Colors.white),),
                        color: Colors.deepPurple,
                      )
                          : RaisedButton.icon(
                        icon: Icon(Icons.arrow_forward_ios, color: Colors.white,),
                        onPressed: onStepContinue,
                        label: Text('SIGUIENTE', style: TextStyle(color: Colors.white),),
                        color: Colors.deepPurple,
                      ),
                    ],
                  ),
                );
              },
              steps: _steps),
        ),
      ),
    );
  }

  Step _buildStep(Syllable syllable) {
    return Step(
      title: Text(''),
      content: Card(
        child: Container(
          child: Center(
            child: Text('La prueba'),
          ),
        ),
      )
    );
  }
}
