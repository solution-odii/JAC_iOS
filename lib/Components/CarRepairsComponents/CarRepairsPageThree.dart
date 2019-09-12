import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jac/Constants/mycolors.dart';
import 'package:jac/Models/carServiceCenters.dart';
import 'package:jac/Constants/constants.dart';
import 'package:jac/Components/CarRepairsComponents/CarRepairsPageFour.dart';
import 'package:jac/Utils/DialogUtil.dart';



class CarRepairsPageThree extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CarRepairsPageThreeState();
  }
}

class CarRepairsPageThreeState extends State<CarRepairsPageThree> {
  List<CarServiceCenters> locations =
  Constants.loadedCarServiceCenters.toList();
  String chosenServiceCenter;
  String chosenServiceBusiness;
  String chosenServiceLocation;
  int _selectedIndex=0;



  _onSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }



  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
            height: 250,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/mask_group_3.png",),
                alignment: Alignment.topCenter,
                fit: BoxFit.fill
            ),

            ),

            child: Column(

              children: <Widget>[
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                  child: Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Icon(Icons.arrow_back, size: 30.0, color: Colors.white,),
                        onTap: (){
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                Center(
                  child: Text('${locations.length.toString() + ' Service \nCenters available'}',
                    style: TextStyle(color: Colors.white,
                        fontWeight: FontWeight.w300,
                        fontSize: 24.0),),
                ),
              ],
            ),
          ),

          SizedBox(
            height: 350,
            child: ListView.builder(
                itemCount: locations.length,
                itemBuilder: (BuildContext context, int index) {
                  CarServiceCenters model = locations[index];

                  return InkWell(
                    onTap: () {
                      _onSelected(index);
                      chosenServiceCenter=model.username;
                      chosenServiceBusiness = model.businessName;
                      chosenServiceLocation = model.serviceLocation;
                      CarRepairsPageFour.selectedServiceBusiness=chosenServiceBusiness;
                      CarRepairsPageFour.selectedServiceLocation=chosenServiceLocation;
                      CarRepairsPageFour.selectedServiceCenter=chosenServiceCenter;
                      print(CarRepairsPageFour.selectedServiceBusiness.toString());
                      print(chosenServiceBusiness);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0, top: 5.0, right: 15.0, bottom: 5.0),
                      child: Container(
                        height: 100,
                        padding: const EdgeInsets.only(left: 20.0, top: 25.0, right: 15.0, bottom: 5.0),
                        decoration: _selectedIndex != null && _selectedIndex == index
                            ? BoxDecoration(
                          color: Colors.grey.withOpacity(.15),
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
                                  model.businessName,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20.0),
                                ),

                                Spacer(),
                                Icon(
                                  Icons.star,
                                  color: MyColors.designColor,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star,
                                  color: MyColors.designColor,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star,
                                  color: MyColors.designColor,
                                  size: 18,
                                ),
                                Icon(
                                  Icons.star,
                                  color: MyColors.designColor,
                                  size: 18,
                                ),



                                Text(
                                  '4.0',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w200,
                                      fontSize: 16.0),
                                ),

                              ],
                            ),

                            const SizedBox(height: 10.0),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  size: 20,
                                  color: MyColors.designColor,
                                ),

                                Expanded(
                                  child: Text(
                                    model.serviceLocation,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  ),
                                ),





//                                Icon(
//                                  Icons.star,
//                                  color: designColor,
//                                  size: 18,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: designColor,
//                                  size: 18,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: designColor,
//                                  size: 18,
//                                ),
//                                Icon(
//                                  Icons.star,
//                                  color: designColor,
//                                  size: 18,
//                                ),
//
//
//
//                                  Text(
//                                    '4.0',
//                                    style: TextStyle(
//                                        color: Colors.black,
//                                        fontWeight: FontWeight.w200,
//                                        fontSize: 16.0),
//                                  ),
//



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

          MaterialButton(
            height: 50.0,
            onPressed: () {
             Utils().openDialog(CarRepairsPageFour(), context);
            },
            child: Text('Proceed',
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
    );
  }
}
