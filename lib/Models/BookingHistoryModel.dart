class BookingHistoryModel {
  final int id;
  final int version;
  final int customerId;
  final String serviceType;
  final String checkInDate;
  final String notificationTime;
  final String serviceLocation;
  final String vehicleType;
  final String message;
  final String serviceUsername;
  final String date;
  final double mileage;
  final double lastPeriod;
  final String vehicleBrand;
  final String carServicingStatus;
  final String customer;
  final String carserving;
  final Object phoneNumber;

  BookingHistoryModel({
    this.id,
    this.version,
    this.customerId,
    this.serviceType,
    this.checkInDate,
    this.notificationTime,
    this.serviceLocation,
    this.vehicleType,
    this.message,
    this.serviceUsername,
    this.date,
    this.mileage,
    this.lastPeriod,
    this.vehicleBrand,
    this.carServicingStatus,
    this.customer,
    this.carserving,
    this.phoneNumber,
  });

  factory BookingHistoryModel.fromJson(Map<String, dynamic> json) {
    return BookingHistoryModel(
      id: json['id'],
      version: json['version'],
      customerId: json['customerId'],
      serviceType: json['serviceType'],
      checkInDate: json['checkInDate'],
      notificationTime: json['notificationTime'],
      serviceLocation: json['serviceLocation'],
      vehicleType: json['vehicleType'],
      message: json['message'],
      serviceUsername: json['serviceUsername'],
      date: json['date'],
      mileage: json['mileage'],
      lastPeriod: json['lastPeriod'],
      vehicleBrand: json['vehicleBrand'],
      carServicingStatus: json['carServicingStatus'],
      customer: json['customer'],
      carserving: json['carserving'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['version'] = this.version;
    data['customerId'] = this.customerId;
    data['serviceType'] = this.serviceType;
    data['checkInDate'] = this.checkInDate;
    data['notificationTime'] = this.notificationTime;
    data['serviceLocation'] = this.serviceLocation;
    data['vehicleType'] = this.vehicleType;
    data['message'] = this.message;
    data['mileage'] = this.mileage;
    data['lastPeriod'] = this.lastPeriod;
    data['vehicleBrand'] = this.vehicleBrand;
    data['serviceUsername'] = this.serviceUsername;
    data['date'] = this.date;
    data['carServicingStatus'] = this.carServicingStatus;
    data['customer'] = this.customer;
    data['carserving'] = this.carserving;
    data['phoneNumber'] = this.phoneNumber;

    return data;
  }
}

class HistoryList {
  final List<BookingHistoryModel> bookingHistoryList;

  HistoryList({this.bookingHistoryList});

  factory HistoryList.fromJson(List<dynamic> parsedJson){
    List<BookingHistoryModel> bookingHistoryList = new List<BookingHistoryModel>();
    bookingHistoryList = parsedJson.map((i) => BookingHistoryModel.fromJson(i)).toList();

    return new HistoryList(
      bookingHistoryList: bookingHistoryList
    );
  }
}
