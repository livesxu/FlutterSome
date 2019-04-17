import 'package:flutter/material.dart';

class StepDemo extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StepDemoState();
  }
}

class StepDemoState extends State<StepDemo> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("StepDemo"),),
      body: StepDemoExample(),
    );;
  }
}

class StepDemoExample extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return StepDemoExampleState();
  }
}

class StepDemoExampleState extends State<StepDemoExample> {

  int _currentStep = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stepper(
        currentStep: _currentStep,
        onStepContinue: (){
          setState(() {
            _currentStep += 1;
          });
        },
        onStepCancel: (){
          setState(() {
            _currentStep -= 1;
          });
        },
        steps: [
          Step(title: Text("First"), content: Text("First Desc"),isActive: _currentStep == 0),
          Step(title: Text("Second"), content: Text("Second Desc"),isActive: _currentStep == 1),
          Step(title: Text("Third"), content: Text("Third Desc"),isActive: _currentStep == 2),
        ]
    );
  }
}