import 'package:tcc_v2/controller/autenticacao_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/view/pages/iniciativas/iniciativa_nova_page.dart';
import 'package:tcc_v2/view/pages/iniciativas/iniciativa_lista_page.dart';
import 'package:tcc_v2/view/widgets/avatar_circulo.dart';
import 'package:tcc_v2/view/widgets/hamburger_menu.dart';

class MainPage extends StatefulWidget {
  final dynamic titulo;

  const MainPage({super.key, this.titulo});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = Get.put(AutenticacaoController());
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
    MediaQuery.of(context);
    return Scaffold(
      drawerEdgeDragWidth: 10,
      appBar: AppBar(
        title: Center(child: Text('Visitante', style: TextStyle(fontSize: 30))),
        actions: [AvatarCirculo(pathImagem: 'assets/images/avatar.png')],
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              child: HamburgerMenu(),
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      drawer: Drawer(
        backgroundColor: Color(0xFF253334),
        child: ListView(
          children: [
            SizedBox(
              height: 70,
              child: InkWell(
                onTap: () => controller.logout(),
                child: Icon(Icons.exit_to_app_outlined),
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
                // Update the state of the app
                _onItemTapped(0);
                // Then close the drawer
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
                // Update the state of the app
                _onItemTapped(1);
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
