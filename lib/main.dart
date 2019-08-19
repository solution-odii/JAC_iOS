import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jac/Providers/sigupbackend.dart';
import 'package:jac/Screens/loginScreen.dart';
import 'package:provider/provider.dart';


void main (){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: SignUpAuth(),
        )
      ],
        child: new MaterialApp(
      
      title: 'JAC',
      home: new SplashScreen(),

      routes: <String, WidgetBuilder>{
        '/HomeScreen': (BuildContext context)=> LoginScreen()
      },
      debugShowCheckedModeBanner: false,
    ),
    );
  }
}


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => SplashScreenState();
  
  }

  class SplashScreenState extends State<SplashScreen>{
  
  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, navigationPage);
  }

  void navigationPage(){

    Navigator.of(context).pushReplacementNamed('/HomeScreen');

  }

  @override
  void initState(){
    super.initState();
    startTime();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/images/jac_splash.png'),
      ),
    );
  }

  }

