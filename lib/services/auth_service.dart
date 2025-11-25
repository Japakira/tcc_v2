import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {
  final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Rxn<User> _currentUser = Rxn<User>();
  final RxBool userIsAuthenticated = false.obs;

  @override
  void onInit() {
    super.onInit();

    _currentUser.bindStream(_auth.authStateChanges());

    ever<User?>(_currentUser, (user) {
      userIsAuthenticated.value = user != null;
    });
  }

  User? get currentUser => _currentUser.value;

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
