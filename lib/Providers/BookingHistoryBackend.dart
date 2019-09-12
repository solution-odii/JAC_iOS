import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jac/Models/BookingHistoryModel.dart';
import 'package:jac/Constants/constants.dart';


class BookingHistoryBackend with ChangeNotifier{

  Future<void> fetchBookingHistory(int id) async{

    var url = 'http://10.2.2.47:7080/api/customer/${id}/book/details';
    var response;
    var resp;

    List<BookingHistoryModel> bookList = List();

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

      bookList = (resp as List)
      .map((i) => new BookingHistoryModel.fromJson(i)).toList();
      Constants.loadedBookingHistoryList = bookList;

    }


  }




}