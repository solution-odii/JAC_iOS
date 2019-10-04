import 'package:jac/Models/BookingHistoryModel.dart';
import 'package:jac/Models/CarServiceCenters.dart';
import 'package:jac/Models/CarsList.dart';
import 'package:jac/Models/EmergencyCentersModel.dart';

class Constants {
  //static String baseURL = 'http://41.219.149.51:7080';
  static String baseURL = 'http://10.2.2.47:7080';
  static CarListTypes carListType = new CarListTypes();

  static CarServiceCenterList carServicePersonsList = new CarServiceCenterList();

  //static HistoryList loadedBookingHistoryList = new HistoryList();
  static List<BookingHistoryModel> loadedBookingHistoryList = new List();

  static List<CarServiceCenters> loadedCarServiceCenters = new List();

  static List<EmergencyCenterModel> loadedEmergencyCenters = new List();

  static List<CarTypes> carCodes = new List();

  static List<CarTypes> carDescription = new List();


}