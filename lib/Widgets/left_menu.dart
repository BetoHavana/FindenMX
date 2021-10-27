/*import 'package:finden/Pages/pages.dart';
import 'package:finden/Routes/routes.dart';
import 'package:flutter/material.dart';
void main() => runApp(Menu());

class Menu extends StatelessWidget {
  final appTitle = 'Drawer Demo';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      routes: getApplicationRoutes(),
      initialRoute: '/',
      home: MyHomePage(title: appTitle),
      theme: ThemeData(
        primaryColor: Color(0xFF6200EE),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedDestination = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      
      drawer: Drawer(
        child: SafeArea(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Header',
                  style: textTheme.headline6,
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text('Encuentra tu auto'),
                selected: _selectedDestination == 0,
                onTap: () => selectDestination(0, 'findcar'),
              ),
              ListTile(
                leading: Icon(Icons.delete),
                title: Text('Item 2'),
                selected: _selectedDestination == 1,
                onTap: () => selectDestination(1,''),
              ),
              ListTile(
                leading: Icon(Icons.label),
                title: Text('Item 3'),
                selected: _selectedDestination == 2,
                onTap: () => selectDestination(2,''),
              ),
              Divider(
                height: 1,
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Label',
                ),
              ),
              ListTile(
                leading: Icon(Icons.bookmark),
                title: Text('Item A'),
                selected: _selectedDestination == 3,
                onTap: () => selectDestination(3,''),
              ),
            ],
          ),
        ),
      ),
      body: Text('') //FindCarPage(),
    );
  }

  void selectDestination(int index, String route) {
    setState(() {
      _selectedDestination = index;
      Navigator.pushReplacementNamed(context, route, arguments: '');
    });
  }
}*/
