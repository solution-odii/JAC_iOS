import 'package:jac/Models/BookingHistoryModel.dart';
import 'package:jac/Models/carServiceCenters.dart';
import 'package:jac/Models/carsList.dart';

class Constants {
  static CarListTypes carListType = new CarListTypes();

  static CarServiceCenterList carServicePersonsList = new CarServiceCenterList();

  //static HistoryList loadedBookingHistoryList = new HistoryList();
  static List<BookingHistoryModel> loadedBookingHistoryList = new List();

  static List<CarServiceCenters> loadedCarServiceCenters = new List();

  static List<CarTypes> carCodes = new List();

  static List<CarTypes> carDescription = new List();


}