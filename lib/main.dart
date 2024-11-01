import 'package:flutter/material.dart';
import 'package:flutter_individual_list_screen/database_helper.dart';
import 'package:flutter_individual_list_screen/individual_list_screen.dart';


final dbHelper = DatabaseHelper();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dbHelper.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: IndividualListScreen(),
    );
  }
}