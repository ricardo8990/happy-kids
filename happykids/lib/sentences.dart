import 'package:flutter/material.dart';
import 'package:happykids/syllables.dart';

class SentenceBody {
  final title;
  final body;
  final answer;
  String currentAnswer;
  int index;

  SentenceBody(this.title, this.body, this.answer);
}

List<SentenceBody> sentences = [
  SentenceBody('El niño', 'Ese niño tiene el 💪🏽_ roto', 'brazo'),
  SentenceBody(
      'La escoba', 'La 🧙‍♀_ ha perdido su escoba en el bosque', 'bruja'),
  SentenceBody(
      'El humo', 'El otro día la 🏭_ echaba un humo muy negro', 'fabrica'),
  SentenceBody('La biblioteca', 'En la biblioteca podemos encontrar muchos 📚_',
      'libros'),
  SentenceBody(
      'El cartero', 'El cartero llevó el 📩_ a casa de mi amiga', 'sobre'),
  SentenceBody('Ella', 'Mi 👱🏻‍♀ _ terminó sus estudios', 'hermana'),
  SentenceBody('Mar', 'En el mar se encuentra una 🧜🏼‍♀ _', 'sirena'),
  SentenceBody('Los alumnos', 'La 👩🏻‍🏫 _ enseña a sus alumnos', 'maestra'),
  SentenceBody('El baile', 'La 💃🏻 _ tendrá su presentación', 'bailarina'),
];

class Sentence extends StatefulWidget {
  @override
  _SentenceState createState() => _SentenceState();
}

class _SentenceState extends State<Sentence> {
  int _index = 0;
  List<SentenceBody> _sentences;
  List<Step> _steppers;

  @override
  void initState() {
    sentences.shuffle();
    _sentences = sentences.sublist(0, 5);
    _steppers = List<Step>();
    var _index = 0;
    for (var sentence in _sentences) {
      sentence.index = _index;
      _steppers.add(_buildStep(sentence));
      _index++;
    }
    super.initState();
  }

  @override
  void setState(fn) {
    super.setState(fn);
    _steppers = List<Step>();
    var _index = 0;
    for (var sentence in _sentences) {
      sentence.index = _index;
      _steppers.add(_buildStep(sentence));
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
        height: 600.0,
        child: Stepper(
          currentStep: _index,
          onStepTapped: (index) {
            setState(() {
              _index = index;
            });
          },
          steps: _steppers,
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
                          onPressed: () {evaluteResult();},
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
        ),
      ),
    );
  }

  Step _buildStep(SentenceBody sentence) {
    var _parts = sentence.body.split('_');
    StepState state;
    if(_index == sentence.index)
      state = StepState.editing;
    else if(sentence.currentAnswer == null)
      state = StepState.indexed;
    else if(sentence.currentAnswer.toLowerCase() == sentence.answer)
      state = StepState.complete;
    else
      state = StepState.error;
    return Step(
      title: Text(
        sentence.title,
        style: TextStyle(color: Colors.deepPurple),
      ),
      content: Container(
        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: <Widget>[
            Text(_parts[0]),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 2.0),
              width: 60.0,
              child: TextField(
                onChanged: (value) {
                  _sentences[sentence.index].currentAnswer = value;
                },
              ),
            ),
            Text(_parts[1])
          ],
        ),
      ),
      state: state
    );
  }

  evaluteResult() async {
    var isIncorrect = _sentences.any((x) => x.currentAnswer.toLowerCase() != x.answer);

    if (isIncorrect) {
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
                      'Completa todos los enunciados correctamente para poder continuar'),
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
                      MaterialPageRoute(builder: (context) => Syllables()));
                },
                child: const Text('Siguiente reto'),
              ),
            ],
          );
        });
  }

}
