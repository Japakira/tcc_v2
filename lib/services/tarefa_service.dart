import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_v2/models/tarefa_model.dart';

class TarefaService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// --------------------------------------------------------------------------
  /// BUSCAR tarefas por ID da iniciativa mãe
  /// --------------------------------------------------------------------------
  Future<List<Tarefa>> getTarefasById(String iniciativaId) async {
    try {
      print("🔍 [TarefaService] getTarefasById chamado");
      print("➡️  Iniciativa ID recebido: $iniciativaId");

      final query = _db
          .collection('Tarefas')
          .where('iniciativaMae', isEqualTo: iniciativaId);

      print("📡 Firestore Query → Tarefas onde iniciativaMae = $iniciativaId");

      final snapshot = await query.get();

      print("📥 Documentos retornados: ${snapshot.docs.length}");

      if (snapshot.docs.isEmpty) {
        print("⚠️ Nenhuma tarefa encontrada para esta iniciativa.");
        return [];
      }

      // LOG detalhado dos documentos
      for (var doc in snapshot.docs) {
        print("----- 📄 Documento encontrado -----");
        print("🆔 ID: ${doc.id}");
        print("📌 Dados brutos: ${doc.data()}");
      }

      final tarefas = snapshot.docs.map((doc) {
        final tarefa = Tarefa.fromFirestore(doc);

        print("✔️ [Tarefa Convertida]");
        print("ID: ${tarefa.id}");
        print("Nome: ${tarefa.tarefaNome}");
        print("Descrição: ${tarefa.tarefaDescricao}");
        print("Finalizado: ${tarefa.finalizado}");
        print("Prazo: ${tarefa.prazo}");
        print("Iniciativa Mãe: ${tarefa.iniciativaMae}");
        print("Responsáveis: ${tarefa.responsaveis}");

        return tarefa;
      }).toList();

      return tarefas;
    } catch (e) {
      print("❌ Erro getTarefasById: $e");
      return [];
    }
  }

  /// --------------------------------------------------------------------------
  /// ADICIONAR nova tarefa
  /// --------------------------------------------------------------------------
  Future<String?> addTarefa({required Map<String, dynamic> tarefaData}) async {
    try {
      print("🟦 [addTarefa] Dados recebidos:");
      print(tarefaData);

      final docRef = await _db.collection('Tarefas').add(tarefaData);

      // adiciona o próprio ID ao documento
      await docRef.update({'id': docRef.id});

      print("🟩 Tarefa criada com ID: ${docRef.id}");
      return docRef.id;
    } catch (e) {
      print("❌ Erro addTarefa: $e");
      return null;
    }
  }

  /// --------------------------------------------------------------------------
  /// ATUALIZAR campo 'finalizado'
  /// --------------------------------------------------------------------------
  Future<void> updateTarefaFinalizado({
    required String id,
    required bool finalizado,
  }) async {
    try {
      print("🟨 Atualizando tarefa $id → finalizado = $finalizado");

      await _db.collection('Tarefas').doc(id).update({
        'finalizado': finalizado,
      });

      print("🟩 Status finalizado atualizado com sucesso.");
    } catch (e) {
      print("❌ Erro updateTarefaFinalizado: $e");
    }
  }

  /// --------------------------------------------------------------------------
  /// ATUALIZAR lista de responsáveis
  /// --------------------------------------------------------------------------
  Future<void> updateTarefaResponsaveis({
    required String id,
    required List<String> responsaveis,
  }) async {
    try {
      print("👥 Atualizando responsáveis da tarefa $id");
      print("➡️ Lista enviada: $responsaveis");

      await _db.collection('Tarefas').doc(id).update({
        'responsaveis': responsaveis,
      });

      print("🟩 Responsáveis atualizados com sucesso.");
    } catch (e) {
      print("❌ Erro updateTarefaResponsaveis: $e");
    }
  }
}
