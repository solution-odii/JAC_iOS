import 'package:flutter/material.dart';
import 'package:jac/Constants/mycolors.dart';
import 'package:jac/Providers/CarServiceBookingBackend.dart';
import 'package:jac/Screens/homePage.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:provider/provider.dart';


class CarServicingPageFour extends StatelessWidget{
  static int userID;
  static String selectedDate;
  static String mileage;
  static String selectedTime;
  static String selectedServiceCenter;
  static String selectedBrand;
  static String selectedModel;

  static String selectedServiceBusiness;
  static String selectedServiceLocation;
  static String selectedType;
  static String selectedTypeOfServicing;






  @override
  Widget build(BuildContext context) {

    Future<void> submitServicingService() async {
      await Provider.of<BookCarServiceBackend>(context, listen: false).bookCarServicingFetch(
          userID,
          selectedDate.toString(),
          int.parse(mileage),
          selectedTypeOfServicing,
          selectedTime.toString(),
          'Servicing'.trim(),
          selectedServiceCenter,
          selectedBrand,
          selectedModel);
    }


    dialog(){
      Utils().openDialog(BeautifulAlertDialog(
        assetImage: 'assets/images/successimage.png',
        firstText:  'Booking Request Sent',
        secondText:  'You would recieve a confirmation mail',
        confirmText: 'Okay',),

          context);


    }


    return Center(
      child: Container(
        height: 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Dialog(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Center(
                child: Text(selectedServiceBusiness,
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w800),),
              ),

              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70.0, right: 40.0),
                child: Center(

                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        size: 20,
                        color: MyColors.designColor,
                      ),

                      Expanded(
                        child: Text(
                          selectedServiceLocation,
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w200,
                              fontSize: 16.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),


              SizedBox(
                height: 30,
              ),
              Center(
                child: Text('${selectedDate.toString() + ' @ ' + selectedTime.toString()}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 18.0),),
              ),

              SizedBox(
                height: 30,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Mileage: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0),),

                    Text('${mileage.toString()}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 17.0),),
                  ],
                ),

              ),

              SizedBox(
                height: 2,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Service Type: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0),),

                    Text('${selectedModel.toString()}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 17.0),),
                  ],
                ),

              ),



              SizedBox(
                height: 30,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Vehicle Type: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0),),

                    Text('${selectedType.toString()}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 17.0),),
                  ],
                ),

              ),

              SizedBox(
                height: 2,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Model: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontSize: 17.0),),

                    Text('${selectedModel.toString()}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w200,
                          fontSize: 17.0),),
                  ],
                ),

              ),


              SizedBox(
                height: 30.0,
              ),

              Center(
                child: MaterialButton(
                  height: 50.0,
                  onPressed: () async {
                    await submitServicingService();
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                    dialog();
                  },
                  child: Text('Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  color: MyColors.designColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 80.0,
                  ),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                  ),
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}


