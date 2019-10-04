import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jac/Components/CarRepairsComponents/CarRepairsPageFour.dart';
import 'package:jac/Constants/Constants.dart';

class BookRepairBackend with ChangeNotifier {

  Future<void> bookRepairsServiceFetch(
      int customerId,
      String date,
      String message,
      String notificationTime,
      String serviceType,
      String serviceUsername,
      String vehicleBrand,
      String vehicleType,
      BuildContext context) async {
    final url = Constants.baseURL+'/api/customer/book';

    var response;
    var resp;

    try {
      response = await http.post(
        url,
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
      CarRepairsPageFour().navigate(context, false, 'Please Check Internet Connection');
    }

    if (response.statusCode == 200) {
      resp = jsonDecode(response.body);
      CarRepairsPageFour().navigate(context, true, null);
    }else{
      CarRepairsPageFour().navigate(context, false, 'Please Check Internet Connection');
    }

  }
}
