import 'package:flutter/material.dart';
import 'splash.dart';

void main() {
  runApp(const RxpApp());
}

class RxpApp extends StatelessWidget {
  const RxpApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
