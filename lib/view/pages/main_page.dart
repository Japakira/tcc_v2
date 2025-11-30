import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/controller/autenticacao_controller.dart';
import 'package:tcc_v2/view/pages/usuario_admin/admin_list_drawer.dart';
import 'package:tcc_v2/view/pages/usuario_admin/iniciativa_gestao.dart';
import 'package:tcc_v2/view/pages/iniciativas/iniciativa_nova_page.dart';
import 'package:tcc_v2/view/pages/iniciativas/iniciativa_lista_page.dart';
import 'package:tcc_v2/view/pages/usuario_admin/usuario_gestao.dart';
import 'package:tcc_v2/view/pages/usuario_comum/comum_list_drawer.dart';
import 'package:tcc_v2/view/pages/usuario_comum/usuario_edicao_page.dart';
import 'package:tcc_v2/view/widgets/avatar_circulo.dart';
import 'package:tcc_v2/view/widgets/hamburger_menu.dart';

class MainPage extends StatefulWidget {
  final int selectedIndex;

  const MainPage({super.key, this.selectedIndex = 1});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = Get.find<AutenticacaoController>();
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  List<Widget> get _widgetOptions {
    final usuario = controller.usuarioAtual.value;
    final iniciativasIds = usuario?.iniciativasIds ?? [];

    return [
      const Padding(padding: EdgeInsets.all(12.0), child: NovaIniciativa()),
      Padding(
        padding: const EdgeInsets.all(12.0),
        child: PaginaListaIniciativas(iniciativasIds: iniciativasIds),
      ),
      const Padding(padding: EdgeInsets.all(12.0), child: UsuarioGestao()),
      const Padding(padding: EdgeInsets.all(12.0), child: IniciativaGestao()),
    ];
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerEdgeDragWidth: 10,
      appBar: AppBar(
        centerTitle: true,
        title: Obx(
          () => Text(
            controller.usuarioAtual.value?.usuarioNome ?? "Carregando...",
            style: const TextStyle(fontSize: 22),
          ),
        ),
        actions: [
          Obx(() {
            final usuario = controller.usuarioAtual.value;

            final imagem =
                (usuario?.imagemUrl != null &&
                    usuario!.imagemUrl.trim().isNotEmpty)
                ? usuario.imagemUrl
                : 'assets/images/avatar/avatar_blank.png';

            return GestureDetector(
              onTap: () => Get.to(() => const UsuarioEdicao()),
              child: AvatarCirculo(pathImagem: imagem),
            );
          }),
        ],
        leading: Builder(
          builder: (context) => GestureDetector(
            child: const HamburgerMenu(),
            onTap: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: _widgetOptions[_selectedIndex],
      drawer: Drawer(
        backgroundColor: const Color(0xFF253334),
        child: Obx(() {
          final usuario = controller.usuarioAtual.value;
          final isAdmin = usuario?.admin ?? false;

          return isAdmin
              ? DrawerAdmin(opcao: _selectedIndex, onItemTapped: _onItemTapped)
              : DrawerComum(opcao: _selectedIndex, onItemTapped: _onItemTapped);
        }),
      ),
    );
  }
}
