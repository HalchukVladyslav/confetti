import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfettiPage extends StatefulWidget {
  @override
  _ConfettiPageState createState() => _ConfettiPageState();
}

class _ConfettiPageState extends State<ConfettiPage> {
  late ConfettiController _controllerCenter;
  late ConfettiController _controllerTopCenter;

  @override
  void initState() {
    super.initState();
    _controllerCenter = new
        ConfettiController(duration: new Duration(milliseconds: 500));
    _controllerTopCenter = new
        ConfettiController(duration: new Duration(seconds: 3));
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    _controllerTopCenter.dispose();
    super.dispose();
  }

  Path drawStar(Size size) {
    // Method to convert degree to radians
    double degToRad(double deg) => deg * (pi / 180.0);

    // const numberOfPoints = 5;
    final halfWidth = size.width / 2;
    final externalRadius = halfWidth;
    final internalRadius = halfWidth / 2.5;
    final degreesPerStep = degToRad(360 / 4);
    final halfDegreesPerStep = degreesPerStep / 2;
    final path = Path();
    final fullAngle = degToRad(360);
    path.moveTo(size.width, halfWidth);

    for (double step = 0; step < fullAngle; step += degreesPerStep) {
      path.lineTo(halfWidth + externalRadius,
          // * cos(step),
          halfWidth + externalRadius
              // * sin(step)
      );
      path.lineTo(halfWidth + internalRadius
          // * cos(step + halfDegreesPerStep)
          ,
          halfWidth + internalRadius
              // * sin(step + halfDegreesPerStep)
      );
    }
    path.close();
    return path;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(



      body: Center(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child:
              ConfettiWidget(
                confettiController: _controllerTopCenter,
                blastDirectionality: BlastDirectionality.directional,
                displayTarget: false,
                shouldLoop: true,
                blastDirection: pi / 2,
                maxBlastForce: 5,
                minBlastForce: 1,
                emissionFrequency: 0.01,
                numberOfParticles: 23,
                gravity: 0.1,
                // createParticlePath: drawStar,
              ),
            ),
            Align(
                alignment: Alignment.center,
                child:
                ConfettiWidget(
                  confettiController: _controllerCenter,
                  blastDirectionality: BlastDirectionality.directional,
                  displayTarget: false,
                  shouldLoop: true,
                  blastDirection: -pi / 2,
                  maxBlastForce: 100,
                  minBlastForce: 99,
                  emissionFrequency: 0.01,
                  numberOfParticles: 23,
                  gravity: 0.01,
                  // createParticlePath: drawStar,
                ),
              ),
                Center(
                  child: InkWell(
                    onTap: () async {
                    _controllerCenter.play();
                    await Future.delayed(Duration(milliseconds: 1000), () {_controllerCenter.stop();});
                    await Future.delayed(Duration(milliseconds: 500), () {_controllerTopCenter.play();});
                    await Future.delayed(Duration(milliseconds: 3000), () {_controllerTopCenter.stop();});
                    },
                    child: Container(color: Colors.blue,width: 70,
                        child: Text(
                          "Success",textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
