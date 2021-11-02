import 'package:finden/Models/models.dart';
import 'package:finden/Providers/providers.dart';
import 'package:finden/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CarsFound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final String? token = ModalRoute.of(context)!.settings.arguments.toString();
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => CarsFoundProvider(token!), lazy: false),
      ],
      child: CarsFoundPage(token: token,),
    );
  }
}

class CarsFoundPage extends StatelessWidget {
  final String? token;

  const CarsFoundPage({Key? key, this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tús busquedas'),
          backgroundColor: Color.fromRGBO(2, 82, 116, 1),
        ),
        drawer: MenuWidget(token: token),
        body: CirclesBackground(
            shouldShowHeader: false,
            top: -30,
            right: 100,
            bottom: -100,
            left: 100,
            child: SingleChildScrollView(
                child: Column(
              children: [
                _CarsFoundCard(child: renderWidget()),
              ],
            ))));
  }
  Widget renderWidget(){
    if(Constants.isLogged){
      return _CarsFoundColumns();
    }else {
       return Container(
        width: 600,
        height: 600,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 300),
              CircularProgressIndicator(
                backgroundColor: Colors.grey,
                strokeWidth: 5,
              ),
              SizedBox(height: 20),
              Text('Inicia sesión para ver esta sección')
            ],
          ),
        ),
      );
    }
  }
}


class _CarsFoundCard extends StatelessWidget {
  final Widget child;

  const _CarsFoundCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: double.infinity,
        height: 650,
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(20),
        decoration: _createCardShape(),
        child: this.child,
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
          color: Color.fromRGBO(255, 255, 255, .9),
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 15,
              offset: Offset(0, 5),
            )
          ]);
}

class _CarsFoundColumns extends StatelessWidget {
  const _CarsFoundColumns({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final carsFound = Provider.of<CarsFoundProvider>(context);
    if(carsFound.carspaid.length > 0){
      return SingleChildScrollView(
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
                child: Text('Día Búsqueda',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
            Container(
                alignment: Alignment.center,
                child: Text('Contacto',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ))),
          ]),
          for (var data in carsFound.carspaid)
            TableRow(children: [
              Container(alignment: Alignment.center,child: Text(data.carPaymentInfo.licensePlate)),
              Container(
                alignment: Alignment.center,
                child: Text(DateFormat('dd-MM-yyyy')
                    .format(data.carPaymentInfo.createdAt)),
              ),
              Container(alignment: Alignment.center,child: Text(data.corralonInfo.email)),
            ])
        ],
      ),
    );
    } else {
      return Container(
        width: 600,
        height: 600,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 300),
              CircularProgressIndicator(
                backgroundColor: Colors.grey,
                strokeWidth: 5,
              ),
              SizedBox(height: 20),
              Text('Realiza una búsqueda para ver esta sección')
            ],
          ),
        ),
      );
    }
    
  }
}
