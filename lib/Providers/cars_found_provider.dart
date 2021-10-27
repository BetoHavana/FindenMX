import 'package:finden/Models/models.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class CarsFoundProvider extends ChangeNotifier {
  String _baseUrl = 'ruffsstudios.com';
  String? myToken = '';
  List<Payment> carspaid = [];


  CarsFoundProvider(String token) {
    print('CarsFoundProvider starts');
    myToken = token;
    print('mytoken ' + myToken!);
    this.getCarsFound();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    });
    print('RESPONSE ' + response.body);
    return response.body;
  }

  getCarsFound() async {
    final jsonData = await this._getJsonData('api_carros/public/api/v1/payments');
    final carFound = CarsFoundModel.fromJson(jsonData);
    carspaid = carFound.payments;
    if (carspaid.length > 0) {
      print('corralonEmail ' + carspaid[0].carPaymentInfo.licensePlate);
    }
    notifyListeners();
  }
}
