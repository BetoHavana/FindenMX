import 'dart:convert';

import 'package:finden/Models/models.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class RegisterProvider extends ChangeNotifier {
  String? name = '';
  String? lastname = '';
  String? email = '';
  String? password = '';
  String? passwordConf = '';
  String _baseUrl = 'ruffsstudios.com';
  String? myToken = '';
  final registerFormKey = new GlobalKey<FormState>();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  RegisterModel? registeredUser;
  RegisterErrorsModel? errors;
  List<String> errorsList = [];
  List<String> errorMap = [];
  RegisterProvider() {
    print('RegisterProvider starts');
  }
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<String> _getJsonData(String endpoint) async {
    final url = Uri.https(_baseUrl, endpoint);
    final response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': this.name!,
          'last_name': this.lastname!,
          'email': this.email!,
          'password': this.password!,
          'password_confirmation': this.passwordConf!
        }));

    return response.body;
  }

  registerUser() async {
    final jsonData =
        await this._getJsonData('api_carros/public/api/v1/auth/create');
    final Map<String, dynamic> data = json.decode(jsonData);
    print('response' + data.toString());
    if (data.containsKey('user')) {
      print('true' + jsonData);
      registeredUser = RegisterModel.fromJson(jsonData);
    } else if (data.containsKey('errors')) {
      errors = RegisterErrorsModel.fromJson(jsonData);
      print(errors);
      registeredUser = null;
      /*final String localJson = '''
      {
        "errrors": [
            {
               "password":[$data['password']]
            }
        ]
      }''';*/
      if (errors!.errors.email != null) {
        print('email ' + errors!.errors.email.toString());
        errorsList.add(errors!.errors.email.toString());
      }
      if (errors!.errors.lastName != null) {
        print('lastName ' + errors!.errors.lastName.toString());
        errorsList.add(errors!.errors.lastName.toString());
      }
      if (errors!.errors.password != null) {
        print('password ' + errors!.errors.password.toString());
        errorsList.add(errors!.errors.password.toString());
      }
      if (errors!.errors.name != null) {
        print('name ' + errors!.errors.name.toString());
        errorsList.add(errors!.errors.name.toString());
      }
      var n = 0;
      for (var item in errorsList) {
        print('item $n ' + item);
        n++;
        if (n == 3) {
          break;
        }
      }
      for (int i = 0; i < errorsList.length; i++) {
        errorsList[i] = errorsList[i].replaceAll('[', '');
      }
      for (int i = 0; i < errorsList.length; i++) {
        errorsList[i] = errorsList[i].replaceAll(']', '');
      }
      for (int i = 0; i < errorsList.length; i++) {
        errorsList[i] = errorsList[i].replaceAll(',', '\n\n');
      }
    } else {
      errorsList.add(data['message'].toString());
    }

    notifyListeners();
  }

  bool isValidForm() {
    return registerFormKey.currentState?.validate() ?? false;
  }
}
