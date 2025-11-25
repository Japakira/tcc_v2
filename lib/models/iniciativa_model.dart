import 'package:cloud_firestore/cloud_firestore.dart';

class Iniciativa {
  final String iniciativaId;
  final String iniciativaNome;
  final String iniciativaDescricao;
  final bool finalizado;
  final DocumentReference? gestoresRef;

  Iniciativa({
    required this.iniciativaId,
    required this.iniciativaNome,
    required this.iniciativaDescricao,
    required this.finalizado,
    required this.gestoresRef,
  });

  factory Iniciativa.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Iniciativa(
      iniciativaId: doc.id,
      iniciativaNome: data['iniciativaNome'] ?? '',
      iniciativaDescricao: data['iniciativaDescricao'] ?? '',
      finalizado: data['finalizado'] ?? false,
      gestoresRef: data['gestoresRef'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'iniciativaNome': iniciativaNome,
      'iniciativaDescricao': iniciativaDescricao,
      'finalizado': finalizado,
      'gestoresRef': gestoresRef,
    };
  }
}
