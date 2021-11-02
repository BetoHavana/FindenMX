import 'package:finden/Models/models.dart';
import 'package:finden/Providers/providers.dart';
import 'package:finden/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class CardSwiper extends StatefulWidget {
  final List<dynamic> cards;
  final token;
  const CardSwiper({
    Key? key,
    required this.cards,
    required this.token,
  }) : super(key: key);

  @override
  State<CardSwiper> createState() => _CardSwiperState();
}

class _CardSwiperState extends State<CardSwiper> {
  bool visible = false;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;
    final cardManager = CardManagerProvider(widget.token);
    var currentCard;
    if (this.widget.cards.length == 0) {
      return Container(
        width: 400,
        height: 400,
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 200),
              SizedBox(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                  backgroundColor: Colors.white,
                  strokeWidth: 5,
                ),
                height: 50.0,
                width: 50.0,
              ),
              SizedBox(height: 20),
              Text('Agrega alguna tarjeta para continuar',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black))
            ],
          ),
        ),
      );
    }

    return Container(
        width: double.infinity,
        height: 400,
        child: Stack(children: [
          Swiper(
            itemCount: widget.cards.length,
            layout: SwiperLayout.STACK,
            itemWidth: 300,
            itemHeight: 300,
            itemBuilder: (_, int index) {
              currentCard = widget.cards[index];
              var originalId = currentCard.id;
              currentCard.id = 'swiper-${currentCard.id}';
              return GestureDetector(
                onTap: visible == true
                    ? null
                    : () async {
                        loadProgress();
                        cardManager.idCard =
                            currentCard.id.toString().replaceAll('swiper-', '');
                        cardManager.license = Constants.license;
                        cardManager.myToken = widget.token;
                        await cardManager.doPayment();
                        loadProgress();
                        if (cardManager.paid) {
                          AlertMsg.showSuccessAlert(
                              context, 
                              'Pago éxitoso', 
                              'Servicio Pagado\nhemos enviado un correo con la información solicitada', 
                               widget.token,
                               'findcar');
                          Constants.isPaid = true;
                        } else {
                          if(cardManager.errorPaidMsg.toString() == 'La cuenta ya fue pagada'){
                            AlertMsg.showErrorAlert(
                              context,
                              'Alerta',
                              'Esta búsqueda ya fue pagada, puedes verla en la sección de "Mis búsquedas"',
                            );
                          } else {
                          AlertMsg.showErrorAlert(
                            context,
                            cardManager.errorPaidMsg.toString()+
                            '\nContacte a soporte para mas ayuda',
                            'Hubo un error');

                          }
                        }
                      },
                child: Hero(
                  tag: currentCard.id,
                  child: Column(
                    children: [
                      CreditCard(
                          token: widget.token,
                          cardId: currentCard.id,
                          useGlassMorphism: false,
                          cardNumber: currentCard.cardNumber,
                          expiryDate: currentCard.expirationMonth +
                              '/' +
                              currentCard.expirationYear,
                          cardHolderName: currentCard.holderName,
                          cvvCode: '',
                          isCvvFocused: false,
                          useBackgroundImage: true),
                      MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          disabledColor: Colors.grey,
                          elevation: 0,
                          color: Color.fromRGBO(2, 82, 116, 1),
                          child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 30, vertical: 15),
                              child: Text(
                                visible == true ? 'Espere' : 'Eliminar',
                                style: TextStyle(color: Colors.white),
                              )),
                          onPressed: visible == true
                              ? null
                              : () async {
                                  loadProgress();
                                  cardManager.idCard = originalId
                                      .toString()
                                      .replaceAll('swiper-', '');
                                  await cardManager.deleteCard();
                                  loadProgress();
                                  widget.cards.remove(currentCard);
                                  Navigator.pushReplacementNamed(
                                      context, 'payments',
                                      arguments: widget.token);
                                })
                    ],
                  ),
                ),
              );
            },
          ),
          Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.all(150.0),
                child: Visibility(
                    maintainSize: true,
                    maintainAnimation: true,
                    maintainState: true,
                    visible: visible,
                    child: SizedBox(
                      child: CircularProgressIndicator(
                        color: Colors.blueAccent,
                        backgroundColor: Colors.white,
                        strokeWidth: 5,
                      ),
                      height: 70.0,
                      width: 70.0,
                    )),
              ))
        ]));
  }

  
}
