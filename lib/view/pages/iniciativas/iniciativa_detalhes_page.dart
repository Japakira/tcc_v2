import 'package:flutter/material.dart';
import 'package:tcc_v2/view/widgets/avatar_circulo.dart';

class PaginaDetalheIniciativa extends StatefulWidget {
  final dynamic nome;
  final dynamic descricao;
  final dynamic gestoresRef;
  final dynamic id;
  final dynamic tamanho;

  const PaginaDetalheIniciativa({
    super.key,
    this.nome,
    this.descricao,
    this.gestoresRef,
    this.id,
    this.tamanho,
  });

  @override
  State<PaginaDetalheIniciativa> createState() => _MyPaginaDetalheIniciativa();
}

class _MyPaginaDetalheIniciativa extends State<PaginaDetalheIniciativa> {
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
            width: double.infinity,
            child: Column(
              children: [
                Text(
                  widget.descricao,
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gestores',
                          style: TextStyle(color: Color(0xFF253334)),
                        ),
                        AvatarCirculo(
                          pathImagem: 'assets/images/avatar/avatar_blank.png',
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Quantidade de Tarefas',
                          style: TextStyle(color: Color(0xFF253334)),
                        ),
                        Text(
                          "${widget.tamanho}",
                          style: TextStyle(
                            color: Color(0xFF253334),
                            fontFamily: "Alegreya",
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
