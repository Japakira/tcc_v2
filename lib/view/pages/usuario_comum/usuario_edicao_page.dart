import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/controller/autenticacao_controller.dart';

class UsuarioEdicao extends StatelessWidget {
  const UsuarioEdicao({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AutenticacaoController>();

    return Obx(() {
      final usuario = controller.usuarioAtual.value;

      if (usuario == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }

      final imagem = usuario.imagemUrl.isNotEmpty
          ? usuario.imagemUrl
          : 'assets/images/avatar/avatar_blank.png';

      return Scaffold(
        appBar: AppBar(title: Text(usuario.usuarioNome), centerTitle: true),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: imagem.startsWith("http")
                        ? NetworkImage(imagem)
                        : AssetImage(imagem) as ImageProvider,
                  ),

                  // Ícone editar ou adicionar foto
                  Positioned(
                    bottom: 0,
                    right: 4,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.teal,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        icon: Icon(
                          usuario.imagemUrl.isEmpty
                              ? Icons.add_a_photo
                              : Icons.edit,
                          size: 18,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          // Aqui você irá implementar upload/troca da imagem
                          Get.snackbar(
                            "Imagem",
                            "Função de edição será implementada",
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),
              const Divider(),

              const SizedBox(height: 15),
              Row(
                children: [
                  const Icon(Icons.email, size: 26),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      usuario.usuarioEmail,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Icon(usuario.admin ? Icons.shield : Icons.person, size: 26),
                  const SizedBox(width: 10),
                  Text(
                    usuario.admin ? "Administrador" : "Usuário Comum",
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),

              const SizedBox(height: 30),
              const Divider(),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                onPressed: () {
                  // Implementar lógica de trocar senha
                  Get.snackbar(
                    "Senha",
                    "Função para alterar senha será implementada",
                  );
                },
                icon: const Icon(Icons.lock),
                label: const Text(
                  "Alterar Senha",
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 48),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
