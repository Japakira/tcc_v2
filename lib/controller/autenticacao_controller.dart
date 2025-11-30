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

    print("🟦 [AutenticacaoController] Inicializado");

    // Observa alterações no FirebaseAuth
    ever(authService.currentUserRx, (firebaseUser) {
      print("🔄 [FirebaseAuth Change] Usuário autenticado mudou.");
      print("   FirebaseUser: ${firebaseUser?.email ?? 'null'}");
      carregarUsuario();
    });

    carregarUsuario();
  }

  // ---------------------------------------------------------------------------
  // LOGIN
  // ---------------------------------------------------------------------------
  Future<void> login() async {
    print("🟨 [Login] Tentando login com email: ${email.text}");

    await authService.login(email.text, senha.text);

    print("🟩 [Login] Autenticado com Firebase.");
    await carregarUsuario();
  }

  // ---------------------------------------------------------------------------
  // LOGOUT
  // ---------------------------------------------------------------------------
  Future<void> logout() async {
    print("🟥 [Logout] Usuário saindo do sistema.");
    await authService.logout();

    usuarioAtual.value = null;
    print("🟩 [Logout] usuarioAtual foi limpo.");
  }

  // ---------------------------------------------------------------------------
  // CARREGAR USUÁRIO DO FIRESTORE
  // ---------------------------------------------------------------------------
  Future<void> carregarUsuario() async {
    print("\n🔍 [carregarUsuario] Iniciando carregamento do usuarioAtual...");

    final auth = Get.find<AuthService>();
    final String? emailUsuario = auth.currentUser?.email;

    print("📧 [carregarUsuario] Email obtido do FirebaseAuth: $emailUsuario");

    if (emailUsuario == null) {
      print("⚠️ [carregarUsuario] Nenhum usuário logado no FirebaseAuth.");
      usuarioAtual.value = null;
      return;
    }

    final listaUsuarios = await UsuarioService().getUsuarioByEmail(
      emailUsuario,
    );

    print(
      "📥 [Firestore] Quantidade de usuários encontrados: ${listaUsuarios.length}",
    );

    if (listaUsuarios.isEmpty) {
      print("❌ [carregarUsuario] Nenhum documento encontrado com este email.");
      usuarioAtual.value = null;
      return;
    }

    final usuario = listaUsuarios.first;

    print("🟦 [Usuario Encontrado no Firestore]");
    print("   ID: ${usuario.id}");
    print("   Nome: ${usuario.usuarioNome}");
    print("   Email: ${usuario.usuarioEmail}");
    print("   admin: ${usuario.admin}");
    print("   IniciativasIds: ${usuario.iniciativasIds}");

    usuarioAtual.value = usuario;

    print("🟩 [carregarUsuario] usuarioAtual atualizado com sucesso.");
    print(
      "📌 usuarioAtual: ${usuarioAtual.value?.usuarioNome} (${usuarioAtual.value?.usuarioEmail})\n",
    );
  }
}
