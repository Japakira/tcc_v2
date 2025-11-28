//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rxn<User> _currentUser = Rxn<User>();
  final RxBool userIsAuthenticated = false.obs;

  /// Exposição pública como Rx
  Rxn<User> get currentUserRx => _currentUser;

  /// Exposição apenas do valor
  User? get currentUser => _currentUser.value;

  @override
  void onInit() {
    super.onInit();

    /// Sempre que o estado do Firebase mudar, atualiza o Rx
    _auth.authStateChanges().listen((user) {
      _currentUser.value = user;
      userIsAuthenticated.value = user != null;
    });
  }

  // =========================
  // LOGIN
  // =========================
  Future<User?> login(String email, String senha) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email,
        password: senha,
      );
      return cred.user;
    } catch (e) {
      throw Exception('Erro ao efetuar login: $e');
    }
  }

  // =========================
  // LOGOUT
  // =========================
  Future<void> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Erro ao efetuar logout: $e');
    }
  }
}
