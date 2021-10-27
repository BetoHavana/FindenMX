import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;
  const AuthBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _PurpleBox(),
          _HeaderIcon(),
          this.child,
        ],
      ),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),
      child: Icon(Icons.person_pin, color: Colors.white, size: 100),
    ));
  }
}

class _PurpleBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity,//size.height * 0.4,
      //decoration: _purpleBackground(),
      child: Stack(
        children: [
          
          Positioned(child: _Bubble(
            itsColor:Color.fromRGBO(34, 162, 191, 1)////Color.fromRGBO(255, 255, 100, 0.05)
          ), top: 300, left: -90),
          Positioned(child: _Bubble(
            itsColor:Color.fromRGBO(2, 82, 116, 1)
          ), top: -70, left: -90),
          
          /*Positioned(child: _Bubble(), top: 80, left: 40),
          Positioned(child: _Bubble(), bottom: 50, right: 20),
          Positioned(child: _Bubble(), top: 100, left: 40),
          Positioned(child: _Bubble(), top: 20, left: 40)*/
        ],
      ),
    );
  }

  BoxDecoration _purpleBackground() => BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromRGBO(63, 63, 156, 1),
        Color.fromRGBO(90, 70, 178, 1)
      ]));
}

class _Bubble extends StatelessWidget {
  final Color itsColor;

  const _Bubble({Key? key, required this.itsColor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 600,
      height: 600,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(600),
          color: itsColor),
    );
  }
}
