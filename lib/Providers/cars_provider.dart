import 'dart:convert';

import 'package:finden/Models/models.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class CarsProvider extends ChangeNotifier {
  String? modelo = '';
  String? placa = '';
  String _baseUrl = 'ruffsstudios.com';
  String? myToken = '';
  final carsFormKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  CarsModel? carFound;

  CarsProvider() {
    print('CarsProvider starts');
  }
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    });

    return response.body;
  }

  getCars() async {
    final jsonData =
        await this._getJsonData('api_carros/public/api/v1/cars/' + this.placa!.toUpperCase());
    final Map<String, dynamic> data = json.decode(jsonData);
    print('response' + jsonData);
    if (data.containsKey('car')) {
      print('car found ' + jsonData);
      carFound = CarsModel.fromJson(jsonData);
      print('license ' + carFound!.car.licensePlate.toString());
      Constants.carFound = carFound;

      Constants.license = carFound!.car.licensePlate.toString();
    } else {
      carFound = null;
      print('message ' + data['message']);
    }
    notifyListeners();
  }

  bool isValidForm() {
    return carsFormKey.currentState?.validate() ?? false;
  }
}
