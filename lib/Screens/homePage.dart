import 'package:flutter/material.dart';
import 'package:jac/Screens/carServiceScreen.dart';
import 'package:jac/Screens/carShowroom.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
            ),),),
              SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Icon(
                      Icons.person_pin,
                      size: 35.0,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(
                      Icons.more_vert,
                      size: 35.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Center(
                child: Text(
                  'Hi, User',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
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
                    color: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.0))),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.directions_car,
                          color: Colors.white,
                        ),
                        Text(
                          '  Next Service',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20.0),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200.0,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CarShowroom()),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.directions_car, color: Colors.redAccent),
                              Text(
                                'Car Showroom',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Icon(Icons.arrow_forward_ios, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Icon(Icons.directions_car, color: Colors.redAccent),
                            Text(
                              'Buy Spare Parts',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.0),
                            ),
                            Icon(Icons.arrow_forward_ios, color: Colors.black),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CarServicePage(),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Icon(Icons.directions_car, color: Colors.redAccent),
                              Text(
                                'Car Service',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20.0),
                              ),
                              Icon(Icons.arrow_forward_ios, color: Colors.black),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        ],
      ),
    );
  }
}
