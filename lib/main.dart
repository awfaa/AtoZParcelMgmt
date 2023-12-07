// main.dart
//Nurul Izzaty Binti Muhammad Aris 2022876
import 'package:flutter/material.dart';
import 'parcel_management_system.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parcel Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ParcelManagement(),
    );
  }
}
