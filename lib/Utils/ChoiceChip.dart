import 'package:flutter/material.dart';




class ChoiceSelector extends StatefulWidget {
  final AssetImage image;
  final String text;
  final bool isVehicleBrandSelected;

  ChoiceSelector(this.image, this.text, this.isVehicleBrandSelected);
  @override
  ChoiceSelectorState createState() => ChoiceSelectorState();
}

class ChoiceSelectorState extends State<ChoiceSelector> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 130,
      padding: const EdgeInsets.symmetric(
          horizontal: 55.0, vertical: 20.0),
      decoration: widget.isVehicleBrandSelected
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
        children: <Widget>[
          Image(
            image: widget.image,
            height: 40,
            width: 40,
            color: Colors.grey,
          ),
          const SizedBox(height: 15.0),
          Text(
            widget.text,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 16.0),
          ),

        ],
      ),
    );
  }
}

