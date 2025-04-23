import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:short_app/screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState(){
    super.initState();
    Future.delayed(Duration(seconds: 5), (){
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => HomeScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              'assets/images/splash.jpg',
              width: MediaQuery.of(context).size.width,
              height: 1923.rh,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
