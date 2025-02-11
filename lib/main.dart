import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData.dark(),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = "";
  String _output = "";
  double? num1;
  double? num2;
  String operand = "";
  bool isResultDisplayed = false;

  void buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        if (_input.isNotEmpty) {
          _input = _input.substring(0, _input.length - 1);
          _output = _input;
        } else {
          _input = "";
          _output = "";
          num1 = null;
          num2 = null;
          operand = "";
          isResultDisplayed = false;
        }
      } else if (buttonText == "=") {
        if (num1 != null && operand.isNotEmpty && _input.isNotEmpty) {
          num2 = double.tryParse(_input);
          if (num2 != null) {
            if (operand == "+") {
              _output = (num1! + num2!).toString();
            } else if (operand == "-") {
              _output = (num1! - num2!).toString();
            } else if (operand == "×") {
              _output = (num1! * num2!).toString();
            } else if (operand == "÷" && num2 != 0) {
              _output = (num1! / num2!).toString();
            } else {
              _output = "Error";
            }
            _input = "$num1 $operand $num2 = $_output";
            num1 = null;
            num2 = null;
            operand = "";
            isResultDisplayed = true;
          }
        }
      } else if (["+", "-", "×", "÷"].contains(buttonText)) {
        if (_input.isNotEmpty) {
          num1 = double.tryParse(_input);
          if (num1 != null) {
            operand = buttonText;
            _input = "";
            isResultDisplayed = false;
          }
        }
      } else {
        if (isResultDisplayed) {
          _input = buttonText;
          _output = _input;
          isResultDisplayed = false;
        } else {
          _input += buttonText;
          _output = _input;
        }
      }
    });
  }

  Widget buildButton(String text, {Color? color, VoidCallback? onLongPress}) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(5),
        child: ElevatedButton(
          onPressed: () => buttonPressed(text),
          onLongPress: text == "C"
              ? () => setState(() {
                  _input = "";
                  _output = "";
                  num1 = null;
                  num2 = null;
                  operand = "";
                  isResultDisplayed = false;
                })
              : null,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(24),
            backgroundColor: color ?? Colors.grey[800],
          ),
          child: Text(text, style: const TextStyle(fontSize: 24)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator")),
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(_input, style: const TextStyle(fontSize: 24, color: Colors.grey)),
                  Text(_output, style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Row(children: [
                buildButton("7"), buildButton("8"), buildButton("9"), buildButton("÷", color: Colors.orange),
              ]),
              Row(children: [
                buildButton("4"), buildButton("5"), buildButton("6"), buildButton("×", color: Colors.orange),
              ]),
              Row(children: [
                buildButton("1"), buildButton("2"), buildButton("3"), buildButton("-", color: Colors.orange),
              ]),
              Row(children: [
                buildButton("C", color: Colors.red, onLongPress: () => buttonPressed("C")), buildButton("0"), buildButton("=", color: Colors.green), buildButton("+", color: Colors.orange),
              ]),
            ],
          ),
        ],
      ),
    );
  }
}
