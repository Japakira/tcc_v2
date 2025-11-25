import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcc_v2/view/pages/tarefas/tarefas_lista_page.dart';

class CartaoIniciativa extends StatefulWidget {
  final dynamic nome;
  final dynamic descricao;
  final dynamic iniciativaId;
  final bool finalizado;
  final DocumentReference? gestoresRef;

  const CartaoIniciativa({
    super.key,
    this.iniciativaId,
    this.nome,
    this.descricao,
    this.finalizado = false,
    required this.gestoresRef,
  });

  @override
  State<CartaoIniciativa> createState() => _CartaoIniciativaState();
}

class _CartaoIniciativaState extends State<CartaoIniciativa> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          // clique em qualquer parte do card abre a tela de detalhes
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaginaListaTarefas(
                iniciativaNome: widget.nome,
                iniciativaDescricao: widget.descricao,
                gestoresRef: widget.gestoresRef,
                finalizado: widget.finalizado,
                iniciativaId: widget.iniciativaId,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFF7F3F0),
          ),
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(15),
          height: 140,
          width: double.infinity,
          child: Column(
            children: [
              // título
              Text(
                widget.nome?.toString() ?? '',
                style: TextStyle(
                  fontFamily: 'Alegreya',
                  fontSize: 25,
                  color: Color(0xFF253334),
                  fontWeight: FontWeight.w800,
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Color(0xFFF7F3F0),
                ),
                child: Text(
                  widget.descricao?.toString() ?? '',
                  maxLines: 2,
                  style: TextStyle(
                    fontFamily: 'Alegreya',
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
