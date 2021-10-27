import 'package:flutter/material.dart';

class CirclesBackground extends StatelessWidget {
  final Widget child;
  final bool shouldShowHeader;
  final double top;
  final double bottom;
  final double left;
  final double right;
  const CirclesBackground(
      {Key? key,
      required this.child,
      required this.shouldShowHeader,
      required this.top,
      required this.bottom,
      required this.left,
      required this.right})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      width: double.infinity,
      height: double.infinity,
      child: Stack(children: [
        _CirclesBox(
            top: this.top,
            bottom: this.bottom,
            left: this.left,
            right: this.right),
        shouldShowHeader ? _HeaderIcon() : new Container(width: 0, height: 0),
        this.child,
      ]),
    );
  }
}

class _HeaderIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          height: 200,
          width: 200, //double.infinity,
          margin: EdgeInsets.only(top: 20),
          child: Image(
              image: AssetImage(
                  'assets/finden_logo2.png')), //Icon(Icons.person_pin, color: Colors.white, size: 100),
        ),
      ],
    ));
  }
}

class _CirclesBox extends StatelessWidget {
  final double top;
  final double bottom;
  final double left;
  final double right;
  const _CirclesBox(
      {Key? key,
      required this.top,
      required this.bottom,
      required this.left,
      required this.right})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: double.infinity, //size.height * 0.4,
      //decoration: _purpleBackground(),
      child: Stack(
        children: [
          Positioned(
              child: _Bubble(itsColor: Color.fromRGBO(34, 162, 191, 1)),
              top: this.top,
              right: this.right),
          Positioned(
              child: _Bubble(itsColor: Color.fromRGBO(2, 82, 116, 1)),
              bottom: this.bottom,
              left: this.left),
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
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 1.5,
      height: size.width * 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(600), color: itsColor),
    );
  }
}
