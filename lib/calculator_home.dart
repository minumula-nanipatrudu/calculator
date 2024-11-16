import 'package:flutter/material.dart';

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() {
    return _calculatorHome();
  }
}

// ignore: camel_case_types
class _calculatorHome extends State<CalculatorHome> {
  String input = '';
  String operand = '';
  String output = '';
  double firstNum = 0;

  void _onNumberPressed(String num) {
    setState(() {
      input += num;
      // print(input);
    });
  }

  void _onOperatorPressed(String op) {
    setState(() {
      if (input.isNotEmpty) {
        firstNum = double.parse(input);
        input = '';
        operand = op;
      }
    });
  }

  void _onEqualsPressed(String val) {
    if (input.isNotEmpty && operand.isNotEmpty) {
      double secondNum = double.parse(input);
      double result = 0;

      switch (operand) {
        case '+':
          result = firstNum + secondNum;
          break;
        case '-':
          result = firstNum - secondNum;
          break;
        case 'x':
          result = firstNum * secondNum;
          break;
        case '/':
          if (secondNum != 0) {
            result = firstNum / secondNum;
          } else {
            output = 'Error'; //Handle division by Zero
            return;
          }
          break;
        default:
          return;
      }
      setState(() {
        output = result.toString();
        input = '';
        operand = '';
      });
    }
  }

  void _onClearPressed(String val) {
    setState(() {
      input = ''; // Clear the input field
      output = ''; // Clear the result field
      operand = ''; // Clear the operator
      firstNum = 0; // Reset the first number
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Calculator",
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: TextField(
                        readOnly: true,
                        decoration: const InputDecoration(
                          hintStyle: TextStyle(
                            fontSize: 30,
                          ),
                          hintText: '',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: TextEditingController(
                            text: input.isEmpty ? output : input),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Buttons(
                      'AC', Colors.white, Colors.orangeAccent, _onClearPressed),
                  Buttons('%', Colors.white, Colors.black, _onOperatorPressed),
                  Buttons('Del', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('/', Colors.white, Colors.black, _onOperatorPressed),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Buttons('7', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('8', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('9', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('x', Colors.white, Colors.black, _onOperatorPressed),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Buttons('4', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('5', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('6', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('-', Colors.white, Colors.black, _onOperatorPressed),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Buttons('1', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('2', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('3', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('+', Colors.white, Colors.black, _onOperatorPressed),
                ],
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Buttons('00', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('0', Colors.white, Colors.black, _onNumberPressed),
                  Buttons('.', Colors.white, Colors.black, _onNumberPressed),
                  Buttons(
                      '=', Colors.white, Colors.orangeAccent, _onEqualsPressed),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Buttons(
      String name, Color btn, Color textColor, Function(String) onPressed) {
    return TextButton(
      onPressed: () {
        onPressed(name);
      },
      style: (TextButton.styleFrom(
        foregroundColor: btn,
        backgroundColor: textColor,
        shape: const CircleBorder(),
      )),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          name,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
