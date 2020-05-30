import 'package:flutter/material.dart';
import 'package:flutter_mongo_stitch/flutter_mongo_stitch.dart';
import 'package:routine/choose_categories.dart';
import 'package:routine/login.dart';
import 'package:routine/register.dart';
import 'package:routine/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await MongoStitchClient.initializeApp(MONGO_APP_ID);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegisterPage(),
    );
  }
}
