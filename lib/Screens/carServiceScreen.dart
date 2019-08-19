import 'package:flutter/material.dart';
import 'package:jac/Screens/homePage.dart';
import 'package:intl/intl.dart' show DateFormat;

class CarServicePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CarServiceState();
}

class CarServiceState extends State<CarServicePage> {
  List<String> locations = ['Owerri', 'Lagos'];
  String selectedLocation;

  List<String> vehicle = ['SUV', 'Wagon'];
  String selectedVehicle;

  DateTime selectedDate =DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
        
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });    
  }


 Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime)
      setState(() {
        selectedTime = picked;
      });
    
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context, MaterialPageRoute(
                        builder: (context)=>HomePage(),
                      ),);
                    },
                    child: Icon(Icons.arrow_back_ios, color: Colors.black),
                  ),
                ),
                Text(
                  'Car Service',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(
                    Icons.more_vert,
                    color: Colors.black,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 40.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  // padding: EdgeInsets.symmetric(horizontal: 10.0),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15.0),
                  //   border: Border.all(
                  //       color: Colors.red, style: BorderStyle.solid, width: 0.80),
                  // ),
                  onPressed: null,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: DropdownButton(
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 90.0),
                              child: Icon(Icons.arrow_drop_down,
                                  color: Colors.redAccent),
                            ),
                            hint: Text('Select Car Service Location'),
                            value: selectedLocation,
                            onChanged: (newValue) {
                              setState(() {
                                selectedLocation = newValue;
                              });
                            },
                            items: locations.map((location) {
                              return DropdownMenuItem(
                                child: Text(location),
                                value: location,
                              );
                            }).toList()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  // padding: EdgeInsets.symmetric(horizontal: 10.0),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15.0),
                  //   border: Border.all(
                  //       color: Colors.red, style: BorderStyle.solid, width: 0.80),
                  // ),
                  onPressed: null,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.directions_bus,
                        color: Colors.redAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: DropdownButton(
                            icon: Padding(
                              padding: const EdgeInsets.only(left: 180.0),
                              child: Icon(Icons.arrow_drop_down,
                                  color: Colors.redAccent),
                            ),
                            hint: Text('Vehicle Type'),
                            value: selectedVehicle,
                            onChanged: (newValue) {
                              setState(() {
                                selectedVehicle = newValue;
                              });
                            },
                            items: vehicle.map((vehicles) {
                              return DropdownMenuItem(
                                child: Text(vehicles),
                                value: vehicles,
                              );
                            }).toList()),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    //shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(45.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.date_range,
                        color: Colors.pinkAccent,
                      ),
                      Text(
                        '  ${DateFormat.yMMMd().format(selectedDate)}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                
              ),
            ),

            SizedBox(
              height: 0.0,
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 50.0,
                  decoration: BoxDecoration(
                    //shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(45.0),
                    border: Border.all(color: Colors.black),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        Icons.access_time,
                        color: Colors.pinkAccent,
                      ),
                      Text(
                        '  ${selectedTime.toString()}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      InkWell(
                        onTap: () => _selectTime(context),
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.pinkAccent,
                        ),
                      ),
                    ],
                  ),
                ),
                
              ),
            ),



            SizedBox(
              height: 10.0,
            ),
            RaisedButton(
              onPressed: () {},
              child: Text('Confirm Schedule',
                  style: TextStyle(color: Colors.white)),
              color: Colors.pinkAccent,
              padding: EdgeInsets.symmetric(
                horizontal: 62.0,
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

//  Center(
//   child: Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: RaisedButton(
//       onPressed: () {},
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(30.0))),
//       child: Row(
//         children: <Widget>[
//           Icon(
//             Icons.calendar_today,
//             color: Colors.redAccent,
//           ),
//           Text(
//             '  Booking date',
//             style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20.0),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),

//  Center(
//   child: Padding(
//     padding: const EdgeInsets.all(20.0),
//     child: RaisedButton(
//       onPressed: () {},
//       color: Colors.white,
//       shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.all(Radius.circular(30.0))),
//       child: Row(
//         children: <Widget>[
//           Icon(
//             Icons.calendar_today,
//             color: Colors.redAccent,
//           ),
//           Text(
//             '  Booking time',
//             style: TextStyle(
//                 color: Colors.black,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20.0),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
