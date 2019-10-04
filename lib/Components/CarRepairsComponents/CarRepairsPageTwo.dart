import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jac/Constants/MyColors.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';

import 'CarRepairsPageThree.dart';
import 'package:jac/Components/CarRepairsComponents/CarRepairsPageFour.dart';

class CarRepairsPageTwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CarRepairsPageTwoState();
  }
}

class CarRepairsPageTwoState extends State<CarRepairsPageTwo> {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String dateGet;
  String timeGet;
  String enteredProblem;
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
    dateGet = formatter.format(selectedDate);
    CarRepairsPageFour.selectedDate =dateGet;
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
    CarRepairsPageFour.selectedTime =timeGet;
  }

  validationChecks()async{
    if(dateGet == null){
      Utils().showErrorDialog(context, 'Please Select Date');
    }else  if(timeGet == null){
      Utils().showErrorDialog(context, 'Please Select Time');
    } else {
      Utils().openDialog(LoaderTwo(), context);
      await Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CarRepairsPageThree()));
        });
      });
    }
    }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              "assets/images/group_1185.png",
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
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

                SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20.0,
                        ),

                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[

                              InkWell(
                                child: Container(
                                  height: 50.0,
                                 // width: 178,
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
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${DateFormat.yMMMd().format(selectedDate)}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 19.0),

                                        ),
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
                                 // width: 168,
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

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${selectedTime.format(context)}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w200,
                                              fontSize: 19.0),
                                        ),
                                      ),
                                      SizedBox(width: 30,),
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
                          height: 20.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                'Problem Description',
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                              )
                            ],
                          ),
                        ),



                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Center(
                            child: Container(
                              height: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15.0),
                                border: Border.all(color: Colors.black12),
                              ),
                              child: TextField(
                                onChanged: (value){
                                  enteredProblem = value;
                                  CarRepairsPageFour.enteredProblem =value;
                                },
                                cursorColor: MyColors.designColor,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w200),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(8.0),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(
                          height: 20.0,
                        ),

                        MaterialButton(
                          height: 50.0,
                          onPressed: () {
                           validationChecks();
                          },
                          child: Text('Continue',
                              style: TextStyle(color: Colors.white, fontSize: 16.0)),
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

                        SizedBox(height: 10,)

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
