import 'package:flutter/material.dart';
import 'package:jac/Constants/Constants.dart';
import 'package:jac/Constants/MyColors.dart';
import 'package:jac/Models/CarsList.dart';
import 'package:jac/Database/CarModelDB.dart';
import 'package:jac/Providers/CarServiceCentersBackend.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';
import 'package:provider/provider.dart';
import 'CarRepairsPageTwo.dart';
import 'package:jac/Utils/ChoiceChip.dart';
import 'package:jac/Components/CarRepairsComponents/CarRepairsPageFour.dart';

class CarRepairFirstPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {

    return CarRepairFirstPageState();
  }
}

class CarRepairFirstPageState extends State<CarRepairFirstPage> {
  static String lat;
  static String lng;
  String selectedType;
  String selectedModel;
  String selectedBrand;
  Color selectedColor;
  bool isVehicleBrandSelected = true;
  bool loaded=false;

loaderMan()async{
  Utils().openDialog(LoaderTwo(), context);
  await Future.delayed(const Duration(milliseconds: 1000), () {
    setState(() {
     Navigator.pop(context);
    });
  });
}

  validationChecks()async{
    if(selectedBrand == null){
        Utils().showErrorDialog(context, 'Please Choose Vehicle Brand');
    }else  if(selectedType == null){
      Utils().showErrorDialog(context, 'Please Select Vehicle Type');
    }else  if(selectedModel == null){
      Utils().showErrorDialog(context, 'Please Select Vehicle Model');
    } else{
      Utils().openDialog(LoaderTwo(), context);
   await   Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          Navigator.pop(context);
          Navigator.push(context, MaterialPageRoute(builder: (context) => CarRepairsPageTwo()));
        });
      });

    }
  }


  Future<void> submitFetchRequest() async{
    await Provider.of<ServiceCenterBackend>(context, listen: false).fetchCarServiceCenter(
        lat,
        lng,
        selectedBrand.toString()
    );
  }


  Future<void> navigate(String selectedType){
    CarsDatabase.carsDatabase.getVehicleType(selectedType);
    build(context);
  }


  @override
  Widget build(BuildContext context){

    List<CarTypes> caro = Constants.carCodes;
    List<CarTypes> descri = Constants.carDescription;




    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
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
                      selectedType = null;
                      selectedModel =null;
                      CarsDatabase.carsDatabase.getVehicleType(selectedBrand);
                      CarRepairsPageFour.selectedBrand = selectedBrand;
                      submitFetchRequest();
                      loaderMan();
                    });
                  },

                  child: ChoiceSelector(AssetImage('assets/images/group_443.png'), 'JAC', isVehicleBrandSelected),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isVehicleBrandSelected = false;
                      selectedBrand = 'TOYOTA';
                      selectedType = null;
                      selectedModel =null;
                      CarsDatabase.carsDatabase.getVehicleType(selectedBrand);
                      CarRepairsPageFour.selectedBrand = selectedBrand;
                      submitFetchRequest();
                      loaderMan();
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
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
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
                      value: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: selectedType,
                        hintStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,


                      ),
                      onChanged: (newValue){
                       setState(() {
                          selectedType = newValue;
                          print(selectedType);
                          print(selectedBrand);
                          CarsDatabase.carsDatabase.getVehicleModel(selectedType, selectedBrand);
                          CarRepairsPageFour.selectedType = selectedType;
                          loaderMan();
                        });



                      },
                      items: caro.map((carTypes){
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
                    style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),


           ///

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
                    value: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      hintText: selectedModel,
                      hintStyle: TextStyle(color: Colors.black),
                      border: InputBorder.none,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        selectedModel = newValue;
                        print(selectedModel);
                        CarRepairsPageFour.selectedModel= selectedModel;

                      });
                    },
                    items: descri.map((carTypes) {
                      return DropdownMenuItem(
                        value: carTypes.description,
                        child: Text(
                          carTypes.description,
                          style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
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
    );
  }
}


