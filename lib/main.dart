import 'package:confetti_demo/confettiPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ConfettiSample());

class ConfettiSample extends StatelessWidget {
  const ConfettiSample({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Confetti',
        home: Scaffold(
          backgroundColor: Colors.grey[900],
          body: const ConfettiPage(),
        ));
  }
}
