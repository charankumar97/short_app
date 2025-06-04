import 'package:flexify/flexify.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:short_app/provider/short_provider.dart';
import 'package:short_app/screens/splash_screen.dart';

import 'models/person_model.dart';

void main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox<Person>('person');
  var userBox = Hive.box<Person>('person');
  List<Person> users = userBox.values.toList();
  runApp(
    ChangeNotifierProvider(
      create: (context) => ShortProvider(user: users, context: context),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ShortProvider>(builder: (context, provider, _){
      return Flexify(
        designWidth: 1080,
        designHeight: 1920,
        app: MaterialApp(
          title: 'CakesandBakes',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            fontFamily: 'Sofia Pro',
          ),
          home: SplashScreen(),
        ),
      );
    });
  }
}
