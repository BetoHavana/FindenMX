import 'package:finden/Models/models.dart';
import 'package:finden/Providers/providers.dart';
import 'package:finden/Decorations/input_decorations.dart';
import 'package:finden/Widgets/circles_background.dart';
import 'package:finden/Widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginFormProvider objLoginProvider = new LoginFormProvider();
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
    return Scaffold(
        body: CirclesBackground(
            shouldShowHeader: true,
            top: 200,
            right: -100,
            bottom: 400,
            left: -100,
            child: SingleChildScrollView(
                child: Column(
              children: [
                SizedBox(height: 250),
                CardContainer(
                    child: Column(
                  children: [
                    SizedBox(height: 10),
                    Text('Iniciar Sesión',
                        style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 30),
                    ChangeNotifierProvider(
                        create: (_) => LoginFormProvider(), child: _LoginForm())
                  ],
                )),
                SizedBox(height: 20),
                TextButton(
                    onPressed: () async {
                      Constants.isInitialRegistered = true;
                      Navigator.pushReplacementNamed(context, 'register',
                          arguments: '');
                    },
                    child: Text('¿No estás registrado?, crea una cuenta',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black))),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
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
                        )),
                    TextButton(
                        onPressed: visible == true
                            ? null
                            : () async {
                                loadProgress();
                                await objLoginProvider.loginAsInvite();
                                loadProgress();
                                if (objLoginProvider.myToken != null) {
                                  Constants.isLogged = false;
                                  Navigator.pushReplacementNamed(
                                      context, 'findcar',
                                      arguments: objLoginProvider.myToken);
                                }
                              },
                        child: Text('Entrar como invitado',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black))),
                  ],
                ),
              ],
            ))));
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                  hintText: 'john.doe@gmail.com',
                  labelText: 'Correo electrónico',
                  prefixIcon: Icons.alternate_email_rounded),
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecorations.authInputDecoration(
                hintText: '*****',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe de ser de 6 caracteres';
              },
            ),
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
                      loginForm.isLoading ? 'Espere' : 'Ingresar',
                      style: TextStyle(color: Colors.white),
                    )),
                onPressed: loginForm.isLoading
                    ? null
                    : () async {
                      
                        FocusScope.of(context).unfocus();
                        if (!loginForm.isValidForm()) return;
                        loginForm.isLoading = true;
                        await loginForm
                            .getToken(); //Future.delayed(Duration(seconds: 2 ));
                        loginForm.isLoading = false;
                        if (loginForm.myToken != null) {
                          Constants.isLogged = true;
                          Navigator.pushReplacementNamed(context, 'findcar',
                              arguments: loginForm.myToken);
                        } else {
                          AlertMsg.showErrorAlert(
                              context,
                              'Usuario no encontrado',
                              'Revisa tu correo y contraseña');
                        }
                      })
          ],
        ),
      ),
    );
  }

  
}
