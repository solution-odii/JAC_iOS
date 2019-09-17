import 'package:flutter/material.dart';
import 'package:jac/Constants/mycolors.dart';



class Utils{

  openDialog(Widget widget, BuildContext context){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return widget;
        }
    );
  }


  void showErrorDialog(BuildContext context, String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Notification'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              child: Text('Okay'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ));
  }


}


class BeautifulAlertDialog extends StatelessWidget{
 final String assetImage, firstText, secondText,  confirmText;

 BeautifulAlertDialog({
  @required this.assetImage,
  @required this.firstText,
  @required this.secondText,
   @required this.confirmText
});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(25.0),
            color: Colors.white,
          ),
          height: 300.0,

          child: Column(
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              Center(
                child: Image(image: AssetImage(assetImage),
                  height: 50,
                  width: 50,),
              ),

              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(firstText,
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22.0, color: Colors.black),),
              ),

              SizedBox(
                height: 20,
              ),
              Center(
                child: Text(secondText,
                  style: TextStyle(fontWeight: FontWeight.w100, fontSize: 14.0, color: Colors.black),),
              ),

              SizedBox(
                height: 30,
              ),
              Center(
                child: MaterialButton(
                  height: 50.0,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(confirmText,
                      style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  color: MyColors.designColor,
                  padding: EdgeInsets.symmetric(
                    horizontal: 80.0,
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
        ),
      ),

    );

  }
}