import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/controller/autenticacao_controller.dart';
import 'package:tcc_v2/services/iniciativa_service.dart';
import 'package:tcc_v2/services/usuario_service.dart';
import 'package:tcc_v2/view/pages/main_page.dart';

class NovaIniciativa extends StatefulWidget {
  const NovaIniciativa({super.key});

  @override
  State<NovaIniciativa> createState() => _NovaIniciativaState();
}

class _NovaIniciativaState extends State<NovaIniciativa> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController descricaoController = TextEditingController();

  final auth = Get.find<AutenticacaoController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nova Iniciativa",
              style: TextStyle(
                fontFamily: 'Alegreya',
                fontWeight: FontWeight.w500,
                fontSize: 30,
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 20),

            _buildInput(
              controller: nomeController,
              hint: "Nome da Iniciativa",
              maxLines: 1,
            ),

            const SizedBox(height: 20),

            _buildInput(
              controller: descricaoController,
              hint: "Descrição da Iniciativa",
              maxLines: 3,
            ),

            const SizedBox(height: 40),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildButton(
                  label: "Cancelar",
                  onTap: () => Get.off(() => const MainPage(selectedIndex: 1)),
                ),
                _buildButton(label: "Criar", onTap: _criarIniciativa),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Construção dos Inputs
  // ---------------------------------------------------------------------------
  Widget _buildInput({
    required TextEditingController controller,
    required String hint,
    required int maxLines,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(border: InputBorder.none, hintText: hint),
        style: const TextStyle(color: Colors.black),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Botão estilizado
  // ---------------------------------------------------------------------------
  Widget _buildButton({required String label, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF7C9A92),
        ),
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontFamily: "Alegreya",
              fontWeight: FontWeight.normal,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Lógica de criação da iniciativa
  // ---------------------------------------------------------------------------
  Future<void> _criarIniciativa() async {
    final nome = nomeController.text.trim();
    final descricao = descricaoController.text.trim();
    final usuario = auth.usuarioAtual.value;

    if (nome.isEmpty || descricao.isEmpty) {
      Get.snackbar(
        "Erro",
        "Preencha todos os campos",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    if (usuario == null) {
      Get.snackbar(
        "Erro",
        "Usuário não identificado",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Criar iniciativa
    final iniciativaId = await IniciativaService().addNovaIniciativa(
      iniciativaNome: nome,
      iniciativaDescricao: descricao,
      gestores: [usuario.id], // ← ID do usuário logado
    );

    if (iniciativaId == null) {
      Get.snackbar(
        "Erro",
        "Não foi possível criar a iniciativa",
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Adiciona iniciativa ao usuário
    await UsuarioService().addIniciativaToUsuario(usuario.id, iniciativaId);

    // Atualiza usuário no controller
    await auth.carregarUsuario();

    Get.snackbar(
      "Sucesso",
      "Iniciativa criada!",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Retorna para página principal
    Get.off(() => const MainPage(selectedIndex: 1));
  }
}
