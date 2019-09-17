import 'package:flutter/material.dart';
import 'package:jac/Components/HomePageComponents/SelectedBookingHistory.dart';
import 'package:jac/Constants/mycolors.dart';
import 'package:jac/Screens/homePage.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';



class CloseAppDialog extends StatelessWidget{



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
                height: 40.0,
              ),
              Center(
                child: Image(image: AssetImage("assets/images/group_54.png"),
                  height: 50,
                  width: 50,),
              ),

              SizedBox(
                height: 20,
              ),
              Center(
                child: Text('Are you sure?',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0, color: Colors.black),),
              ),

              SizedBox(
                height: 20,
              ),
              Center(
                child: Text('Do you want to exit App?',
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14.0, color: Colors.black),),
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
                      onPressed:   () => Navigator.of(context).pop(false),
                      child: Text('No',
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
                      onPressed:
                            () => Navigator.of(context).pop(true),

                      child: Text('Yes',
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