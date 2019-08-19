import 'package:flutter/material.dart';
import 'package:jac/Screens/homePage.dart';

class CarShowroom extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    
    return CarShowroomState();
  }
}

class CarShowroomState extends State<CarShowroom>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: <Widget>[
              TopPart()
          ],
        ),
    );
  }
}



class TopPart extends StatelessWidget{
  
  

  @override
  Widget build(BuildContext context) {
   
    return Column(
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
                  'Car Showroom',
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
          ],
);
  }
}