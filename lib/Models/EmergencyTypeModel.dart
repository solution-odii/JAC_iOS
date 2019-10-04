class EmergencyType{
  final String type;


  EmergencyType({this.type});

}

final List<EmergencyType> emergencyTypeList = [
  EmergencyType(
    type: "Breaks down due to mechanical faults"
  ),

  EmergencyType(
      type: "Unable to move due to vehicle accident"
  ),


  EmergencyType(
      type: "Run out of Fuel"
  ),


  EmergencyType(
      type: "Have a flat tyre"
  ),


];