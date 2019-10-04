import 'package:flutter/material.dart';
import 'package:jac/Components/EmergencyServiceComponents/CallEmergencyCenterDialog.dart';
import 'package:jac/Constants/MyColors.dart';
import 'package:jac/Models/EmergencyTypeModel.dart';
import 'package:jac/Utils/DialogUtil.dart';

class EmergencyScreen extends StatefulWidget {

  @override
  EmergencyScreenState createState() => EmergencyScreenState();
}

class EmergencyScreenState extends State<EmergencyScreen> {
  int _selectedIndex = 0;
  String natureOfCar;
  String phoneNumber;


  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  validationChecks(){
    if(natureOfCar==null){
      Utils().showErrorDialog(context, 'Please Select your Car Situation');
    }else if(phoneNumber== null){
      Utils().showErrorDialog(context, 'Pls enter a Phone Number');
    }else if(phoneNumber.length != 11){
      Utils().showErrorDialog(context, 'Please Enter a valid Phone Number');
    }else{
      Utils().openDialog(CallEmergencyCenterDialog(), context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency',
                style: TextStyle(
                  color: Colors.white
                ),),
        centerTitle: true,
        backgroundColor: Color(0xff393636),
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/group_1338.png",),
                    alignment: Alignment.topCenter,
                    fit: BoxFit.fill
                ),
              ),
            ),



            SizedBox(
              height: 300,
              child: ListView.builder(
                  itemCount: emergencyTypeList.length,
                  itemBuilder: (BuildContext context, int index) {
                    EmergencyType emergencyType = emergencyTypeList[index];

                    return InkWell(
                      onTap: () {
                        _onSelected(index);
                        natureOfCar = emergencyType.type;
                        CallEmergencyCenterDialog.natureOfCar = natureOfCar;
                        print(CallEmergencyCenterDialog.natureOfCar);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 5.0, right: 15.0, bottom: 5.0),
                        child: Container(
                          height: 70,
                          padding: const EdgeInsets.only(left: 20.0, top: 25.0, right: 15.0, bottom: 5.0),
                          decoration: _selectedIndex != null && _selectedIndex == index
                              ? BoxDecoration(
                            color: Colors.grey.withOpacity(.9),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.black12),
                          )
                              : BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Text(
                                    emergencyType.type,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0),
                                  ),

                                ],
                              ),


                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),





            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Enter Phone Number',
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w800, color: MyColors.designColor),
                  )
                ],
              ),
            ),



            Padding(
              padding: const EdgeInsets.only(left:20.0, right: 20.0, top: 5, bottom: 10),
              child: Center(
                child: Container(
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(color: Colors.black12),
                  ),
                  child: TextField(
                    onChanged: (value){
                      phoneNumber= value;
                      CallEmergencyCenterDialog.phone = phoneNumber;
                      print(CallEmergencyCenterDialog.phone);
                    },
                    cursorColor: MyColors.designColor,
                    keyboardType: TextInputType.phone,
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
              height: 10.0,
            ),

            MaterialButton(
              height: 50.0,
              onPressed: () {
             validationChecks();
              },
              child: Text('Continue',
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
            SizedBox(height: 10,)
          ],
        ),
      ),
    );

  }
}
