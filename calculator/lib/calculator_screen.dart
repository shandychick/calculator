import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = '';
  String result = '0';

  void onButtonPressed(String value) {
    setState(() {
      if (value == '⌫') {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == '=') {
        try {
          result = evaluateExpression(input);
          history.add("${history.length + 1}. $input = $result");
        } catch (e) {
          result = 'Error';
        }
      } else {
        input += value;
      }
    });
  }

  String evaluateExpression(String expression) {
    try {
      Parser parser = Parser();
      Expression exp = parser.parse(expression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);
      return eval.toString();
    } catch (e) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 300,
            maxWidth: 400,
            minHeight: 500,
            maxHeight: 700,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.bottomRight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        input.isEmpty ? '0' : input,
                        style: const TextStyle(fontSize: 32, color: Colors.black54),
                      ),
                      Text(
                        result,
                        style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    childAspectRatio: 1.2,
                  ),
                  itemCount: buttons.length,
                  itemBuilder: (context, index) {
                    return ConstrainedBox(
                      constraints: const BoxConstraints(
                        minHeight: 40,
                        minWidth: 40,
                        maxHeight: 60,
                        maxWidth: 60,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          backgroundColor: _getButtonColor(buttons[index]),
                        ),
                        onPressed: () => onButtonPressed(buttons[index]),
                        child: buttons[index] == '⌫'
                            ? const Icon(Icons.backspace, size: 20, color: Colors.black)
                            : Text(
                                buttons[index],
                                style: TextStyle(
                                  fontSize: 20,
                                  color: buttons[index] == '=' ? Colors.white : Colors.black,
                                ),
                              ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getButtonColor(String button) {
    if (button == '=' || button == '⌫') {
      return Colors.orange;
    } else if (button == '/' || button == '*' || button == '+' || button == '-' || button == '%') {
      return Colors.blueGrey;
    }
    return Colors.grey[200]!;
  }
}

const List<String> buttons = [
  '7', '8', '9', '⌫',
  '4', '5', '6', '/',
  '1', '2', '3', '*',
  '-', '0', '+', '=',
];

List<String> history = [];
