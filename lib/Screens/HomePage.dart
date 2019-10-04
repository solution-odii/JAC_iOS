import 'package:flutter/material.dart';
import 'package:jac/Components/CarRepairsComponents/CarsRepairsPageOne.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageTwo.dart';
import 'package:jac/Components/EmergencyServiceComponents/CallEmergencyCenterDialog.dart';
import 'package:jac/Components/HomePageComponents/AllBookingHistory.dart';
import 'package:jac/Components/HomePageComponents/SelectedBookingHistory.dart';
import 'package:jac/Constants/MyColors.dart';
import 'package:jac/Providers/CarServiceCentersBackend.dart';
import 'package:jac/Providers/EmergencyServiceBackend.dart';
import 'package:jac/Screens/CarRepairScreen.dart';
import 'package:jac/Screens/CarServicing.dart';
import 'package:jac/Screens/EmergencyScreen.dart';
import 'package:jac/Utils/CloseApp.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:jac/Providers/BookingHistoryBackend.dart';
import 'package:jac/Models/BookingHistoryModel.dart';
import 'package:jac/Constants/Constants.dart';
import 'package:quiver/strings.dart';
import 'package:geocoder/geocoder.dart';



class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  static int userId;
  static String username;

  String lat;
  String lng;

  var userLocationAddress;

  var location = new Location();

 void local() {
    location.onLocationChanged().listen((LocationData currentLocation) async{
      print(currentLocation.latitude);
      print(currentLocation.longitude);
      lat=currentLocation.latitude.toString();
      lng = currentLocation.longitude.toString();
      CarRepairFirstPageState.lat = currentLocation.latitude.toString();
      CarRepairFirstPageState.lng = currentLocation.longitude.toString();
      CarServicingPageTwoState.lat = currentLocation.latitude.toString();
      CarServicingPageTwoState.lng = currentLocation.longitude.toString();


      final coordinates = new Coordinates(currentLocation.latitude, currentLocation.longitude);
      var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
      var getAddress = addresses.first;
      userLocationAddress = getAddress.addressLine;
      print(userLocationAddress);
      CallEmergencyCenterDialog.location = userLocationAddress.toString();
    });


  }

  Future<void> submitFetchRequest() async{

    await Provider.of<ServiceCenterBackend>(context, listen: false).fetchCarServiceCenter(
        lat,
        lng,
        'JAC_MOTORS'
    );
  }


  submitFetchBookingHistory() {
    Provider.of<BookingHistoryBackend>(context, listen: false)
        .fetchBookingHistory(userId);

  }

  loaderMan()async{
    Utils().openDialog(LoaderTwo(), context);
    await Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        Navigator.pop(context);
      });
    });
  }

  @override
  void initState(){
    loaderMan();
    submitFetchBookingHistory();
    local();
    submitFetchRequest();
    EmergencyServiceBackend().fetchEmergencyCenters();
   // CarsDatabase.carsDatabase.getCarCodes();


    super.initState();
  }



  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              height: 40.0,
              onPressed:   () => Navigator.of(context).pop(false),
              child: Text('No',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w200)),
              color: MyColors.designColor,
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
              ),
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30.0),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              height: 40.0,
              onPressed:
                  () => Navigator.of(context).pop(true),

              child: Text('Yes',
                  style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w200)),
              color: MyColors.designColor,
              padding: EdgeInsets.symmetric(
                horizontal: 30.0,
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
    ) ??
        false;
  }

