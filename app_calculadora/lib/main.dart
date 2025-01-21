import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculadora',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 207, 224, 188),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(title: 'Calculadora Simples'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _display = '0';
  double? _firstOperand;
  String? _operator;
  bool _isSecondOperand = false;

  void _inputNumber(String number) {
    setState(() {
      if (_display == '0' || _isSecondOperand) {
        _display = number;
        _isSecondOperand = false;
      } else {
        _display += number;
      }
    });
  }

  void _inputOperator(String operator) {
    setState(() {
      if (_firstOperand == null) {
        _firstOperand = double.tryParse(_display);
      } else if (_operator != null) {
        _calculate();
      }
      _operator = operator;
      _isSecondOperand = true;
    });
  }

  void _calculate() {
    if (_firstOperand != null && _operator != null) {
      double secondOperand = double.tryParse(_display) ?? 0;
      double result;

      switch (_operator) {
        case '+':
          result = _firstOperand! + secondOperand;
          break;
        case '-':
          result = _firstOperand! - secondOperand;
          break;
        case '*':
          result = _firstOperand! * secondOperand;
          break;
        case '/':
          result = secondOperand != 0 ? _firstOperand! / secondOperand : 0;
          break;
        default:
          return;
      }

      setState(() {
        _display = result.toString();
        _firstOperand = null;
        _operator = null;
      });
    }
  }

  void _clear() {
    setState(() {
      _display = '0';
      _firstOperand = null;
      _operator = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 99, 120, 61),
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(255, 207, 224, 188),
            width: double.infinity,
            child: const Text(
              'Layout Superior',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18),
            ),
          ),
          Expanded(
            child: Center(
              child: Container(
                width: 200, // Dimensões reduzidas da calculadora
                height: 300,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 207, 224, 188),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color.fromARGB(255, 99, 120, 61),
                    width: 4,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _display,
                      style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: GridView.count(
                        crossAxisCount: 4,
                        children: [
                          ...['7', '8', '9', '/'].map((value) => _buildButton(value)),
                          ...['4', '5', '6', '*'].map((value) => _buildButton(value)),
                          ...['1', '2', '3', '-'].map((value) => _buildButton(value)),
                          ...['C', '0', '=', '+'].map((value) => _buildButton(value)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color.fromARGB(255, 29, 54, 31),
            width: double.infinity,
            child: const Text(
              'Layout Inferior',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Botão Extra',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildButton(String value) {
    return GestureDetector(
      onTap: () {
        if (value == 'C') {
          _clear();
        } else if (value == '=') {
          _calculate();
        } else if ('+-*/'.contains(value)) {
          _inputOperator(value);
        } else {
          _inputNumber(value);
        }
      },
      child: Container(
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 99, 120, 61),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}