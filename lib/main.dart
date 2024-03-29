import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jac/Providers/AuthenticationBackend.dart';
import 'package:jac/Providers/CancelBookingBackend.dart';
import 'package:jac/Providers/EmergencyServiceBackend.dart';
import 'package:jac/Screens/LoginScreen.dart';
import 'package:provider/provider.dart';
import 'package:jac/Providers/CarListBackend.dart';
import 'package:jac/Constants/Constants.dart';

import 'Providers/BookingHistoryBackend.dart';
import 'Providers/CarServiceBookingBackend.dart';
import 'Providers/CarServiceCentersBackend.dart';
import 'Providers/RepairBookingBackend.dart';


void main (){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthenticateBackend(),
        ),
        ChangeNotifierProvider.value(
          value: CarListFetchBackend()
        ),
        ChangeNotifierProvider.value(
            value: ServiceCenterBackend()
        ),
        ChangeNotifierProvider.value(
            value: BookRepairBackend()
        ),
        ChangeNotifierProvider.value(
            value: BookCarServiceBackend()
        ),
        ChangeNotifierProvider.value(
            value: BookingHistoryBackend()
        ),
        ChangeNotifierProvider.value(
            value: CancelBookingBackend()
        ),
        ChangeNotifierProvider.value(
            value: EmergencyServiceBackend()
        ),
      ],
        child: new MaterialApp(
      
      title: 'AutoShop',
      theme: ThemeData(fontFamily: 'Muli',primarySwatch: Colors.red,),
    darkTheme: ThemeData.dark(),
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

  fetch(){
      CarListFetchBackend.carListFetch(context);

  }



  void showErrorDialog (BuildContext context, String message){
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Notification'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: (){
                Navigator.of(ctx).pop();
              },
            )
          ],
        )
    );
  }

  @override
  void initState(){
    super.initState();
    fetch();
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

