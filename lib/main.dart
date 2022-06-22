import 'package:flutter/material.dart';
import 'package:flutter_duuchin/transit_page.dart';

import 'config/app_theme.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '杜琴',
      debugShowCheckedModeBanner: false,
      home: TransitPage(),
      theme: themeData,
    );
  }
}
