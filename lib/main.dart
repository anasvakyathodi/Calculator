import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(Calculator());
}

class Calculator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Calculator By Anz",
      home: SimpleCalculator(),
    );
  }
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationFont = 48.0;
  double resultFont = 78.0;
  buttonPressed(buttonText) {
    if (buttonText == "C") {
      setState(() {
        equation = "0";
        result = "0";
        equationFont = 48.0;
        resultFont = 78.0;
      });
    } else if (buttonText == "◁") {
      if (equation == "" || equation == "0") {
        setState(() {
          equation = "0";
        });
      } else {
        setState(() {
          equation = equation.substring(0, equation.length - 1);
        });
      }
    } else if (buttonText == "=") {
      expression = equation;
      expression = expression.replaceAll("÷", "/");
      expression = expression.replaceAll("×", "*");
      expression = expression.replaceAll("−", "-");
      print(expression);
      try {
        Parser p = Parser();
        Expression exp = p.parse(expression);
        ContextModel cm = ContextModel();
        setState(() {
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        });
      } catch (e) {
        setState(() {
          result = "Error";
        });
      }
    } else {
      if (equation == "0") {
        setState(() {
          equation = buttonText;
        });
      } else {
        setState(() {
          equation = equation + buttonText;
        });
      }
    }
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      child: RaisedButton(
        color: buttonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0.0),
          side: BorderSide(
              color: Colors.black, width: 1, style: BorderStyle.solid),
        ),
        padding: EdgeInsets.all(16.0),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 0),
            child: Text(
              equation,
              style: TextStyle(fontSize: equationFont, color: Colors.white),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
            child: Text(
              result,
              style: TextStyle(fontSize: resultFont, color: Colors.white),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("C", 1.0, Colors.redAccent),
                      buildButton("◁", 1.0, Colors.deepPurple),
                      buildButton("÷", 1.0, Colors.deepOrangeAccent),
                    ]),
                    TableRow(children: [
                      buildButton("7", 1.0, Colors.black12),
                      buildButton("8", 1.0, Colors.black12),
                      buildButton("9", 1.0, Colors.black12),
                    ]),
                    TableRow(children: [
                      buildButton("4", 1.0, Colors.black12),
                      buildButton("5", 1.0, Colors.black12),
                      buildButton("6", 1.0, Colors.black12),
                    ]),
                    TableRow(children: [
                      buildButton("1", 1.0, Colors.black12),
                      buildButton("2", 1.0, Colors.black12),
                      buildButton("3", 1.0, Colors.black12),
                    ]),
                    TableRow(children: [
                      buildButton(".", 1.0, Colors.black12),
                      buildButton("0", 1.0, Colors.black12),
                      buildButton("00", 1.0, Colors.black12),
                    ]),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * .25,
                child: Table(
                  children: [
                    TableRow(children: [
                      buildButton("×", 1.0, Colors.deepOrangeAccent),
                    ]),
                    TableRow(children: [
                      buildButton("−", 1.0, Colors.deepOrangeAccent),
                    ]),
                    TableRow(children: [
                      buildButton("+", 1.0, Colors.deepOrangeAccent),
                    ]),
                    TableRow(children: [
                      buildButton("=", 2.0, Colors.deepOrangeAccent),
                    ]),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
