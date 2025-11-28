import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/controller/autenticacao_controller.dart';
import 'package:tcc_v2/view/pages/iniciativas/iniciativa_nova_page.dart';
import 'package:tcc_v2/view/pages/iniciativas/iniciativa_lista_page.dart';
import 'package:tcc_v2/view/widgets/avatar_circulo.dart';
import 'package:tcc_v2/view/widgets/hamburger_menu.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Usar instância existente ao invés de criar outra
  final controller = Get.find<AutenticacaoController>();

  int _selectedIndex = 1;

  static const List<Widget> _widgetOptions = <Widget>[
    Padding(padding: EdgeInsets.all(12.0), child: NovaIniciativa()),
    Padding(padding: EdgeInsets.all(12.0), child: PaginaListaIniciativas()),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: 10,
      appBar: AppBar(
        title: Obx(
          () => Center(
            child: Text(
              controller.usuarioAtual.value?.usuarioNome ?? 'Carregando...',
              style: const TextStyle(fontSize: 10),
            ),
          ),
        ),

        actions: const [
          AvatarCirculo(pathImagem: 'assets/images/avatar/Avatar01.jpg'),
        ],
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              child: const HamburgerMenu(),
              onTap: () => Scaffold.of(context).openDrawer(),
            );
          },
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      drawer: Drawer(
        backgroundColor: const Color(0xFF253334),
        child: ListView(
          children: [
            SizedBox(
              height: 70,
              child: InkWell(
                onTap: () => controller.logout(),
                child: const Icon(
                  Icons.exit_to_app_outlined,
                  color: Colors.white,
                ),
              ),
            ),
            ListTile(
              title: const Text(
                'Novo',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Alegreya",
                  fontSize: 20,
                ),
              ),
              selected: _selectedIndex == 0,
              onTap: () {
                _onItemTapped(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text(
                'Em andamento',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "Alegreya",
                  fontSize: 20,
                ),
              ),
              selected: _selectedIndex == 1,
              onTap: () {
                _onItemTapped(1);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
