import 'package:cloud_firestore/cloud_firestore.dart';

class Iniciativa {
  final String id;
  final String iniciativaNome;
  final String iniciativaDescricao;
  final bool finalizado;
  final List<String> gestores; // agora é lista de IDs (strings)

  Iniciativa({
    required this.id,
    required this.iniciativaNome,
    required this.iniciativaDescricao,
    required this.finalizado,
    required this.gestores,
  });

  factory Iniciativa.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return Iniciativa(
      id: doc.id,
      iniciativaNome: data['iniciativaNome'] ?? '',
      iniciativaDescricao: data['iniciativaDescricao'] ?? '',
      finalizado: data['finalizado'] ?? false,
      gestores: (data['gestores'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(), // converte lista dinâmica → lista de String
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'iniciativaNome': iniciativaNome,
      'iniciativaDescricao': iniciativaDescricao,
      'finalizado': finalizado,
      'gestores': gestores, // salva lista de Strings
    };
  }
}
