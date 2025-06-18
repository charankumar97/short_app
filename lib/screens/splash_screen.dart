import 'package:flutter/material.dart';
import 'package:short_app/screens/delayed_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (_) => DelayedScreen()
        ),
      );
    });
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   final provider = Provider.of<ShortProvider>(context, listen: false);
    //   final bool loggedIn = provider.isLoggedIn();
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/splash.jpg',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
