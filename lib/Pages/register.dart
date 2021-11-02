import 'package:finden/Models/models.dart';
import 'package:finden/Providers/providers.dart';
import 'package:finden/Widgets/circles_background.dart';
import 'package:finden/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:finden/Decorations/input_decorations.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String? token = ModalRoute.of(context)!.settings.arguments.toString();
    return Scaffold(
        appBar: AppBar(
          title: Text('Registrate'),
          backgroundColor: Color.fromRGBO(2, 82, 116, 1),
        ),
        drawer: returnWidgetIfLogged(token!, context),
        body: SafeArea(
          child: CirclesBackground(
              shouldShowHeader: false,
              top: -30,
              right: 100,
              bottom: -100,
              left: 100,
              child: SingleChildScrollView(
                  child: Column(
                children: [
                  ChangeNotifierProvider(
                      create: (_) => RegisterProvider(),
                      child: _RegisterCard(child: _RegisterForm(token: token)))
                ],
              ))),
        ));
  }
}

Widget returnWidgetIfLogged(String token, BuildContext context) {
  if (Constants.isLogged) {
    return MenuWidget(token: token);
  } else {
    return Drawer(
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
                leading: Icon(Icons.arrow_back),
                title: Text('Regresar'),
                onTap: () => {
                      if (Constants.trysToFindCar && !Constants.isLogged)
                        {
                          Navigator.pushReplacementNamed(context, 'findcar',
                              arguments: '')
                        }
                      else
                        {
                          Navigator.pushReplacementNamed(context, '/',
                              arguments: '')
                        }
                    }),
          ],
        ),
      ),
    );
  }
}

class _RegisterCard extends StatelessWidget {
  final Widget child;

  const _RegisterCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        height: 600,
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

class _RegisterForm extends StatelessWidget {
  final token;
  const _RegisterForm({Key? key, this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final registerFormProvider = Provider.of<RegisterProvider>(context);
    final login = LoginFormProvider();
    return Container(
      child: Form(
        key: registerFormProvider.registerFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'John',
                    labelText: 'Nombre',
                    prefixIcon: Icons.badge_outlined),
                onChanged: (value) => registerFormProvider.name = value,
                validator: (value) {}),
            SizedBox(height: 30),
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'Doe',
                    labelText: 'Apellidos',
                    prefixIcon: Icons.badge_outlined),
                onChanged: (value) => registerFormProvider.lastname = value,
                validator: (value) {}),
            SizedBox(height: 30),
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: 'user@example.com',
                    labelText: 'e-mail',
                    prefixIcon: Icons.email),
                onChanged: (value) => registerFormProvider.email = value,
                validator: (value) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'El valor ingresado no luce como un correo';
                }),
            SizedBox(height: 30),
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '*****',
                    labelText: 'Contraseña',
                    prefixIcon: Icons.lock),
                onChanged: (value) => registerFormProvider.password = value,
                validator: (value) {
                  return (value != null && value.length >= 8)
                      ? null
                      : 'La contraseña debe tener 8 carateres o más';
                }),
            SizedBox(height: 30),
            TextFormField(
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: InputDecorations.authInputDecoration(
                    hintText: '*******',
                    labelText: 'Confirmar Contraseña',
                    prefixIcon: Icons.lock),
                onChanged: (value) => registerFormProvider.passwordConf = value,
                validator: (value) {
                  return (value != null &&
                          value == registerFormProvider.password)
                      ? null
                      : 'Las contraseñas no coinciden';
                }),
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
                      registerFormProvider.isLoading ? 'Espere' : 'Registrar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: registerFormProvider.isLoading
                    ? null //() => Center(child: CircularProgressIndicator(color:Colors.black))
                    : () async {
                        FocusScope.of(context).unfocus();
                        if (!registerFormProvider.isValidForm()) return;

                        registerFormProvider.isLoading = true;
                        await registerFormProvider.registerUser();
                        registerFormProvider.isLoading = false;

                        if (registerFormProvider.registeredUser != null) {
                            login.email = registerFormProvider.email!;
                            login.password = registerFormProvider.password!;
                            await login.getToken();
                            final loginToken = login.myToken;
                            AlertMsg.showSuccessAlert(
                              context,
                              'Registrado', 
                              'Registro exitoso',
                              loginToken.toString(),
                              Constants.isInitialRegistered == true ? '/':'payments');
                            Constants.isLogged = true;
                        } else {
                          AlertMsg.showErrorAlert(
                            context,
                            'Intenta nuevamente, verifica tus datos',
                            registerFormProvider.errorsList.toString());
                          registerFormProvider.errorsList.clear();
                        }
                      })
          ],
        ),
      ),
    );
  }

  
}
