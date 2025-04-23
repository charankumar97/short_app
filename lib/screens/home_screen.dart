import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 1080.rw,
        height: 1920.rh,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.0, 0.08),
            radius: 0.65,
            // focal: Alignment.center,
            focalRadius: 0.001,
            colors: [Color(0xFFFF733C), Color(0xFFDC2328)],
            stops: [0.0, 1.0],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 210,
              left: 100,
              child: Container(
                width: 964.rw,
                height: 200.rh,
                alignment: Alignment.center,
                child: Text(
                  'SLICE OF HAPPINESS',
                  style: TextStyle(
                    color: Color(0xFFEEEFF7),
                    fontWeight: FontWeight.w900,
                    fontSize: 100.rt,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 180,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/image 228.png',
                width: 1438.rw,
                height: 1438.rh,
              )
            )
          ],
        ),
      ),
    );
  }
}
