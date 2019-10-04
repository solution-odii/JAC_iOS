import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jac/Components/EmergencyServiceComponents/CallEmergencyCenterDialog.dart';
import 'package:jac/Components/EmergencyServiceComponents/EmergencyResponseCallDialog.dart';
import 'package:jac/Constants/Constants.dart';
import 'package:jac/Models/EmergencyCentersModel.dart';
import 'package:jac/Utils/DialogUtil.dart';


class EmergencyServiceBackend with ChangeNotifier{


  Future<void> fetchEmergencyCenters() async{

    final url = Constants.baseURL+'/api/emergency/list';
    var response;
    var resp;

    List<EmergencyCenterModel> emergencyList = List();

    try {
      response = await http.get(
        url,
        headers: {'Accept' : 'application/json'},
      );

      print(jsonDecode(response.body));
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }

    if(response.statusCode==200){
      resp = jsonDecode(response.body);

      emergencyList = (resp as List)
          .map((i) => new EmergencyCenterModel.fromJson(i)).toList();
      Constants.loadedEmergencyCenters = emergencyList;

    }


  }


//  dialog(BuildContext context) {
//    Utils().openDialog(EmergencyResponseCallDialog(emergencyPhoneNumber), context);
//  }

  Future<void> bookEmergencyService(
      String customerId,
      String emergencyCenterId,
      String location,
      String natureOfCar,
      String phone,
      BuildContext context
     ) async {
    final url = Constants.baseURL+'/api/emergency/request';

    var response;
    var resp;

    try {
      response = await http.post(
        url,
        headers: {HttpHeaders.contentTypeHeader: 'application/json'},
        body: jsonEncode({
          'customerId': customerId,
          'emergencyCenterId': emergencyCenterId,
          'location': location,
          'natureOfCar': natureOfCar,
          'phone': phone
        }),
      );
      print(json.decode(response.body));
      print(json.decode(response.statusCode.toString()));
    } on Exception catch (e) {
      print(e.toString());
      CallEmergencyCenterDialogState().navigate(context, false, 'Check your Internet Connection' );
    }

    if (response.statusCode == 200) {
      resp = jsonDecode(response.body);
      CallEmergencyCenterDialogState().navigate(context, true, null);
    }else{
      CallEmergencyCenterDialogState().navigate(context, false, 'Check your Internet Connection' );
    }

  }






}