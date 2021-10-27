import 'package:finden/Models/models.dart';
import 'package:finden/Providers/providers.dart';
import 'package:finden/Widgets/circles_background.dart';
import 'package:finden/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:finden/Decorations/input_decorations.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class FindCarPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? token = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text('Encuentra tu vehículo'),
          backgroundColor: Color.fromRGBO(2, 82, 116, 1),
        ),
        drawer: MenuWidget(token: token),
        body: SafeArea(
          child: CirclesBackground(
              shouldShowHeader: false,
              top: -30,
              right: 100,
              bottom: -100,
              left: 100,
              child: SingleChildScrollView(
                  child: ChangeNotifierProvider(
                      create: (_) => CarsProvider(),
                      child: Column(
                        children: [
                          _CarBrowserCard(child: _CarBrowserForm(token: token)),
                          _CarFound()
                        ],
                      )))),
        ));
  }
}

class _CarBrowserCard extends StatelessWidget {
  final Widget child;

  const _CarBrowserCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 310,
        margin: EdgeInsets.only(top: 40),
        padding: EdgeInsets.all(20),
        decoration: _createCardShape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
          color: Color.fromRGBO(
              255, 255, 255, .9), //Color.fromRGBO(0, 82, 116, .9),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}

class _CarBrowserForm extends StatelessWidget {
  final token;
  const _CarBrowserForm({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carsForm = Provider.of<CarsProvider>(context);
    return Container(
      child: Form(
        key: carsForm.carsFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '999-XYZ-A12',
                    labelText: 'Placa',
                    prefixIcon: Icons.badge_outlined),
                onChanged: (value) => carsForm.placa = value,
                validator: (value) {
                  return (value != null && value.length >= 5)
                      ? null
                      : 'La placa debe contener 5 o más letras/números';
                }),
            SizedBox(height: 30),
            TextFormField(
                autocorrect: false,
                //obscureText: true, -> to hide passwords, black dots
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Vento 2020',
                    labelText: 'Modelo',
                    prefixIcon: Icons.directions_car_filled_outlined),
                onChanged: (value) => carsForm.modelo = value,
                /*validator: (value) {
                  return (value == null || value.toString().isEmpty)
                      ? 'Ingresa un modelo válido'
                      : null;
                }*/),
            SizedBox(height: 30),
            MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                disabledColor: Colors.grey,
                elevation: 0,
                color: Color.fromRGBO(2, 82, 116, 1),
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                    child: Text(
                      carsForm.isLoading ? 'Espere' : 'Buscar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: carsForm.isLoading
                    ? null //() => Center(child: CircularProgressIndicator(color:Colors.black))
                    : () async {
                        Constants.isPaid = false;
                        Constants.carFound = null;
                        FocusScope.of(context).unfocus();
                        if (!carsForm.isValidForm()) return;
                        carsForm.isLoading = true;
                        carsForm.myToken = this.token;
                        await carsForm.getCars();
                        carsForm.isLoading = false;
                        if (carsForm.carFound != null) {
                          _showPaymentAlert(
                              context,
                              '¿Deseas continuar con el pago por \$90.00 MXN?',
                              'Vehículo encontrado',
                              this.token);
                        } else {
                          _mostrarAlert(
                              context,
                              'Intenta nuevamente, verifica la placa y modelo',
                              'No encontrado');
                        }
                      })
          ],
        ),
      ),
    );
  }

  void _mostrarAlert(BuildContext context, String textM, String title) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(textM),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  void _showPaymentAlert(
      BuildContext context, String textM, String title, String token) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)),
            title: Text(title),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(textM),
              ],
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cancelar'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              TextButton(
                child: Text('Aceptar'),
                onPressed: () {
                  if (Constants.isLogged) {
                    Navigator.pushReplacementNamed(context, 'payments',
                        arguments: token); //go
                  } else {
                    Constants.trysToFindCar = true;
                    Navigator.pushReplacementNamed(context, 'register',
                        arguments: token);
                  }
                },
              ),
            ],
          );
        });
  }
}

class _CarFound extends StatelessWidget {
  const _CarFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var car = Constants.carFound;
    if (Constants.isPaid) {
      return Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Text('Datos encontrados',
              style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
          _CarFoundBrowserCard(
              child: Table(
            children: [
              TableRow(children: [
                Container(
                  alignment: Alignment.center,
                  child: Text('Placa',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      )),
                ),
                Container(
                    alignment: Alignment.center,
                    child: Text('Modelo',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ))),
                Container(
                    alignment: Alignment.center,
                    child: Text('Día Búsqueda',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ))),
              ]),
              
              TableRow(children: [
                
                Container(alignment: Alignment.center,child: Text(car!.car.licensePlate.toString())),
                Container(alignment: Alignment.center,child: Text(car.car.model.toString())),
                Container(alignment: Alignment.center,child: Text(DateFormat('dd-MM-yyyy').format(car.car.createdAt!))),
                
              ])
            ],
          )),
        ],
      );
    } else {
      return Container();
    }
  }
}

class _CarFoundBrowserCard extends StatelessWidget {
  final Widget child;

  const _CarFoundBrowserCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 150,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(15),
        decoration: _createCardShape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
          color: Color.fromRGBO(
              255, 255, 255, .9), //Color.fromRGBO(0, 82, 116, .9),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}