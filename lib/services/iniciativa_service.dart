import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tcc_v2/models/iniciativa_model.dart';
import 'package:tcc_v2/services/load_firebase_service.dart';

// ignore: constant_identifier_names
const COLLECTION_NAME = "Iniciativas";

class IniciativaService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Iniciativa>> getAllIniciativas() async {
    final db = getFirestoreConnection();

    List<Iniciativa> resultIniciativas = List.empty(growable: true);

    await db.collection(COLLECTION_NAME).get().then((event) {
      for (var doc in event.docs) {
        var json = doc.data();
        resultIniciativas.add(
          Iniciativa(
            iniciativaId: doc.id,
            iniciativaNome: json['iniciativaNome'],
            iniciativaDescricao: json['iniciativaDescricao'],
            finalizado: json['finalizado'] ?? false,
            gestoresRef: json['gestoresRef'],
          ),
        );
      }
    });

    return resultIniciativas;
  }
}
