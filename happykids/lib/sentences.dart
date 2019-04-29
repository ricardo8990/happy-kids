import 'dart:math';

import 'package:flutter/material.dart';

class SentenceBody {
  final title;
  final body;
  final image;
  final answer;

  SentenceBody(this.title, this.body, this.image, this.answer);
}

List<SentenceBody> sentences = [
  SentenceBody('El niño', 'Ese niño tiene el _ roto', 'brazo', 'brazo'),
  SentenceBody(
      'La escoba', 'La _ ha perdido su escoba en el bosque', 'bruja', 'bruja'),
  SentenceBody('El humo', 'El otro día la _ echaba un humo muy negro',
      'fabrica', 'fabrica'),
  SentenceBody('La biblioteca', 'En la biblioteca podemos encontrar muchos _',
      'libros', 'libros'),
  SentenceBody('El cartero', 'El cartero llevó el _ a casa de mi amiga',
      'sobre', 'sobre'),
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
    _steppers = List<Step>();
    sentences.shuffle();
    _sentences = sentences.sublist(0, 3);
    for(var sentence in _sentences){
      _steppers.add(_buildStep(sentence));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Happy Kids'),
      ),
      body: Container(
        height: 600.0,
        color: Colors.greenAccent,
        child: Stepper(
            currentStep: _index,
            onStepTapped: (index) {
              setState(() {
                _index = index;
              });
            },
            steps: _steppers),
      ),
    );
  }

  Step _buildStep(SentenceBody sentence) {
    return Step(
      title: Text(sentence.title, style: TextStyle(color: Colors.deepPurple),),
      content: Text(sentence.body),
    );
  }
}
