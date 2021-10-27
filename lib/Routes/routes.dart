import 'package:finden/Pages/pages.dart';
import 'package:flutter/material.dart';
Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/' : (BuildContext context) => LoginPage(),
    'findcar': (BuildContext context) => FindCarPage(),//token: ModalRoute.of(context)!.settings.arguments.toString()),
    'register': (BuildContext context) => RegisterPage(),
    'addcard': (BuildContext context) => AddCardPage(),
    'carsfound': (BuildContext context) => CarsFoundPage(),
    'carsfoundp': (BuildContext context) => CarsFound(),
    'payments' : (BuildContext context) => PaymentOptions(),
  };
}
