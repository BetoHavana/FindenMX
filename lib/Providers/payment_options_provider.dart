import 'dart:convert';
import 'package:finden/Models/models.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class PaymentOptionsProvider extends ChangeNotifier {
  String _baseUrl = 'ruffsstudios.com';
  String? myToken = '';
  CardsModel? myCards;
  List<dynamic> cardsList = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? holdername = "";
  String? cardnumber = "";
  String? cvv = "";
  String? expmon = "";
  String? expyea = "";
  final paymentOpFormKey = new GlobalKey<FormState>();

  PaymentOptionsProvider(String token) {
    print('PaymentOptionsProvider starts');
    print('token payment ' + token);
    this.myToken = token;
    this.getCards();
  }
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    });
    print('cards response ' + response.body);
    return response.body;
  }

  getCards() async {
    final jsonData =
        await this._getJsonData('api_carros/public/api/v1/openpay/cards');
    final Map<String, dynamic> data = json.decode(jsonData);
    if (data.containsKey('cards')) {
      print('true' + jsonData);
      myCards = CardsModel.fromJson(jsonData);
      cardsList = CardsModel.fromJson(jsonData).cards;
    } else {
      myCards = null;
      //print('errors ' + data['errors']);
    }
    notifyListeners();
  }


  bool isValidForm() {
    return paymentOpFormKey.currentState?.validate() ?? false;
  }
}
