import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String display = '0';
  String operand = '';
  double result = 0;
  double prevValue = 0;
  bool isOperatorClicked = false;

  void handleButtonClick(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        display = '0';
        operand = '';
        result = 0;
        prevValue = 0;
        isOperatorClicked = false;
      } else if (buttonText == '=') {
        if (operand.isNotEmpty) {
          double value = double.parse(display);
          switch (operand) {
            case '+':
              result = prevValue + value;
              break;
            case '-':
              result = prevValue - value;
              break;
            case '*':
              result = prevValue * value;
              break;
            case '/':
              result = prevValue / value;
              break;
          }
          display = result.toString();
          operand = '';
          prevValue = 0;
          isOperatorClicked = false;
        }
      } else if (buttonText == '+' || buttonText == '-' || buttonText == '*' || buttonText == '/') {
        if (!isOperatorClicked) {
          prevValue = double.parse(display);
          operand = buttonText;
          display = '0';
          isOperatorClicked = true;
        }
      } else {
        if (display == '0' || isOperatorClicked) {
          display = buttonText;
          isOperatorClicked = false;
        } else {
          display += buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.purple[300],
              padding: EdgeInsets.all(16.0),
              alignment: Alignment.centerRight,
              child: Text(
                display,
                style: TextStyle(fontSize: 32.0),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: Container(
              color: Colors.grey[200],
              child: Column(
                children: <Widget>[
                  buildButtonRow(['7', '8', '9', '/']),
                  buildButtonRow(['4', '5', '6', '*']),
                  buildButtonRow(['1', '2', '3', '-']),
                  buildButtonRow(['C', '0', '=', '+']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButtonRow(List<String> buttons) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: buttons.map((buttonText) {
          return Expanded(
            child: TextButton(
              onPressed: () => handleButtonClick(buttonText),
              child: Text(
                buttonText,
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
