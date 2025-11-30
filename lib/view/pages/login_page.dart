import 'package:flutter/material.dart';
import 'package:show_hide_password/show_hide_password.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/controller/autenticacao_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final controller = Get.put(AutenticacaoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔥 ÁREA DA IMAGEM COM FUNDO BRANCO
              Container(
                width: double.maxFinite,
                padding: const EdgeInsets.symmetric(vertical: 30),
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  children: [
                    // 🔥 SUA IMAGEM PNG
                    Image.asset(
                      "assets/images/app/branding_vetor.png",
                      height: 120,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ---------- FORMULÁRIO ----------
              const Text(
                "Usuário",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Alegreya",
                  fontSize: 25,
                ),
              ),

              SizedBox(
                height: 50,
                child: TextFormField(
                  controller: controller.email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    hintText: "Digite seu e-mail",
                    hintStyle: TextStyle(color: Colors.white),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "Senha",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Alegreya",
                  fontSize: 25,
                ),
              ),

              SizedBox(
                height: 50,
                child: ShowHidePassword(
                  passwordField: (bool hidePassword) {
                    return TextFormField(
                      controller: controller.senha,
                      obscureText: hidePassword,

                      // 🔥 ENTER envia login
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => controller.login(),

                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        hintText: "Digite sua senha",
                        hintStyle: const TextStyle(color: Colors.white),

                        // 🔥 ÍCONE BRANCO
                        suffixIcon: Icon(
                          hidePassword
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          color: Colors.white,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 40),

              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF7C9A92),
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: () => controller.login(),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Alegreya",
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
