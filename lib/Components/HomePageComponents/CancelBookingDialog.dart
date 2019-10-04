import 'package:flutter/material.dart';
import 'package:jac/Components/HomePageComponents/SelectedBookingHistory.dart';
import 'package:jac/Constants/MyColors.dart';
import 'package:jac/Screens/HomePage.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';



class CancelAlertDialog extends StatelessWidget{


  dialog(BuildContext context){
    Utils().openDialog(BeautifulAlertDialog(
      assetImage: 'assets/images/successimage.png',
      firstText:  'Booking Cancelled',
      secondText:  'You would recieve a confirmation mail',
      confirmText: 'Okay',),

        context);
  }


  Future<void> finalAction(BuildContext context) async{
    Utils().openDialog(LoaderTwo(), context);
    await SelectedBookingHistoryState().cancelBookingRequest(context);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    dialog(context);
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
                child: Image(image: AssetImage("assets/images/group_54.png"),
                  height: 100,
                  width: 100,),
              ),

              SizedBox(
                height: 10,
              ),
              Center(
                child: Text('Ongoing Service',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0, color: Colors.black),),
              ),

              SizedBox(
                height: 10,
              ),
              Center(
                child: Text('Are you sure you want to cancel?',
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 16.0, color: Colors.black),),
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
                   finalAction(context);

                      },
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

                    MaterialButton(
                      height: 50.0,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('No',
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