import 'package:finden/Models/models.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  final String? token;

  const MenuWidget({Key? key, this.token}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState(token);
}

class _MenuWidgetState extends State<MenuWidget> {
  int _selectedDestination = 0;
  final String? token;
  _MenuWidgetState(this.token);
  @override
  Widget build(BuildContext context) {
    print('token menu ' + token!);
    return Drawer(
      
      child: Container(
        color: Color.fromRGBO(2, 82, 116, 1),
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image(image: AssetImage('assets/finden_logo2.png'))),
              Divider(
                height: 1,
                thickness: 1,
                color:Colors.white
              ),
              ListTile(
                  leading: Icon(Icons.directions_car_filled_outlined,
                      color: Colors.white),
                  title: Text(
                    'Encuentra tu vehículo',
                    style: TextStyle(color: Colors.white),
                  ),
                  selected: _selectedDestination == 0,
                  onTap: () => {
                        selectDestination(0, 'findcar', token!),
                        Constants.isPaid = false,
                        Constants.carFound = null
                      }
                  //onTap: ()=> Navigator.pushReplacementNamed(context, 'findcar' ) ,
                  ),
              ListTile(
                leading: Icon(Icons.gps_fixed_rounded, color: Colors.white),
                title:
                    Text('Tus búsquedas', style: TextStyle(color: Colors.white)),
                selected: _selectedDestination == 0,
                onTap: () => {
                  selectDestination(0, 'carsfoundp', token!),
                  Constants.isPaid = false,
                  Constants.carFound = null
                }
              ),
              Divider(
                height: 1,
                thickness: 1,
                color:Colors.white
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Opciones',
                  style: TextStyle(color: Colors.white)
                ),
              ),
              ListTile(
                leading: Icon(Icons.arrow_back,color: Colors.white,),
                title: Text('Salir',style: TextStyle(color: Colors.white)),
                onTap: () =>
                    {
                      Navigator.pushReplacementNamed(context, '/', arguments: ''),
                      Constants.isPaid = false,
                      Constants.carFound = null
                    },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selectDestination(int index, String route, String arguments) {
    setState(() {
      _selectedDestination = index;
      Navigator.pushReplacementNamed(context, route, arguments: arguments);
    });
  }
}
