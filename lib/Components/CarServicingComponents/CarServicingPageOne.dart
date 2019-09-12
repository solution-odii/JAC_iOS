import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageFour.dart';
import 'package:jac/Constants/mycolors.dart';
import 'package:jac/Providers/CarServiceBookingBackend.dart';
import 'package:provider/provider.dart';

import 'CarServicingPageTwo.dart';


class CarServicingPageOne extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {

    return CarServicingPageOneState();
  }
}

class CarServicingPageOneState extends State<CarServicingPageOne>{
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  String dateGet;
  String timeGet;
  String mileage;
  String selectedServicingType;

  static int userID;
  static String recommendedService;

  List<String> typesOfService = ['First Service', 'Quick Service', 'Periodic Service'];


  var formatter = new DateFormat('yyyy-MM-dd');

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark(),
            child: child,
          );
        },
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2019, 9),
        lastDate: DateTime(2101));

    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });

    //dateGet = "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
    dateGet= formatter.format(selectedDate);
    CarServicingPageFour.selectedDate =dateGet;
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });

    timeGet = "${selectedTime.hour}:${selectedTime.minute}";
    CarServicingPageFour.selectedTime =timeGet;
  }


  Future<void> submitMile() async{
    await Provider.of<BookCarServiceBackend>(context, listen: false).mileageRecommendFetch(context,
         userID,
        mileage.toString()
    );
  }

  @override
  Widget build(BuildContext context) {
    if(recommendedService==null){
      recommendedService='Enter Mileage';
    }



    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage(
                  "assets/images/group_1099.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.arrow_back, size: 30.0),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),

                Center(
                  child: Text(
                    'Car Servicing',
                    style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
                  ),
                ),



                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 0.0,
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0,
                          right: 10.0,
                          top: 20.0,
                          bottom: 0.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              InkWell(
                                child: Container(
                                  height: 50.0,
                                  width: 178,
                                  decoration: BoxDecoration(
                                    //shape: BoxShape.rectangle,
                                    color: Color(0xff393636),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(15.0),
                                        topRight: Radius.circular(0.0),
                                        bottomLeft: Radius.circular(15.0),
                                        bottomRight: Radius.circular(0.0) ),

                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        '${DateFormat.yMMMd().format(selectedDate)}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200,
                                            fontSize: 19.0),

                                      ),

                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      ),

                                    ],
                                  ),
                                ),
                                onTap: () => _selectDate(context),
                              ),

                              SizedBox(
                                width: 2.0,
                              ),


                              InkWell(
                                child: Container(
                                  height: 50.0,
                                  width: 168,
                                  decoration: BoxDecoration(
                                    //shape: BoxShape.rectangle,
                                    color: Color(0xff393636),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(0.0),
                                        topRight: Radius.circular(15.0),
                                        bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(15.0) ),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[

                                      Text(
                                        '${selectedTime.format(context)}',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w200,
                                            fontSize: 19.0),
                                      ),
                                      Icon(
                                        Icons.arrow_drop_down,
                                        color: Colors.white,
                                      ),

                                    ],
                                  ),
                                ),
                                onTap: () => _selectTime(context),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 0.0,
                        ),


                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: Color(0xfff7f7f7),
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: TextField(
                                onChanged: (value){
                                  mileage = value;
                                  submitMile();

                                  CarServicingPageFour.mileage =value;
                                },
                                cursorColor: MyColors.designColor,
                                keyboardType: TextInputType.number,
                                maxLines: null,
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  hintText: 'Input car mileage',
                                  hintStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Center(
                          child: Text(
                            'Recommended',
                            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w200),
                          ),
                        ),

                        Center(
                          child: Text(

                            recommendedService.toString(),
                            style: TextStyle(color: MyColors.designColor, fontSize: 22.0, fontWeight: FontWeight.w700),
                          ),
                        ),


                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Color(0xfffab0b3),

                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: DropdownButtonFormField<String>(
                                  value: selectedServicingType,

                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Select Servicing Type';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                                    hintText: 'Select Type of Servicing',
                                    hintStyle: TextStyle(color: Colors.black),
                                    border: InputBorder.none,


                                  ),
                                  onChanged: (newValue) {
                                    setState(() {
                                      selectedServicingType = newValue;
                                      print(selectedServicingType);

                                      CarServicingPageFour.selectedTypeOfServicing = selectedServicingType;

                                    });
                                  },
                                  items: typesOfService.map((serviceType) {
                                    return DropdownMenuItem(
                                      value: serviceType,
                                      child: Text(
                                        serviceType,
                                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                      ),

                                    );
                                  }).toList()),
                            ),
                          ),
                        ),




                        SizedBox(
                          height: 20.0,
                        ),

                        MaterialButton(
                          height: 50.0,
                          onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => CarServicingPageTwo()));
                          },
                          child: Text('Pick a Service',
                              style: TextStyle(color: Colors.white, fontSize: 20.0)),
                          color: MyColors.designColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 102.0,
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


              ],
            ),

          ),


        ],
      ),
    );
  }
}

