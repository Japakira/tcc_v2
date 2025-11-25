import 'package:tcc_v2/models/usuario_model.dart';
import 'package:tcc_v2/services/load_firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: constant_identifier_names
const COLLECTION_NAME = "Usuarios";

class UsuarioService {
  static Future<List<Usuario>> getAllUsuarios() async {
    final db = getFirestoreConnection();
    List<Usuario> resultUsuarios = List.empty(growable: true);
    await db.collection(COLLECTION_NAME).get().then((event) {
      for (var doc in event.docs) {
        var json = doc.data();
        // print(json);
        // print(json['usuarioNome']);
        resultUsuarios.add(
          Usuario(
            id: doc.id,
            usuarioNome: json['usuarioNome'],
            usuarioEmail: json['usuarioEmail'],
            admin: json['admin'],
          ),
        );
      }
    });

    return resultUsuarios;
  }

  static Future<List<Usuario>> getUsuarioesByIds(List<String> ids) async {
    final database = getFirestoreConnection();
    if (ids.isEmpty) return [];

    List<Usuario> result = List.empty(growable: true);
    try {
      // Firestore whereIn tem limite de 10 itens; se mais, fazemos batches simples
      const batchSize = 10;
      for (var i = 0; i < ids.length; i += batchSize) {
        final batchIds = ids.sublist(
          i,
          (i + batchSize) > ids.length ? ids.length : i + batchSize,
        );
        final snapshot = await database
            .collection(COLLECTION_NAME)
            .where(FieldPath.documentId, whereIn: batchIds)
            .get();

        for (var doc in snapshot.docs) {
          var json = doc.data();
          result.add(
            Usuario(
              id: doc.id,
              usuarioNome: json['usuarioNome'] ?? '',
              admin: json['admin'] ?? '',
              usuarioEmail: json['usuarioEmail'] ?? '',
            ),
          );
        }
      }
    } catch (e) {
      // fallback: tentar buscar documentos individualmente
      for (var id in ids) {
        try {
          final doc = await database.collection(COLLECTION_NAME).doc(id).get();
          if (doc.exists) {
            var json = doc.data()!;
            result.add(
              Usuario(
                id: doc.id,
                usuarioNome: json['usuarioNome'] ?? '',
                admin: json['admin'] ?? '',
                usuarioEmail: json['usuarioEmail'] ?? '',
              ),
            );
          }
        } catch (_) {}
      }
    }

    return result;
  }

  Future<Usuario?> getUsuario(String id) async {
    final database = getFirestoreConnection();
    try {
      final doc = await database.collection('Usuarios').doc(id).get();
      if (!doc.exists) return null;
      return Usuario.fromFirestore(doc);
    } catch (e) {
      throw Exception('Erro ao obter usuário: $e');
    }
  }

  Future<Usuario?> getUsuarioByEmail(String email) async {
    final database = getFirestoreConnection();
    try {
      final doc = await database.collection('Usuarios').doc(email).get();
      if (!doc.exists) return null;
      return Usuario.fromFirestore(doc);
    } catch (e) {
      throw Exception('Erro ao obter usuário: $e');
    }
  }
}
