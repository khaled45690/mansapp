import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mansaapp/ui/SplashScreen.dart';
import 'package:mansaapp/ui/TestFamousV1.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  TextDirection _textDirection = TextDirection.rtl;


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      builder: (BuildContext context, Widget child) {
        return Directionality(
          textDirection: _textDirection,
          child: child,
        );
      },
      home: SplashScreen(),//TestFamousV1(),//SplashScreen(),//Payment(),//
    );
  }
}
