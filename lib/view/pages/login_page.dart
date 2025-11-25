import 'package:flutter/material.dart';
import 'package:show_hide_password/show_hide_password.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/controller/autenticacao_controller.dart';
import 'package:tcc_v2/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(AutenticacaoController());

  final AuthService authService = Get.put(AuthService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Bem Vindo!",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text(
              textAlign: TextAlign.start,
              "Usuário",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Alegreya",
                fontWeight: FontWeight.normal,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 50,
              child: TextFormField(
                controller: controller.email,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  focusColor: Colors.white,
                  hintText: "Digite seu e-mail",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                maxLines: null,
                expands: true,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Text(
              textAlign: TextAlign.start,
              "Senha",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Alegreya",
                fontWeight: FontWeight.normal,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 50,
              child: ShowHidePassword(
                passwordField: (bool hidePassword) {
                  return TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Informe sua senha!';
                      } else if (value.length < 6) {
                        return 'Sua senha deve ter no mínimo 6 caracteres';
                      }
                      return null;
                    },
                    autofocus: true,
                    controller: controller.senha,
                    obscureText: hidePassword,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      focusColor: Colors.white,
                      hintText: "Digite sua senha",
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF7C9A92),
                  minimumSize: Size(200, 50),
                ),
                onPressed: () {
                  controller.login();
                },
                child: Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Alegreya",
                    fontWeight: FontWeight.normal,
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
