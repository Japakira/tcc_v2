import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tcc_v2/models/usuario_model.dart';

class Tarefa {
  final String tarefaId;
  final String tarefaNome;
  final String tarefaDescricao;
  final bool finalizado;
  final Timestamp prazo;
  final String iniciativaMae;
  // final List<Usuario> responsaveis;

  Tarefa({
    required this.tarefaId,
    required this.tarefaNome,
    required this.tarefaDescricao,
    required this.finalizado,
    required this.prazo,
    required this.iniciativaMae,
    // required this.responsaveis,
  });

  factory Tarefa.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Tarefa(
      tarefaId: doc.id,
      tarefaNome: data['tarefaNome'] ?? '',
      tarefaDescricao: data['tarefaDescricao'] ?? '',
      finalizado: data['finalizado'] ?? false,
      prazo: data['prazo'],
      iniciativaMae: data['iniciativaMae'],
      // responsaveis: data['responsaveis'],
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
    };
  }
}
