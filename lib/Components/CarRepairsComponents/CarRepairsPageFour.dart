import 'package:flutter/material.dart';
import 'package:jac/Providers/BookingHistoryBackend.dart';
import 'package:jac/Providers/RepairBookingBackend.dart';
import 'package:jac/Screens/homePage.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';
import 'package:provider/provider.dart';


class CarRepairsPageFour extends StatelessWidget{
  static int userID;
  static String selectedDate;
  static String enteredProblem;
  static String selectedTime;
  static String selectedServiceCenter;
  static String selectedBrand;
  static String selectedModel;

  static String selectedServiceBusiness;
  static String selectedServiceLocation;
  static String selectedType;

  final designColor = const Color(0xffed151e);


  Future<void> submitRepairService(BuildContext context) async {
    await Provider.of<BookRepairBackend>(context, listen: false).bookRepairsServiceFetch(
        userID,
        selectedDate.toString(),
        enteredProblem,
        selectedTime.toString(),
        'Repairs'.trim(),
        selectedServiceCenter,
        selectedBrand,
        selectedModel);
  }

  dialog(BuildContext context){
    Utils().openDialog(BeautifulAlertDialog(
      assetImage: 'assets/images/successimage.png',
      firstText:  'Booking Request Sent',
      secondText:  'You would recieve a confirmation mail',
      confirmText: 'Okay',),

        context);


  }

  submitFetchBookingHistory(BuildContext context){
    Provider.of<BookingHistoryBackend>(context, listen: false)
        .fetchBookingHistory(userID);

  }







  @override
  Widget build(BuildContext context) {
    submitFetchBookingHistory(){
      Provider.of<BookingHistoryBackend>(context, listen: false)
          .fetchBookingHistory(userID);

    }

    navigate()async{

       Future.delayed(const Duration(milliseconds: 1000), () {
         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
         dialog(context);
       });


    }


    return Center(
      child: Container(
        height: 370,
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
                     mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.location_on,
                          size: 20,
                          color: designColor,
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
                  onPressed: () async{
                    Utils().openDialog(LoaderTwo(), context);
                   await submitRepairService(context).whenComplete(submitFetchBookingHistory);
navigate();

                  },
                  child: Text('Submit',
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  color: designColor,
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


