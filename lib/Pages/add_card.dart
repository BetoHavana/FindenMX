import 'package:finden/Decorations/input_decorations.dart';
import 'package:finden/Providers/providers.dart';
import 'package:finden/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_brand.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';

class AddCardPage extends StatefulWidget {
  final String? token;

  const AddCardPage({this.token});
  @override
  State<StatefulWidget> createState() {
    return AddCardPageState();
  }
}

class AddCardPageState extends State<AddCardPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  OutlineInputBorder? border;
  final cardformKey = GlobalKey<FormState>();

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
  void initState() {
    border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.grey.withOpacity(0.7),
        width: 2.0,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cardManagerProvider = new CardManagerProvider(
        widget.token.toString()); //widget.token.toString());
    return Scaffold(
        appBar: AppBar(
          title: Text('Agregar método de pago'),
          backgroundColor: Color.fromRGBO(2, 82, 116, 1),
        ),
        drawer: MenuWidget(token: widget.token),
        body: SafeArea(
            child: CirclesBackground(
          shouldShowHeader: false,
          top: -200,
          right: -300,
          bottom: -200,
          left: -300,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 5,
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
                isHolderNameVisible: true,
                cardBgColor: Colors.red,
                backgroundImage: 'assets/bg5.png',
                isSwipeGestureEnabled: true,
                labelCardHolder: 'NOMBRE',
                onCreditCardWidgetChange: (CreditCardBrand creditCardBrand) {},
              ),
              _CarBrowserCard(
                  child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: cardformKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          isHolderNameVisible: true,
                          isCardNumberVisible: true,
                          isExpiryDateVisible: true,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          themeColor: Colors.blue,
                          textColor: Colors.black,
                          cvvValidationMessage: 'CVV inválido',
                          dateValidationMessage: 'Fecha vto. inválida',
                          numberValidationMessage: 'Número Inválido',
                          cardNumberDecoration:
                              InputDecorations.authInputDecoration(
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                  labelText: 'Número',
                                  prefixIcon: Icons.credit_card)
                          /*InputDecoration(
                                    labelText: 'Number',
                                    hintText: 'XXXX XXXX XXXX XXXX',
                                    hintStyle: const TextStyle(color: Colors.white),
                                    labelStyle: const TextStyle(color: Colors.white),
                                    focusedBorder: border,
                                    enabledBorder: border,
                                  )*/
                          ,
                          expiryDateDecoration:
                              InputDecorations.authInputDecoration(
                                  hintText: 'MM/AA',
                                  labelText: 'Fecha vto.',
                                  prefixIcon: Icons.calendar_today),
                          cvvCodeDecoration:
                              InputDecorations.authInputDecoration(
                                  hintText: '123',
                                  labelText: 'CVV',
                                  prefixIcon: Icons.confirmation_number),
                          cardHolderDecoration:
                              InputDecorations.authInputDecoration(
                                  hintText: 'John Doe',
                                  labelText: 'Nombre',
                                  prefixIcon: Icons.badge),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Stack(
                          alignment: Alignment.topCenter,
                          children: [
                            MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                disabledColor: Colors.grey,
                                elevation: 0,
                                color: Color.fromRGBO(2, 82, 116, 1),
                                child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 80, vertical: 15),
                                    child: Text(
                                      visible == true
                                          ? 'Espere'
                                          : 'Agregar',
                                      style: TextStyle(color: Colors.white),
                                    )),
                                onPressed: visible == true
                                    ? null
                                    : () async {
                                      loadProgress();
                                        FocusScope.of(context).unfocus();
                                        if (!isValidForm(cardformKey)) return;
                                        cardManagerProvider.isLoading = true;

                                        cardManagerProvider.myToken =
                                            widget.token;
                                        cardManagerProvider.cardnumber =
                                            cardNumber.replaceAll(' ', '');
                                        if (cardHolderName == '') return;
                                        cardManagerProvider.holdername =
                                            cardHolderName;
                                        List<String> date =
                                            expiryDate.split('/');
                                        cardManagerProvider.expmon = date[0];
                                        cardManagerProvider.expyea = date[1];
                                        cardManagerProvider.cvv = cvvCode;
                                        
                                        await cardManagerProvider.addCard();
                                        loadProgress();
                                        cardManagerProvider.isLoading = false;
                                        if (cardManagerProvider.agregada) {
                                          AlertMsg.showSuccessAlert(
                                              context,
                                              'Tarjeta Añadida',
                                              'La tarjeta se añadió correctamente',
                                              widget.token.toString(),
                                              'payments');
                                          cardManagerProvider.agregada = false;
                                        } else {
                                          AlertMsg.showErrorAlert(
                                              context,
                                              'Intenta nuevamente, verifica tus datos',
                                              cardManagerProvider.errormsg.toString());
                                        }
                                      }),
                            /*Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.all(1.0),
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
                                        height: 50.0,
                                        width: 50.0,
                                      )),
                                )),*/
                          ],
                        ),
                        SizedBox(
                          height: 0,
                        ),
                        TextButton(
                            onPressed: () async {
                              Navigator.pushReplacementNamed(
                                  context, 'payments',
                                  arguments: widget.token);
                            },
                            child: Text('Volver',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)))
                      ],
                    ),
                  ),
                ],
              ))
            ],
          ),
        )));
  }

  bool isValidForm(carsFormKey) {
    return carsFormKey.currentState?.validate() ?? false;
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
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
        height: 440,
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.all(10),
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
