import 'package:finden/Pages/add_card.dart';
import 'package:finden/Providers/providers.dart';
import 'package:finden/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PaymentOptions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? token = ModalRoute.of(context)!.settings.arguments.toString();
    return MultiProvider(providers: [
      ChangeNotifierProvider(
          create: (_) => PaymentOptionsProvider(token!), lazy: false),
    ], child: PaymentCards(token: token));
  }
}

class PaymentCards extends StatelessWidget {
  final String? token;
  const PaymentCards({Key? key, this.token}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    final cardsProvider = Provider.of<PaymentOptionsProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Tus métodos de pago'),
        backgroundColor: Color.fromRGBO(2, 82, 116, 1),
      ),
      drawer: MenuWidget(token: token),
      body: SafeArea(
          child: CirclesBackground(
        shouldShowHeader: false,
        top: -40,
        right: -300,
        bottom: 400,
        left: -300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20),
              Text('Para pagar haz clic en cualquier tarjeta',
              style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),


              CardSwiper(cards: cardsProvider.cardsList, token: token),
              
              MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  disabledColor: Colors.grey,
                  elevation: 0,
                  color: Color.fromRGBO(2, 82, 116, 1),
                  child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Text(
                        'Agregar método de pago',
                        style: TextStyle(color: Colors.white),
                      )),
                  onPressed: () => {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => AddCardPage(token: token)))
                      }),
              TextButton(
                  onPressed: () async {
                    Navigator.pushReplacementNamed(context, 'findcar',
                        arguments: token);
                  },
                  child: Text('Volver',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)))
            ],
          ),
        ),
      )),
    );
  }
}
