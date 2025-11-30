import 'package:cloud_firestore/cloud_firestore.dart';

class Tarefa {
  final String id;
  final String tarefaNome;
  final String tarefaDescricao;
  final bool finalizado;
  final Timestamp prazo;
  final String iniciativaMae;
  final List<String> responsaveis;

  Tarefa({
    required this.id,
    required this.tarefaNome,
    required this.tarefaDescricao,
    required this.finalizado,
    required this.prazo,
    required this.iniciativaMae,
    required this.responsaveis,
  });

  factory Tarefa.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Tarefa(
      id: doc.id,
      tarefaNome: data['tarefaNome'] ?? '',
      tarefaDescricao: data['tarefaDescricao'] ?? '',
      iniciativaMae: data['iniciativaMae'] ?? '',
      finalizado: data['finalizado'] ?? false,
      prazo: data['prazo'],
      responsaveis: List<String>.from(data['responsaveis'] ?? []),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'tarefaNome': tarefaNome,
      'tarefaDescricao': tarefaDescricao,
      'finalizado': finalizado,
      'prazo': prazo,
      'iniciativaMae': iniciativaMae,
      'reponsaveis': responsaveis,
    };
  }
}
