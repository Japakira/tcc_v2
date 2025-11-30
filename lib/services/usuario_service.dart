import 'package:tcc_v2/models/usuario_model.dart';
import 'package:tcc_v2/services/load_firebase_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: constant_identifier_names
const COLLECTION_NAME = "Usuarios";

class UsuarioService {
  // --------------------------------------------------
  // GET ALL USERS
  // --------------------------------------------------
  static Future<List<Usuario>> getAllUsuarios() async {
    final db = getFirestoreConnection();
    List<Usuario> resultUsuarios = List.empty(growable: true);

    await db.collection(COLLECTION_NAME).get().then((event) {
      for (var doc in event.docs) {
        var json = doc.data();

        resultUsuarios.add(
          Usuario(
            id: doc.id,
            usuarioNome: json['usuarioNome'] ?? '',
            usuarioEmail: json['usuarioEmail'] ?? '',
            admin: json['admin'] ?? false,
            iniciativasIds: List<String>.from(json['iniciativasIds'] ?? []),
            imagemUrl: json['imagemUrl'] ?? '', // <-- ADICIONADO
          ),
        );
      }
    });

    return resultUsuarios;
  }

  // --------------------------------------------------
  // GET USERS BY LIST OF IDS
  // --------------------------------------------------
  static Future<List<Usuario>> getUsuariosByIds(List<String> ids) async {
    final database = getFirestoreConnection();
    if (ids.isEmpty) return [];

    List<Usuario> result = List.empty(growable: true);

    try {
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
              usuarioEmail: json['usuarioEmail'] ?? '',
              admin: json['admin'] ?? false,
              iniciativasIds: List<String>.from(json['iniciativasIds'] ?? []),
              imagemUrl: json['imagemUrl'] ?? '', // <-- ADICIONADO
            ),
          );
        }
      }
    } catch (e) {
      // fallback busca individual
      for (var id in ids) {
        try {
          final doc = await database.collection(COLLECTION_NAME).doc(id).get();

          if (doc.exists) {
            var json = doc.data()!;
            result.add(
              Usuario(
                id: doc.id,
                usuarioNome: json['usuarioNome'] ?? '',
                usuarioEmail: json['usuarioEmail'] ?? '',
                admin: json['admin'] ?? false,
                iniciativasIds: List<String>.from(json['iniciativasIds'] ?? []),
                imagemUrl: json['imagemUrl'] ?? '', // <-- ADICIONADO
              ),
            );
          }
        } catch (_) {}
      }
    }

    return result;
  }

  // --------------------------------------------------
  // GET USER BY ID
  // --------------------------------------------------
  Future<Usuario?> getUsuario(String id) async {
    final database = getFirestoreConnection();

    try {
      final doc = await database.collection(COLLECTION_NAME).doc(id).get();
      if (!doc.exists) return null;

      return Usuario.fromMap(doc.data()!, doc.id);
    } catch (e) {
      throw Exception("Erro ao obter usuário: $e");
    }
  }

  // --------------------------------------------------
  // GET USER BY EMAIL
  // --------------------------------------------------
  Future<List<Usuario>> getUsuarioByEmail(String email) async {
    final database = getFirestoreConnection();

    final snapshot = await database
        .collection(COLLECTION_NAME)
        .where('usuarioEmail', isEqualTo: email)
        .get();

    return snapshot.docs
        .map<Usuario>((doc) => Usuario.fromMap(doc.data()!, doc.id))
        .toList();
  }

  // --------------------------------------------------
  // ADD INICIATIVA AO USUÁRIO
  // --------------------------------------------------
  Future<void> addIniciativaToUsuario(
    String usuarioId,
    String iniciativaId,
  ) async {
    final database = getFirestoreConnection();

    try {
      await database.collection(COLLECTION_NAME).doc(usuarioId).update({
        'iniciativasIds': FieldValue.arrayUnion([iniciativaId]),
      });
    } catch (e) {
      throw Exception("Erro ao adicionar iniciativa ao usuário: $e");
    }
  }
}
