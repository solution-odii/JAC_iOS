import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class BookRepairBackend with ChangeNotifier {

  Future<void> bookRepairsServiceFetch(
      int customerId,
      String date,
      String message,
      String notificationTime,
      String serviceType,
      String serviceUsername,
      String vehicleBrand,
      String vehicleType) async {
    const url_test =
        "http://10.2.2.47:7080/api/customer/book";

    var response;
    var resp;

    try {
      response = await http.post(
        url_test,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          'customerId': customerId,
          'date': date,
          'message': message,
          'notificationTime': notificationTime,
          'serviceType': serviceType,
          'serviceUsername': serviceUsername,
          'vehicleBrand': vehicleBrand,
          'vehicleType': vehicleType,
        }),
      );
      print(json.decode(response.body));
      print(json.decode(response.statusCode.toString()));
    } on Exception catch (e) {
      print(e.toString());
    }

    if (response.statusCode == 200) {
      resp = jsonDecode(response.body);
    }

  }
}
