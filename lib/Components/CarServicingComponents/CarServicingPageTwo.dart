import 'package:flutter/material.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageFour.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageThree.dart';
import 'package:jac/Constants/constants.dart';
import 'package:jac/Constants/mycolors.dart';
import 'package:jac/Providers/RepairBookingBackend.dart';
import 'package:jac/Screens/homePage.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:jac/Models/carsList.dart';
import 'package:jac/Providers/CarListBackend.dart';
import 'package:jac/Providers/CarServiceCentersBackend.dart';
import 'package:provider/provider.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:jac/Models/carServiceCenters.dart';
import 'package:jac/Providers/CarServiceCentersBackend.dart';
import 'package:jac/Database/CarModelDB.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jac/Utils/ChoiceChip.dart';

class CarServicingPageTwo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CarServicingPageTwoState();
  }
}

class CarServicingPageTwoState extends State<CarServicingPageTwo> {
  String selectedType;
  String selectedModel;
  String selectedBrand;

  Color selectedColor;
  bool isVehicleBrandSelected = true;
  @override
  Widget build(BuildContext context) {

    List<CarTypes> caro = Constants.carCodes;
    List<CarTypes> descri = Constants.carDescription;

    // TODO: implement build
    return Scaffold(
      body: Container(
        child: Column(children: <Widget>[
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
              'Choose a Vehicle Brand',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    isVehicleBrandSelected = true;
                    selectedBrand = 'JAC_MOTORS';
                    CarServicingPageFour.selectedBrand = selectedBrand;
                  });
                },

                child: ChoiceSelector(AssetImage('assets/images/group_443.png'), 'JAC', isVehicleBrandSelected),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isVehicleBrandSelected = false;
                    selectedBrand = 'TOYOTA';
                    CarServicingPageFour.selectedBrand = selectedBrand;
                  });
                },

                child: ChoiceSelector(AssetImage("assets/images/toyota.png"), 'TOYOTA', !isVehicleBrandSelected),
              ),
            ],
          ),


          SizedBox(
            height: 40.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Choose Vehicle Type',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                )
              ],
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
                    value: selectedType,

                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Vehicle Type';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Vehicle Type',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,


                    ),
                    onChanged: (newValue) {
                      setState(() {
                        selectedType = newValue;
                        print(selectedType);
                        CarsDatabase.carsDatabase.getVehicleType(selectedType);
                        CarServicingPageFour.selectedType = selectedType;

                      });
                    },
                    items: caro.map((carTypes) {
                      return DropdownMenuItem(
                        value: carTypes.code,
                        child: Text(
                          carTypes.code,
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                        ),

                      );
                    }).toList()),
              ),
            ),
          ),


          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Row(
              children: <Widget>[
                Text(
                  'Choose Vehicle Model',
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                )
              ],
            ),
          ),


          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.black12),
                ),
                child: DropdownButtonFormField<String>(
                    value: selectedModel,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Enter Vehicle Model';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: 'Vehicle Model',
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        selectedModel = newValue;
                        print(selectedModel);
                        CarServicingPageFour.selectedModel= selectedModel;

                      });
                    },
                    items: descri.map((carTypes) {
                      return DropdownMenuItem(
                        value: carTypes.description,
                        child: Text(
                          carTypes.description,
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
              Navigator.push(context, MaterialPageRoute(builder: (context) => CarServicingPageThree()));
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

        ],
        ),
      ),
    );
  }
}

