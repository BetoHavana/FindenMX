import 'package:finden/Providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class CreditCard extends StatelessWidget {
  const CreditCard(
      {Key? key,
      required this.useGlassMorphism,
      required this.cardNumber,
      required this.expiryDate,
      required this.cardHolderName,
      required this.cvvCode,
      required this.isCvvFocused,
      required this.useBackgroundImage,
      required this.cardId,
      required this.token})
      : super(key: key);

  final bool useGlassMorphism;
  final String cardNumber;
  final String expiryDate;
  final String cardHolderName;
  final String cvvCode;
  final bool isCvvFocused;
  final bool useBackgroundImage;
  final String cardId;
  final String token;

  @override
  Widget build(BuildContext context) {
    final deletecard = CardManagerProvider(token);
    deletecard.idCard = cardId;
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 30,
        ),
        CreditCardWidget(
          glassmorphismConfig:
              useGlassMorphism ? Glassmorphism.defaultConfig() : null,
          cardNumber: cardNumber,
          expiryDate: expiryDate,
          cardHolderName: cardHolderName,
          cvvCode: cvvCode,
          showBackView: isCvvFocused,
          obscureCardNumber: true,
          obscureCardCvv: true,
          isHolderNameVisible: false,
          cardBgColor: Colors.red,
          backgroundImage: useBackgroundImage ? 'assets/bg5.png' : null,
          isSwipeGestureEnabled: false,
          onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
        ),
      ],
    );
  }
}
