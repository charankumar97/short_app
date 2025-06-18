import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';

import '../models/person_model.dart';
import 'bottom_navigation.dart';
import 'landing_screen.dart';

class DelayedScreen extends StatefulWidget {
  const DelayedScreen({super.key});

  @override
  State<DelayedScreen> createState() => _DelayedScreenState();
}

class _DelayedScreenState extends State<DelayedScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      List<Person> user = provider.users.toList();
      return SafeArea(
        child: Scaffold(
          body: user.isEmpty? LandingScreen(): BottomNavigation(),
        ),
      );
    });
  }
}
