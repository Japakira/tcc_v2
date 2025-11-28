// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/models/usuario_model.dart';
import 'package:tcc_v2/services/auth_service.dart';
import 'package:tcc_v2/services/usuario_service.dart';

class AutenticacaoController extends GetxController {
  final AuthService authService = Get.put(AuthService());
  final email = TextEditingController();
  final senha = TextEditingController();

  Rxn<Usuario> usuarioAtual = Rxn<Usuario>();

  @override
  void onInit() {
    super.onInit();
    ever(authService.currentUserRx, (_) => carregarUsuario());
    carregarUsuario();
  }

  Future<void> login() async {
    await authService.login(email.text, senha.text);
    await carregarUsuario();
  }

  Future<void> logout() async {
    await authService.logout();
    usuarioAtual.value = null;
  }

  Future<void> carregarUsuario() async {
    final auth = Get.find<AuthService>();
    final email = auth.currentUser?.email;

    if (email == null) {
      usuarioAtual.value = null;
      return;
    }

    final listaUsuarios = await UsuarioService().getUsuarioByEmail(email);

    if (listaUsuarios.isNotEmpty) {
      usuarioAtual.value = listaUsuarios.first;
    } else {
      usuarioAtual.value = null; // Nenhum encontrado
    }
  }
}
