import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tcc_v2/models/iniciativa_model.dart';
import 'package:tcc_v2/services/iniciativa_service.dart';
import 'package:tcc_v2/view/widgets/cartao_iniciativa.dart';
import 'package:tcc_v2/controller/autenticacao_controller.dart';

class PaginaListaIniciativas extends StatefulWidget {
  const PaginaListaIniciativas({
    super.key,
    required List<String> iniciativasIds,
  });

  @override
  State<PaginaListaIniciativas> createState() => _PaginaListaIniciativasState();
}

class _PaginaListaIniciativasState extends State<PaginaListaIniciativas> {
  final IniciativaService _service = IniciativaService();

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AutenticacaoController>();

    return Obx(() {
      final usuario = authController.usuarioAtual.value;

      if (usuario == null) {
        return Scaffold(
          backgroundColor: const Color(0xFF2C3E3A),
          appBar: _buildAppBar(),
          body: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        );
      }

      // SE FOR ADMIN → CARREGAR TODAS AS INICIATIVAS
      if (usuario.admin == true) {
        return _buildFutureAdmin();
      }

      // SENÃO → CARREGAR APENAS AS INICIATIVAS DO USUÁRIO
      if (usuario.iniciativasIds.isEmpty) {
        return Scaffold(
          backgroundColor: const Color(0xFF2C3E3A),
          appBar: _buildAppBar(),
          body: const _Message(text: "Nenhuma iniciativa encontrada."),
        );
      }

      return _buildFutureUsuario(usuario.iniciativasIds);
    });
  }

  // AppBar padrão
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF7C9A92),
      title: const Text(
        "Minhas Iniciativas",
        style: TextStyle(
          fontFamily: "Alegreya",
          fontSize: 26,
          color: Colors.white,
        ),
      ),
    );
  }

  /// --------------------------------------------------------------------------
  /// ADMIN: Carregar TODAS as iniciativas
  /// --------------------------------------------------------------------------
  Widget _buildFutureAdmin() {
    return FutureBuilder<List<Iniciativa>>(
      future: _service.getAllIniciativas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (snapshot.hasError) {
          return const _Message(text: "Erro ao carregar iniciativas.");
        }

        final iniciativas = snapshot.data ?? [];

        if (iniciativas.isEmpty) {
          return const _Message(text: "Nenhuma iniciativa cadastrada.");
        }

        return _buildList(iniciativas);
      },
    );
  }

  /// --------------------------------------------------------------------------
  /// USUÁRIO NORMAL: carregar somente suas iniciativas
  /// --------------------------------------------------------------------------
  Widget _buildFutureUsuario(List<String> ids) {
    return FutureBuilder<List<Iniciativa>>(
      future: _service.getIniciativaByIds(ids),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        if (snapshot.hasError) {
          return const _Message(text: "Erro ao carregar iniciativas.");
        }

        final iniciativas = snapshot.data ?? [];

        if (iniciativas.isEmpty) {
          return const _Message(text: "Nenhuma iniciativa encontrada.");
        }

        return _buildList(iniciativas);
      },
    );
  }

  /// Lista com cartões de iniciativa
  Widget _buildList(List<Iniciativa> iniciativas) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
      itemCount: iniciativas.length,
      itemBuilder: (context, index) {
        final iniciativa = iniciativas[index];

        return CartaoIniciativa(
          nome: iniciativa.iniciativaNome,
          descricao: iniciativa.iniciativaDescricao,
          iniciativaId: iniciativa.id,
          finalizado: iniciativa.finalizado,
          gestores: iniciativa.gestores,
        );
      },
    );
  }
}

class _Message extends StatelessWidget {
  final String text;

  const _Message({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontFamily: "Alegreya",
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
