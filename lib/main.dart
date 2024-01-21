import 'package:calorie_counter_app_design/firebase_options.dart';
import 'package:calorie_counter_app_design/food_test.dart';
import 'package:calorie_counter_app_design/prelim/welcomepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: false
      ),
        debugShowCheckedModeBanner: false,
      home: WelcomePage()
    );
  }
}



