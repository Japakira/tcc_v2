import 'package:tcc_v2/models/tarefa_model.dart';
import 'package:tcc_v2/services/load_firebase_service.dart';

// ignore: constant_identifier_names
const COLLECTION_NAME = "Tarefas";

class TarefaService {
  // Método para buscar as tarefas relacionadas a uma determinada iniciativa
  static Future<List<Tarefa>> getTarefasById(String iniciativaId) async {
    final database = getFirestoreConnection();

    final snapshot = await database
        .collection(COLLECTION_NAME)
        .where('iniciativaMae', isEqualTo: iniciativaId)
        .get();
    return snapshot.docs
        .map<Tarefa>((doc) => Tarefa.fromMap(doc.data(), doc.id))
        .toList();
  }
  // static Future<List<Tarefa>> getTarefasById(String iniciativaId) async {
  //   final db = getFirestoreConnection();
  //   final List<Tarefa> resultTarefas = [];

  //   try {
  //     // Busca somente tarefas cuja iniciativaMae == iniciativaId
  //     QuerySnapshot snapshot = await db
  //         .collection(COLLECTION_NAME)
  //         .where('iniciativaMae', isEqualTo: iniciativaId)
  //         .get();

  //     for (var doc in snapshot.docs) {
  //       final json = doc.data() as Map<String, dynamic>;

  //       resultTarefas.add(
  //         Tarefa(
  //           tarefaId: doc.id,
  //           tarefaNome: json['tarefaNome'] ?? '',
  //           tarefaDescricao: json['tarefaDescricao'] ?? '',
  //           finalizado: json['finalizado'] ?? false,
  //           prazo: json['prazo'],
  //           iniciativaMae: json['iniciativaMae'] ?? '',
  //           responsaveis: List<String>.from(json['responsaveis'] ?? []),
  //         ),
  //       );
  //     }
  //   } catch (e) {
  //     // ignore: avoid_print
  //     print("Erro ao buscar tarefas: $e");
  //   }

  //   return resultTarefas;
  // }

  // Método para buscar adicionar nova tarefa a uma determinada iniciativa
  static Future<Tarefa> addTarefa({
    required String iniciativaId,
    required Map<String, dynamic> tarefaData,
  }) async {
    final database = getFirestoreConnection();
    final docRef = await database
        .collection(COLLECTION_NAME)
        .doc(iniciativaId)
        .add(tarefaData);
    return Tarefa.fromMap(tarefaData, docRef.id);
  }

  // Método para atualizar o status finalizado de uma tarefa
  static Future<void> updateTarefaFinalizado({
    required String tarefaId,
    required bool finalizado,
  }) async {
    final database = getFirestoreConnection();
    await database.collection(COLLECTION_NAME).doc(tarefaId).update({
      'finalizado': finalizado,
    });
  }

  //Método para adicionar ou excluir os responsáveis de uma tarefa
  static Future<void> updateTarefaResponsaveis({
    required String tarefaId,
    required List<String> responsaveis,
  }) async {
    final database = getFirestoreConnection();
    await database.collection(COLLECTION_NAME).doc(tarefaId).update({
      'responsaveis': responsaveis,
    });
  }
}