//  Future<bool> _onBackPressed() {
//    return Utils().openDialog(
//        CloseAppDialog(context), context
//    ) ??
//        false;
//  }


  @override
  Widget build(BuildContext context) {
    try {
      submitFetchBookingHistory();
    } catch (e) {}

    List<BookingHistoryModel> historyList = Constants.loadedBookingHistoryList.toList();
    int numberToDisplay = historyList.length;
    if(numberToDisplay>5){
      numberToDisplay = 5;
    }

    var status;

    var statusPending = CircleAvatar(
      backgroundColor: Colors.white,
      radius: 15.0,
      child: Image.asset("assets/images/pending.png"),
    );

    var statusSuccess = CircleAvatar(
        backgroundColor: Colors.white,
        //image: AssetImage("assets/images//success.png"),
        radius: 15.0,
        child: Image.asset("assets/images/successimage.png"));

    var statusCancelled = CircleAvatar(
        backgroundColor: Colors.white,
        //image: AssetImage("assets/images//success.png"),
        radius: 15.0,
        child: Image.asset("assets/images/group_1336.png"));


    return new WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: new AssetImage(
                  "assets/images/background3.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 60.0,
                ),
                Center(
                  child: Text(
                    'Hi ' + username + ', Pick a Service',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                ),
                SizedBox(
                  height: 40.0,
                ),
//                Center(
//                  child: Padding(
//                    padding: const EdgeInsets.all(20.0),
//                    child: RaisedButton(
//                      onPressed: () {},
//                      color: Colors.white,
//                      shape: RoundedRectangleBorder(
//                          borderRadius:
//                              BorderRadius.all(Radius.circular(30.0))),
//                      child: Row(
//                        children: <Widget>[
//                          Icon(
//                            Icons.location_on,
//                            size: 16,
//                            color: MyColors.designColor,
//                          ),
//                          Text(
//                            '  Lagos, Nigeria',
//                            style: TextStyle(
//                                color: Colors.black,
//                                fontWeight: FontWeight.w200,
//                                fontSize: 16.0),
//                          ),
//                        ],
//                      ),
//                    ),
//                  ),
//                ),
                SizedBox(
                  height: 0.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: MyColors.designColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image: new AssetImage(
                                        'assets/images/repairs.png'),
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    "Repairs",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarRepairScreen()),
                            );
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            height: 100.0,
                            width: 100.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image:
                                        new AssetImage('assets/images/service.png'),
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    "Servicing",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarServicingScreen(),
                              ),
                            );
                          },
                        ),


                        GestureDetector(
                          child: Container(
                            height: 100.0,
                            width: 100.0,

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Image(
                                    image:
                                    new AssetImage('assets/images/siren.png'),
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(height: 15.0),
                                  Text(
                                    "Emergency",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14.0),
                                  )
                                ],
                              ),
                            ),
                          ),
                          onTap: () {
                            EmergencyServiceBackend().fetchEmergencyCenters();
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> EmergencyScreen()));
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0),
                        child: Text(
                          'Booking History',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 16.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30.0),
                        child: InkWell(
                          onTap: () {
                            Utils().openDialog(LoaderTwo(), context);
                             Future.delayed(const Duration(milliseconds: 1000), () {
                              setState(() {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AllBookingHistory()));
                              });
                            });
                          },
                          child: Text(
                            'See all',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                fontSize: 16.0),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                //TODO: ADD the Booking History here

                SizedBox(
                  height: 380,
                  child: FutureBuilder<Object>(
                    future: submitFetchBookingHistory(),
                    builder: (context, snapshot) {
                      return GestureDetector(
                        onHorizontalDragDown: (DragDownDetails dragDownDetails){
                          submitFetchBookingHistory();
                        },
                        child: ListView.builder(
                            itemCount: numberToDisplay,
                            itemBuilder: (BuildContext context, int index) {
                              BookingHistoryModel model = historyList[index];
                              print(historyList.toString());

                              if (equalsIgnoreCase(
                                  model.carServicingStatus, 'CONFIRMED')||equalsIgnoreCase(
                                  model.carServicingStatus, 'COMPLETED')) {
                                status = statusSuccess;
                              } else if(equalsIgnoreCase(
                                  model.carServicingStatus, 'PENDING')) {
                                status = statusPending;
                              } else if(equalsIgnoreCase(
                                  model.carServicingStatus, 'CANCELLED')) {
                                status = statusCancelled;
                              }
                              return InkWell(
                                onTap: (){
                                  SelectedBookingHistory.serviceID = model.id;
                                  Utils().openDialog(LoaderTwo(), context);
                                  Future.delayed(const Duration(milliseconds: 1000), () {
                                    setState(() {
                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                          SelectedBookingHistory(
                                          serviceStatus: model.carServicingStatus,
                                          serviceType: model.serviceType,
                                          serviceDate: model.date,
                                          serviceTime: model.notificationTime,
                                          vehicleType: model.vehicleType,
                                          vehicleModel: model.vehicleBrand,
                                          serviceCenter: model.carserving,
                                          serviceLocation: model.serviceLocation
                                      ),

                                      ));
                                    });
                                  });

                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
                                  child: Card(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                                    elevation: 3,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                model.serviceType.toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              SizedBox(
                                                height: 8,
                                              ),
                                              Text(
                                                '${model.date.toString()+ ' @ ' + model.notificationTime.toString()}',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(18.0),
                                          child: status,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
        )
    );
  }
}
