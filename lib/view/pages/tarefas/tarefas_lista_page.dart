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
  final dynamic gestores;
  final dynamic finalizado;

  const PaginaListaTarefas({
    super.key,
    this.iniciativaId,
    this.iniciativaNome,
    this.iniciativaDescricao,
    this.gestores,
    this.finalizado,
    required List<String> responsaveis,
  });

  @override
  State<PaginaListaTarefas> createState() => _PaginaListaTarefasState();
}

class _PaginaListaTarefasState extends State<PaginaListaTarefas> {
  List<Tarefa> _tarefas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();

    TarefaService().getTarefasById(widget.iniciativaId).then((result) {
      setState(() {
        _tarefas = result;
        _carregando = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.white),
        backgroundColor: const Color(0xFF253334),
        actionsPadding: const EdgeInsets.symmetric(horizontal: 15),
        title: Text(
          widget.iniciativaNome,
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PaginaDetalheIniciativa(
                  nome: widget.iniciativaNome,
                  descricao: widget.iniciativaDescricao,
                  tamanho: _tarefas.length,
                  gestores: widget.gestores,
                ),
              ),
            ),
            child: Ink(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: const Center(
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
        ],
      ),

      body: _carregando
          ? const Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: CircularProgressIndicator(),
              ),
            )
          : _tarefas.isEmpty
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.inbox, size: 80, color: Colors.grey),
                    SizedBox(height: 20),
                    Text(
                      "Nenhuma tarefa cadastrada ainda",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.white70,
                        fontFamily: "Alegreya",
                      ),
                    ),
                  ],
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _tarefas.length,
                    itemBuilder: (context, index) {
                      final tarefa = _tarefas[index];
                      return CartaoTarefa(
                        nome: tarefa.tarefaNome,
                        descricao: tarefa.tarefaDescricao,
                        iniciativaMae: tarefa.iniciativaMae,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Total de tarefas: ${_tarefas.length}",
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF7C9A92),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NovaTarefa()),
          );
        },
        label: const Text(
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
