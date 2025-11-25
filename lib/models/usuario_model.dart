import 'package:cloud_firestore/cloud_firestore.dart';

class Usuario {
  final String id;
  final String usuarioNome;
  final String usuarioEmail;
  final bool admin;

  Usuario({
    required this.id,
    required this.usuarioNome,
    required this.usuarioEmail,
    required this.admin,
  });

  factory Usuario.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Usuario(
      id: doc.id,
      usuarioNome: data['nome'] ?? '',
      usuarioEmail: data['email'] ?? '',
      admin: data['admin'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': usuarioNome,
      'email': usuarioEmail,
      'admin': admin,
    };
  }
}
