import 'package:flutter/material.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageFour.dart';
import 'package:jac/Components/CarServicingComponents/CarServicingPageOne.dart';
import 'package:jac/Constants/mycolors.dart';
import 'package:jac/Screens/carRepairScreen.dart';
import 'package:jac/Screens/carServicing.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jac/Database/CarModelDB.dart';
import 'package:provider/provider.dart';
import 'package:jac/Providers/BookingHistoryBackend.dart';
import 'package:jac/Models/BookingHistoryModel.dart';
import 'package:jac/Constants/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiver/strings.dart';
import 'package:jac/Components/CarRepairsComponents/CarRepairsPageFour.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  SharedPreferences sharedPreferences;
  String username = 'User';
  int userId;


  Future<void> getUserDetails(String user, int id) async {
    sharedPreferences = await SharedPreferences.getInstance();
    user = sharedPreferences.get('FirstName');
    id = sharedPreferences.getInt('id');

    username = user;
    userId = id;
    CarRepairsPageFour.userID = id;
    CarServicingPageOneState.userID = id;
    CarServicingPageFour.userID = id;

//    await Provider.of<BookingHistoryBackend> (context, listen: false).fetchBookingHistory(
//        userId
//    );
  }

  Future<List<BookingHistoryModel>> _fetchUsers() async {
    var url = 'http://10.2.2.47:7080/api/customer/${userId}/book/details';
    var response = await http.get(url);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<BookingHistoryModel> listOfUsers =
          items.map<BookingHistoryModel>((json) {
        return BookingHistoryModel.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  Future<void> submitFetchBookingHistory() async {
    await Provider.of<BookingHistoryBackend>(context, listen: false)
        .fetchBookingHistory(userId);
  }

  @override
  void initState() {
    getUserDetails(username, userId);
   // submitFetchBookingHistory();
    CarsDatabase.carsDatabase.getCarCodes();
    //CarsDatabase.carsDatabase.getVehicleType('SUV');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    try {
      submitFetchBookingHistory();
    } catch (e) {}

    print(username);
    print(userId);
    List<BookingHistoryModel> historyList =
        Constants.loadedBookingHistoryList.toList();

    var status;

    var statusPending = CircleAvatar(
      backgroundColor: Colors.white,
      // image: AssetImage("assets/images/group_337.png"),
      radius: 15.0,
      child: Image.asset("assets/images/group_337.png"),
    );

    var statusSuccess = CircleAvatar(
        backgroundColor: Colors.white,
        //image: AssetImage("assets/images//success.png"),
        radius: 15.0,
        child: Image.asset("assets/images/success.png"));



    return Scaffold(
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
                        fontSize: 22.0),
                  ),
                ),
                SizedBox(
                  height: 0.0,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: RaisedButton(
                      onPressed: () {},
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(30.0))),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            color: MyColors.designColor,
                          ),
                          Text(
                            '  20, Adeola Odeku Street, VI',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w200,
                                fontSize: 18.0),
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
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 55.0, vertical: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: MyColors.designColor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  image: new AssetImage(
                                      'assets/images/surface_1.png'),
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(height: 15.0),
                                Text(
                                  "Repairs",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0),
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            print(historyList);
                            print(historyList);

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarRepairScreen()),
                            );
                          },
                        ),
                        GestureDetector(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 55.0, vertical: 20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              color: Colors.white,
                            ),
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
                                      fontSize: 16.0),
                                )
                              ],
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
                      ],
                    ),
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          'Service History',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 20.0,
                          fontFamily: 'Muli'
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          'See all',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100,
                              fontSize: 20.0),
                        ),
                      )
                    ],
                  ),
                ),

                //TODO: ADD the Booking History here

                SizedBox(
                  height: 350,
                  child: ListView.builder(
                      itemCount: historyList.length,
                      itemBuilder: (BuildContext context, int index) {
                        BookingHistoryModel model = historyList[index];
                        if (equalsIgnoreCase(
                            model.carServicingStatus, 'SUCCESS')) {
                          status = statusSuccess;
                        } else {
                          status = statusPending;
                        }
                        return Padding(
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
                                    children: <Widget>[
                                      Text(
                                        model.serviceType.trim(),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        model.date,
                                        style: TextStyle(
                                          fontSize: 16,
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
                        );
                      }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
