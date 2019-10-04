import 'package:flutter/material.dart';
import 'package:jac/Components/EmergencyServiceComponents/EmergencyResponseCallDialog.dart';
import 'package:jac/Constants/Constants.dart';
import 'package:jac/Constants/MyColors.dart';
import 'package:jac/Models/EmergencyCentersModel.dart';
import 'package:jac/Providers/EmergencyServiceBackend.dart';
import 'package:jac/Screens/HomePage.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class CallEmergencyCenterDialog extends StatefulWidget{
  static String customerId;
  //static String emergencyCenterId;
  static String location;
  static String natureOfCar;
  static String phone;

  @override
  CallEmergencyCenterDialogState createState() => CallEmergencyCenterDialogState();
}

class CallEmergencyCenterDialogState extends State<CallEmergencyCenterDialog> {

  int _selectedIndex = 0;
  static String emergencyCenterName;
  static String emergencyPhoneNumber;
  String emergencyCenterId;


  dialog(BuildContext context) {
    Utils().openDialog(EmergencyResponseCallDialog(emergencyCenterName, emergencyPhoneNumber), context);
  }


  failDialog(BuildContext context, String message){
    Utils().openDialog(BeautifulAlertDialog(
      assetImage: 'assets/images/group_1336.png',
      firstText:  'Booking Failed',
      secondText:  message,
      confirmText: 'Okay',),

        context);


  }

  navigate(BuildContext context, bool success, String response) async {
    Future.delayed(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));

      if(success==true){
        dialog(context);
      }else{
        failDialog(context, response);
      }
//
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    List<EmergencyCenterModel> emergencyList = Constants.loadedEmergencyCenters
        .toList();


    _onSelected(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }





    void submitEmergencyBooking() {
      Provider.of<EmergencyServiceBackend>(context, listen: false)
          .bookEmergencyService(
          CallEmergencyCenterDialog.customerId,
         emergencyCenterId,
          CallEmergencyCenterDialog.location,
          CallEmergencyCenterDialog.natureOfCar,
          CallEmergencyCenterDialog.phone,
          context);
    }




    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            color: Colors.white,
          ),
          height: 300.0,

          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10.0,
              ),
              Center(
                child: Text('Select Emergency Center',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),),
              ),
              SizedBox(
                height: 20.0,
              ),
              SizedBox(
                height: 160,

                child: FutureBuilder(
                    future: EmergencyServiceBackend().fetchEmergencyCenters(),
                    builder: (context, snapshot) {
                      return ListView.builder(
                          itemCount: emergencyList.length,
                          itemBuilder: (BuildContext context, int index) {
                            EmergencyCenterModel model = emergencyList[index];

//                            emergencyCenterName = model.name;
//                            emergencyPhoneNumber = model.phone;
//                            print(emergencyPhoneNumber);
//                            print(CallEmergencyCenterDialog.phone);

                            return InkWell(
                              onTap: () {
                                _onSelected(index);
                                emergencyCenterId =
                                    model.id.toString();
                                print(emergencyCenterId);
                                emergencyCenterName = model.name;
                                emergencyPhoneNumber = model.phone;
                                print(emergencyPhoneNumber);
                                print(CallEmergencyCenterDialog.phone);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Container(
                                  height: 50,
                                  padding: const EdgeInsets.only(left: 20.0,
                                      top: 5.0,
                                      right: 20.0,
                                      bottom: 5.0),
                                  decoration: _selectedIndex != null &&
                                      _selectedIndex == index
                                      ? BoxDecoration(
                                    color: Colors.grey.withOpacity(.9),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(color: Colors.black12),
                                  )
                                      : BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20)),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: <Widget>[
                                      Text(model.name, style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700),),


                                    ],
                                  ),
                                ),
                              ),
                            );
                          }

                      );
                    }
                ),

              ),
              SizedBox(
                height: 5,
              ),
              MaterialButton(
                height: 50.0,
                onPressed: () async {
                  Utils().openDialog(LoaderTwo(), context);
                  if(emergencyCenterId==null){
                    emergencyCenterId =
                        emergencyList[0].id.toString();
                    print(emergencyCenterId);
                    emergencyCenterName = emergencyList[0].name;
                    emergencyPhoneNumber = emergencyList[0].phone;
                    print(emergencyPhoneNumber);
                    print(CallEmergencyCenterDialog.phone);
                    submitEmergencyBooking();
                  }else {
                    submitEmergencyBooking();
                  }
                },
                child: Text('Proceed',
                    style: TextStyle(color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w200)),
                color: MyColors.designColor,
                padding: EdgeInsets.symmetric(
                  horizontal: 60.0,
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
      ),

    );
  }
}