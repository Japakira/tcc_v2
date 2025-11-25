import 'package:flutter/material.dart';
import 'package:tcc_v2/services/iniciativa_service.dart';
import 'package:tcc_v2/models/iniciativa_model.dart';
import 'package:tcc_v2/view/widgets/cartao_iniciativa.dart';

class PaginaListaIniciativas extends StatefulWidget {
  const PaginaListaIniciativas({super.key});

  @override
  State<PaginaListaIniciativas> createState() => _PaginaListaIniciativas();
}

class _PaginaListaIniciativas extends State<PaginaListaIniciativas> {
  List<Iniciativa> _iniciativas = [];

  @override
  void initState() {
    super.initState();
    final service = IniciativaService();
    service.getAllIniciativas().then(
      (result) => setState(() {
        _iniciativas = result;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: _iniciativas.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _iniciativas.length,
                      itemBuilder: (context, index) {
                        return CartaoIniciativa(
                          nome: _iniciativas[index].iniciativaNome,
                          descricao: _iniciativas[index].iniciativaDescricao,
                          gestoresRef: _iniciativas[index].gestoresRef,
                          iniciativaId: _iniciativas[index].iniciativaId,
                        );
                      },
                    ),
            ),

            Text(
              "Exemplo: ${_iniciativas.length}",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
