// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:tcc_v2/models/tarefa_model.dart';
// import 'package:tcc_v2/services/load_firebase_service.dart';

// // ignore: constant_identifier_names
// const COLLECTION_NAME = "Tarefas";

// class TarefaService {
//   static Future<List<Tarefa>> getTarefasById(String inicitivaId) async {
//     final db = getFirestoreConnection();
//     List<Tarefa> resultTarefas = List.empty(growable: true);
//     await db.collection(COLLECTION_NAME)
//     .get().then((event) {
//       for (var doc in event.docs) {
//         var json = doc.data();
//         resultTarefas.add(
//           Tarefa(
//             tarefaId: doc.id,
//             tarefaNome: json['tarefaNome'],
//             tarefaDescricao: json['tarefaDescricao'],
//             finalizado: json['finalizado'] ?? false,
//             prazo: json['prazo'],
//             iniciativaMae: json['iniciativaMae'],
//             responsaveis: json['responsaveis'],
//           ),
//         );
//       }
//     });

//     return resultTarefas;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_v2/models/tarefa_model.dart';
import 'package:tcc_v2/services/load_firebase_service.dart';

// ignore: constant_identifier_names
const COLLECTION_NAME = "Tarefas";

class TarefaService {
  static Future<List<Tarefa>> getTarefasById(String iniciativaId) async {
    final db = getFirestoreConnection();
    final List<Tarefa> resultTarefas = [];

    try {
      // Busca somente tarefas cuja iniciativaMae == iniciativaId
      QuerySnapshot snapshot = await db
          .collection(COLLECTION_NAME)
          .where('iniciativaMae', isEqualTo: iniciativaId)
          .get();

      for (var doc in snapshot.docs) {
        final json = doc.data() as Map<String, dynamic>;

        resultTarefas.add(
          Tarefa(
            tarefaId: doc.id,
            tarefaNome: json['tarefaNome'] ?? '',
            tarefaDescricao: json['tarefaDescricao'] ?? '',
            finalizado: json['finalizado'] ?? false,
            prazo: json['prazo'],
            iniciativaMae: json['iniciativaMae'] ?? '',
            // responsaveis: List<String>.from(json['responsaveis'] ?? []),
          ),
        );
      }
    } catch (e) {
      print("Erro ao buscar tarefas: $e");
    }

    return resultTarefas;
  }
}
