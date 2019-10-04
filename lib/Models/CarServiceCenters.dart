class CarServiceCenters {
  final int id;
  final String businessName;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;
  final String serviceLocation;
  final String state;
  final String lga;
  final String latitude;
  final String longitude;
  final Object city;
  final Object vehicleType;
  final Object serviceType;
  final Object emailAddress;
  final Object message;

  CarServiceCenters({this.id, this.businessName, this.username, this.firstName, this.lastName, this.email, this.phoneNumber, this.serviceLocation, this.state, this.lga, this.latitude, this.longitude, this.city, this.vehicleType, this.serviceType, this.emailAddress, this.message});

  factory CarServiceCenters.fromJson(Map<String, dynamic> json) {
    return CarServiceCenters(
        id: json['id'],
        businessName: json['businessName'],
        username: json['username'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        serviceLocation: json['serviceLocation'],
        state: json['state'],
        lga: json['lga'],
        latitude: json['latitude'],
        longitude: json['longitude'],
        city: json['city'],
        vehicleType: json['vehicleType'],
        serviceType: json['serviceType'],
        emailAddress: json['emailAddress'],
        message: json['message']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['businessName'] = this.businessName;
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    data['phoneNumber'] = this.phoneNumber;
    data['serviceLocation'] = this.serviceLocation;
    data['state'] = this.state;
    data['lga'] = this.lga;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    return data;
  }
}

class CarServiceCenterList{

  final List<CarServiceCenters> carServicePersonsList;

  CarServiceCenterList({
    this.carServicePersonsList
});

  factory CarServiceCenterList.fromJson(List<dynamic> parsedJson){
    List<CarServiceCenters> carServiceCentersList = new List<CarServiceCenters>();

    carServiceCentersList = parsedJson.map((i) => CarServiceCenters.fromJson(i)).toList();

    return new CarServiceCenterList(
      carServicePersonsList: carServiceCentersList
    );
  }
}