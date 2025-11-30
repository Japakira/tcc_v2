import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/controller/autenticacao_controller.dart';

class DrawerComum extends StatefulWidget {
  final int opcao;
  final Function(int) onItemTapped;

  const DrawerComum({
    super.key,
    required this.opcao,
    required this.onItemTapped,
  });

  @override
  State<DrawerComum> createState() => _DrawerComumState();
}

class _DrawerComumState extends State<DrawerComum> {
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

        // ------------ ITEM 0 -------------
        ListTile(
          title: const Text(
            'Novo',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Alegreya",
              fontSize: 20,
            ),
          ),
          selected: widget.opcao == 0,
          onTap: () {
            widget.onItemTapped(0); // <<<<<< envia para MainPage
            Navigator.pop(context);
          },
        ),

        // ------------ ITEM 1 -------------
        ListTile(
          title: const Text(
            'Em andamento',
            style: TextStyle(
              color: Colors.white,
              fontFamily: "Alegreya",
              fontSize: 20,
            ),
          ),
          selected: widget.opcao == 1,
          onTap: () {
            widget.onItemTapped(1); // <<<<<< envia para MainPage
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
