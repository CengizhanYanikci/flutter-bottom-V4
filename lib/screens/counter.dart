import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int counter = 0;
  double fontSize = 48;

  void incrementFontSize() {
    setState(() {
      if (fontSize >= 300) {
      } else {
        fontSize += 12;
      }
    });
  }

  void decrementFontSize() {
    setState(() {
      if (fontSize <= 12) {
      } else {
        fontSize -= 12;
      }
    });
  }

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  void resetCounter() {
    setState(() {
      counter = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.black;
    if (counter > 0) {
      textColor = Colors.green;
    } else if (counter < 0) {
      textColor = Colors.red;
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Counter',
          style: TextStyle(fontSize: 24),
        ),
        Text(
          '$counter',
          style: TextStyle(
            fontSize: fontSize,
            color: textColor,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: incrementCounter,
              child: const Icon(Icons.plus_one),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 176, 225, 177)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(color: Colors.white),
                )),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: decrementCounter,
              child: const Icon(Icons.exposure_minus_1),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 228, 169, 165)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              onPressed: resetCounter,
              child: const Icon(Icons.refresh),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 96, 95, 95)),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: const BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.text_increase),
              onPressed: incrementFontSize,
            ),
            IconButton(
              icon: const Icon(Icons.text_decrease),
              onPressed: decrementFontSize,
            ),
          ],
        ),
      ],
    );
  }
}
