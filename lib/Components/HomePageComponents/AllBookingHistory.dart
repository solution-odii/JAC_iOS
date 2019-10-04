import 'package:flutter/material.dart';
import 'package:jac/Components/HomePageComponents/SelectedBookingHistory.dart';
import 'package:jac/Constants/Constants.dart';
import 'package:jac/Models/BookingHistoryModel.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:jac/Utils/Loader.dart';
import 'package:quiver/strings.dart';


class AllBookingHistory extends StatefulWidget{
  @override
  AllBookingHistoryState createState() => AllBookingHistoryState();
}

class AllBookingHistoryState extends State<AllBookingHistory> {
  @override
  Widget build(BuildContext context) {

    List<BookingHistoryModel> historyList =
    Constants.loadedBookingHistoryList.toList();

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


    // TODO: implement build

    return Scaffold(
      appBar: AppBar(
        title: Text('All Booking History',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w700,
                fontSize: 18.0)),
        centerTitle: true,
        backgroundColor: Colors.white,

        leading: InkWell(
          onTap: () {
            try {
              Navigator.pop(
                  context
              );
            } on Exception catch (e) {
              // TODO
            }
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.black,

          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[

            SizedBox(
              height: 700,
              child: ListView.builder(
                  itemCount: historyList.length,
                  itemBuilder: (BuildContext context, int index) {
                    BookingHistoryModel model = historyList[index];
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
            ),

          ],
        ),
      ),
    );
  }
}