
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Providers/providers.dart';
import 'Routes/routes.dart';

void main() => runApp(AppState());


class AppState extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: ( _ ) => CarsProvider(), lazy: false ),
      ],
      child: MyApp(),
    );
  }
}


class MyApp extends StatelessWidget { 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Finden MX',
        initialRoute: '/',
        routes: getApplicationRoutes()
    );
  }
}
