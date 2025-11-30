import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/controller/autenticacao_controller.dart';

class DrawerAdmin extends StatefulWidget {
  final int opcao;
  final Function(int) onItemTapped;

  const DrawerAdmin({
    super.key,
    required this.opcao,
    required this.onItemTapped,
  });

  @override
  State<DrawerAdmin> createState() => _DrawerAdminState();
}

class _DrawerAdminState extends State<DrawerAdmin> {
  final controller = Get.find<AutenticacaoController>();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 70,
          child: InkWell(
            onTap: () => controller.logout(),
            child: const Icon(Icons.exit_to_app_outlined, color: Colors.white),
          ),
        ),

        // Item 2 — Usuário
        ListTile(
          title: const Text(
            'Usuário',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Alegreya",
              fontSize: 20,
            ),
          ),
          selected: widget.opcao == 2,
          onTap: () {
            widget.onItemTapped(2);
            Navigator.pop(context);
          },
        ),

        // Item 3 — Iniciativa
        ListTile(
          title: const Text(
            'Iniciativa',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Alegreya",
              fontSize: 20,
            ),
          ),
          selected: widget.opcao == 3,
          onTap: () {
            widget.onItemTapped(3);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
