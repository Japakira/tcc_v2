import 'package:cloud_firestore/cloud_firestore.dart';

class Tarefa {
  final String tarefaId;
  final String tarefaNome;
  final String tarefaDescricao;
  final bool finalizado;
  final Timestamp prazo;
  final String iniciativaMae;
  final List<String> responsaveis;

  Tarefa({
    required this.tarefaId,
    required this.tarefaNome,
    required this.tarefaDescricao,
    required this.finalizado,
    required this.prazo,
    required this.iniciativaMae,
    required this.responsaveis,
  });

  factory Tarefa.fromMap(Map<String, dynamic> data, String documentId) {
    return Tarefa(
      tarefaId: documentId,
      tarefaNome: data['tarefaNome'] ?? '',
      tarefaDescricao: data['tarefaDescricao'] ?? '',
      finalizado: data['finalizado'] ?? false,
      prazo: data['prazo'],
      iniciativaMae: data['iniciativaMae'],
      responsaveis: List<String>.from(data['responsaveis'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tarefaId': tarefaId,
      'nome': tarefaNome,
      'descricao': tarefaDescricao,
      'finalizado': finalizado,
      'prazo': prazo,
      'iniciativaMae': iniciativaMae,
      'reponsaveis': responsaveis,
    };
  }
}
