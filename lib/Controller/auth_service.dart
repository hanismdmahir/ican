import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Stream<String> get onAuthStateChanged => _firebaseAuth.onAuthStateChanged.map(
  //      (FirebaseUser user) => user?.uid,
  //    );

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<User> signInEmailPassword(String email, String password) async{
    return (await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      )).user;
  }
}
