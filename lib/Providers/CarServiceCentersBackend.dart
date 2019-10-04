
import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jac/Models/CarServiceCenters.dart';
import 'package:jac/Constants/Constants.dart';


class ServiceCenterBackend with ChangeNotifier{

  Future<void> fetchCarServiceCenter(String lat, String lng,
      String car
      ) async{

    final url = Constants.baseURL+'/api/customer/all/carservicing/location';

    var response;
    var resp;
    List<CarServiceCenters> serviceCenterList = List();

    try {
      response = await http.post(
        url,
          headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          'lat' : lat,
          'lng' : lng,
          'brand': car
        }),


      );
      print(json.decode(response.body));
      print(json.decode(response.statusCode.toString()));

    } on Exception catch (e) {
      print(e.toString());
    }

    if (response.statusCode ==200){
      resp = jsonDecode(response.body);

      serviceCenterList = (resp as List)
          .map((i) => new CarServiceCenters.fromJson(i)).toList();
      Constants.loadedCarServiceCenters = serviceCenterList;
    }
    CarServiceCenterList carServiceCenterList = new CarServiceCenterList.fromJson(resp);
//    print(carServiceCenterList.carServicePersonsList.toString());
//    return carServiceCenterList;
  }
}
