import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class CardManagerProvider extends ChangeNotifier {
  String _baseUrl = 'ruffsstudios.com';
  String? myToken = '';
  String? idCard = '';
  String? license = '';
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? holdername = "";
  String? cardnumber = "";
  String? cvv = "";
  String? expmon = "";
  String? expyea = "";
  String? errorPaidMsg = "";
  bool agregada = false;
  bool paid = false;
  String? errormsg = '';

  CardManagerProvider(String token) {
    print('Card Manager Provider starts');
    this.myToken = token;
  }
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> _postNewCard(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $myToken',
        },
        body: jsonEncode(<String, String>{
          'holder_name': this.holdername!,
          'card_number': this.cardnumber!,
          'cvv': this.cvv!,
          'expiration_month': this.expmon!,
          'expiration_year': this.expyea!,
        }));
    return response.body;
  }

  Future<String> _postPaymentCard(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Accept': 'application/json',
          'Authorization': 'Bearer $myToken',
        },
        body: jsonEncode(<String, String>{
          'source_id': this.idCard!,
          'device_session_id': 'a',
          'license_plate': this.license!
        }));

    print('response paid ' + response.body);
    return response.body;
  }

  Future<String> _deleteCard(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.delete(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer $myToken',
    });
    return response.body;
  }

  deleteCard() async {
    final jsonData = await this._deleteCard(
        'api_carros/public/api/v1/openpay/cards/' + idCard!.toString());
    print('borrada ' + jsonData.toString());
    notifyListeners();
  }

  addCard() async {
    final jsonData =
        await this._postNewCard('api_carros/public/api/v1/openpay/cards');
    final Map<String, dynamic> data = json.decode(jsonData);
    if (data.containsKey('code')) {
      print('error ' + data['message']);
      errormsg = data['message'].toString();
    } else {
      agregada = true;
      print('añadida ' + data['message']);
    }
    notifyListeners();
  }

  doPayment() async {
    final jsonData =
        await this._postPaymentCard('api_carros/public/api/v1/openpay/charges');
    final Map<String, dynamic> data = json.decode(jsonData);
    if (data.containsKey('id_payment')) {
      paid = true;
      print('pagada ' + data['id_payment']);
      print('msg ' + data['message']);
    } else {
      paid = false;
      errorPaidMsg = data['message'].toString();
      print('no pagada ' + data['message']);
    }
    notifyListeners();
  }
}
