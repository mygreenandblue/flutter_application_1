import 'package:flutter/material.dart';

import 'package:flutter_application_1/views/companyViews/companyList_Screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home Screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        unselectedWidgetColor: Colors.blue,
      ),
      home: CompanyListScreen(),
    );
  }
}
