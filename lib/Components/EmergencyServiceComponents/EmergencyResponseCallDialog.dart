import 'package:flutter/material.dart';
import 'package:jac/Components/HomePageComponents/SelectedBookingHistory.dart';
import 'package:jac/Constants/MyColors.dart';
import 'package:jac/Screens/HomePage.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';
import 'package:url_launcher/url_launcher.dart';



class EmergencyResponseCallDialog extends StatelessWidget{

  final String emergencyCenterName;
  final String emergencyPhoneNumber;

EmergencyResponseCallDialog(this.emergencyCenterName, this.emergencyPhoneNumber);

void callMe() async {
  var uri = 'tel:$emergencyPhoneNumber';
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    throw 'Could not launch $uri';
  }
}


  @override
  Widget build(BuildContext context) {


    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius:  BorderRadius.circular(25.0),
            color: Colors.white,
          ),
          height: 300.0,

          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Image(image: AssetImage("assets/images/successimage.png"),
                  height: 70,
                  width: 70,),
              ),

              SizedBox(
                height: 10,
              ),
              Center(
                child: Text('Emergency Request Sent',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0, color: Colors.black),),
              ),

              SizedBox(
                height: 0.0,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Center(
                  child: Text('You will recieve a response soon or you can contact ${emergencyCenterName.toUpperCase()} via ${emergencyPhoneNumber}',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14.0, color: Colors.black),),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    MaterialButton(
                      height: 50.0,
                      onPressed: () {
                       callMe();

                      },
                      child: Text('Call',
                          style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w200)),
                      color: MyColors.designColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                      ),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                    ),

                    MaterialButton(
                      height: 50.0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Okay',
                          style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w200)),
                      color: Colors.grey,
                      padding: EdgeInsets.symmetric(
                        horizontal: 40.0,
                      ),
                      elevation: 5.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30.0),
                        ),
                      ),
                    ),
                  ],

                ),
              ),
            ],
          ),
        ),
      ),

    );

  }
}