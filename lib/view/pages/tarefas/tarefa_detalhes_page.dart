import 'package:flutter/material.dart';

class PaginaDetalheTarefa extends StatefulWidget {
  final dynamic nome;
  final dynamic descricao;
  final dynamic gestoresRef;
  final dynamic tarefas;

  const PaginaDetalheTarefa({
    super.key,
    this.nome,
    this.descricao,
    this.gestoresRef,
    this.tarefas,
  });

  @override
  State<PaginaDetalheTarefa> createState() => _MyPaginaDetalheTarefa();
}

class _MyPaginaDetalheTarefa extends State<PaginaDetalheTarefa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.white),
        title: Text(
          widget.nome,
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Color(0xFFF7F3F0),
            ),
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(15),
            height: 140,
            width: double.infinity,
            child: Text(
              widget.descricao,
              style: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
