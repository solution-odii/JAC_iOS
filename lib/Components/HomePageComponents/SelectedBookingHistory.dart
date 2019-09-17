import 'package:flutter/material.dart';
import 'package:jac/Constants/mycolors.dart';
import 'package:jac/Components/HomePageComponents/CancelBookingDialog.dart';
import 'package:jac/Providers/CancelBookingBackend.dart';
import 'package:jac/Utils/DialogUtil.dart';
import 'package:provider/provider.dart';
import 'package:quiver/strings.dart';

class SelectedBookingHistory extends StatefulWidget{
 static int serviceID;
  final String serviceStatus;
  final String serviceType;
  final String serviceDate;
  final String serviceTime;
  final String vehicleType;
  final String vehicleModel;
  final String serviceCenter;
  final String serviceLocation;

  SelectedBookingHistory({
    @required this.serviceStatus,
    @required this.serviceType,
  @required this.serviceDate,
  @required this.serviceTime,
  @required this.vehicleType,
  @required this.vehicleModel,
  @required this.serviceCenter,
  @required this.serviceLocation,

});

  @override
  SelectedBookingHistoryState createState() => SelectedBookingHistoryState();
}

class SelectedBookingHistoryState extends State<SelectedBookingHistory> {
  var statusColor;

  bool btnEnabled = true;

  var statusPending = Colors.orangeAccent;

  var statusSuccess = Colors.green;

  var statusCancelled = MyColors.designColor;

  Future<void> cancelBookingRequest(BuildContext context) async {
    await Provider.of<CancelBookingBackend>(context, listen: false)
        .fetchCancelBooking(SelectedBookingHistory.serviceID);
  }

  @override
  Widget build(BuildContext context) {

    if (equalsIgnoreCase(
        widget.serviceStatus, 'CONFIRMED')||equalsIgnoreCase(
        widget.serviceStatus, 'COMPLETED')) {
      statusColor = statusSuccess;
    } else if(equalsIgnoreCase(
        widget.serviceStatus, 'PENDING')) {
      statusColor = statusPending;
    } else if(equalsIgnoreCase(
        widget.serviceStatus, 'CANCELLED')) {
      statusColor = statusCancelled;
    setState(() {
      btnEnabled = false;
    });
    }
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 230,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/image_2x.png",),
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
                          child: Icon(Icons.arrow_back, size: 30.0, color: Colors.black,),
                          onTap: (){
                            try {
                              Navigator.pop(context);
                            } on Exception catch (e) {
                              print(e.toString());
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


            SizedBox(
              height: 300,
              child: ListView(
                children: <Widget>[
                  /// First Container
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black12),
                        color: MyColors.designColor2,
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Service Type',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w200
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25.0),
                                    color: statusColor,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(widget.serviceStatus,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w200
                                      ),
                                    ),
                                  ),
                                )

                              ],
                            ),
                          ),


                          SizedBox(
                            height: 0.0,
                          ),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(widget.serviceType,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 21.0,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),


                                Text('${widget.serviceDate.toString()+ ' @ ' + widget.serviceTime.toString()}',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w100
                                  ),
                                ),

                              ],
                            ),
                          ),



                        ],
                      ),
                    ),
                  ),


                  /// Second Container
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black12),
                        color: MyColors.designColor2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 35.0, bottom: 35.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Vehicle Type',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    Text(':'),
                                    Text(widget.vehicleType.toUpperCase(),
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w100
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),

                            Column(
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text('Model',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700
                                      ),
                                    ),
                                    Text(':'),
                                    Text(widget.vehicleModel,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w100
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),


                  /// Third Container
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0, bottom: 5.0),
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.black12),
                        color: MyColors.designColor2,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 80.0, top: 10.0, bottom: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Service center',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w100
                              ),
                            ),

                            Text(widget.serviceCenter,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 24.0,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Icon(Icons.location_on,
                                  color: MyColors.designColor,
                                  size: 20.0,
                                ),

                                Expanded(
                                  child: Text(widget.serviceLocation,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w100
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),



            SizedBox(
              height: 30.0
            ),

            MaterialButton(
              height: 50.0,
              onPressed: () =>
                btnEnabled == true ?  Utils().openDialog(CancelAlertDialog(), context) : null,

              child: Text('Cancel Service',
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