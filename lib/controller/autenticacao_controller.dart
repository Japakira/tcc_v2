import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/services/auth_service.dart';

class AutenticacaoController extends GetxController {
  final AuthService authService = Get.put(AuthService());
  final email = TextEditingController();
  final senha = TextEditingController();

  Future<void> login() async {
    await authService.login(email.text, senha.text);
  }

  Future<void> logout() async {
    await authService.logout();
  }
}
