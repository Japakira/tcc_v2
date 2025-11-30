import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_v2/models/iniciativa_model.dart';

class IniciativaService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// --------------------------------------------------------------------------
  /// BUSCAR iniciativas por lista de IDs
  /// --------------------------------------------------------------------------
  Future<List<Iniciativa>> getIniciativaByIds(List<String> ids) async {
    if (ids.isEmpty) return [];

    try {
      print("🔍 [getIniciativaByIds] IDs recebidos: $ids");

      final query = _db
          .collection('Iniciativas')
          .where(FieldPath.documentId, whereIn: ids);

      print("📡 [Firestore Query] where documentId in $ids");

      final snapshot = await query.get();

      print(
        "📥 [Snapshot] quantidade de documentos retornados: ${snapshot.docs.length}",
      );

      // LOG DETALHADO DOS DOCUMENTOS RECEBIDOS
      for (var doc in snapshot.docs) {
        print("------ 📄 Documento encontrado ------");
        print("🆔 ID: ${doc.id}");
        print("📌 Dados brutos: ${doc.data()}");
      }

      final iniciativas = snapshot.docs.map((doc) {
        final iniciativa = Iniciativa.fromFirestore(doc);

        print("✔️ [Iniciativa Convertida]");
        print("ID: ${iniciativa.id}");
        print("Nome: ${iniciativa.iniciativaNome}");
        print("Descrição: ${iniciativa.iniciativaDescricao}");
        print("Finalizado: ${iniciativa.finalizado}");
        print("Gestores: ${iniciativa.gestores}");

        return iniciativa;
      }).toList();

      return iniciativas;
    } catch (e) {
      print("❌ Erro getIniciativaByIds: $e");
      return [];
    }
  }

  /// --------------------------------------------------------------------------
  /// BUSCAR todas as iniciativas
  /// --------------------------------------------------------------------------
  Future<List<Iniciativa>> getAllIniciativas() async {
    try {
      final snapshot = await _db.collection('Iniciativas').get();

      return snapshot.docs.map((doc) => Iniciativa.fromFirestore(doc)).toList();
    } catch (e) {
      print("❌ Erro getAllIniciativas: $e");
      return [];
    }
  }

  /// --------------------------------------------------------------------------
  /// CRIAR nova iniciativa
  /// gestores = lista de IDs de usuários responsáveis
  /// --------------------------------------------------------------------------
  Future<String?> addNovaIniciativa({
    required String iniciativaNome,
    required String iniciativaDescricao,
    required List<String> gestores,
  }) async {
    try {
      final data = {
        'iniciativaNome': iniciativaNome,
        'iniciativaDescricao': iniciativaDescricao,
        'finalizado': false,
        'gestores': gestores,
      };

      print("🟦 Salvando nova iniciativa:");
      print(data);

      final docRef = await _db.collection('Iniciativas').add(data);

      await docRef.update({'id': docRef.id});

      print("🟩 Iniciativa criada com ID: ${docRef.id}");

      return docRef.id;
    } catch (e) {
      print("❌ Erro addNovaIniciativa: $e");
      return null;
    }
  }

  /// --------------------------------------------------------------------------
  /// Atualizar iniciativa
  /// --------------------------------------------------------------------------
  Future<void> updateIniciativa(String id, Map<String, dynamic> data) async {
    try {
      print("🟨 Atualizando iniciativa $id com dados:");
      print(data);

      await _db.collection('Iniciativas').doc(id).update(data);

      print("🟩 Iniciativa atualizada com sucesso.");
    } catch (e) {
      print("❌ Erro updateIniciativa: $e");
    }
  }

  /// --------------------------------------------------------------------------
  /// Deletar iniciativa
  /// --------------------------------------------------------------------------
  Future<void> deleteIniciativa(String id) async {
    try {
      print("🟥 Deletando iniciativa ID: $id");

      await _db.collection('Iniciativas').doc(id).delete();

      print("🟩 Iniciativa deletada.");
    } catch (e) {
      print("❌ Erro deleteIniciativa: $e");
    }
  }
}
