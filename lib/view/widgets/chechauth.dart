import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/services/auth_service.dart';
import '../pages/main_page.dart';
import '../pages/login_page.dart';

class CheckAuth extends StatelessWidget {
  final AuthService authService = Get.put(AuthService());

  CheckAuth({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => authService.userIsAuthenticated.value ? MainPage() : LoginPage(),
    );
  }
}
