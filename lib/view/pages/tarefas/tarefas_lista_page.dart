import 'package:flutter/material.dart';
import 'package:tcc_v2/models/tarefa_model.dart';
import 'package:tcc_v2/services/tarefa_service.dart';
import 'package:tcc_v2/view/pages/iniciativas/iniciativa_detalhes_page.dart';
import 'package:tcc_v2/view/pages/tarefas/tarefa_nova_page.dart';
import 'package:tcc_v2/view/widgets/cartao_tarefa.dart';

class PaginaListaTarefas extends StatefulWidget {
  final dynamic iniciativaId;
  final dynamic iniciativaNome;
  final dynamic iniciativaDescricao;
  final dynamic gestoresRef;
  final dynamic finalizado;

  const PaginaListaTarefas({
    super.key,
    this.iniciativaId,
    this.iniciativaNome,
    this.iniciativaDescricao,
    this.gestoresRef,
    this.finalizado,
  });

  @override
  State<PaginaListaTarefas> createState() => _PaginaListaTarefas();
}

class _PaginaListaTarefas extends State<PaginaListaTarefas> {
  List<Tarefa> _tarefas = [];
  late int tamanho;
  @override
  void initState() {
    super.initState();
    TarefaService.getTarefasById(widget.iniciativaId).then(
      (result) => setState(() {
        _tarefas = result;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    tamanho = _tarefas.length;
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        actionsPadding: EdgeInsets.symmetric(horizontal: 15),
        backgroundColor: Color(0xFF253334),
        title: Text(
          widget.iniciativaNome,
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaginaDetalheIniciativa(
                  nome: widget.iniciativaNome,
                  descricao: widget.iniciativaDescricao,
                  tamanho: tamanho,
                  gestoresRef: widget.gestoresRef,
                ),
              ),
            ),
            borderRadius: BorderRadius.circular(30),
            child: Padding(
              padding: EdgeInsetsGeometry.zero,
              child: Ink(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    "i",
                    style: TextStyle(
                      fontFamily: "Alegreya",
                      color: Colors.white,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: _tarefas.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _tarefas.length,
                      itemBuilder: (context, index) {
                        return CartaoTarefa(
                          nome: _tarefas[index].tarefaNome,
                          descricao: _tarefas[index].tarefaDescricao,
                          iniciativaMae: _tarefas[index].iniciativaMae,
                        );
                      },
                    ),
            ),
            Text(
              "Exemplo: ${_tarefas.length}",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color(0xFF7C9A92),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NovaTarefa()),
          );
        },
        label: Text(
          "Nova Tarefa",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Alegreya",
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
