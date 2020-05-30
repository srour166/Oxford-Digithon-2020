import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class FirebaseUtils {
  static final FirebaseUtils _singleton = FirebaseUtils._internal();

  factory FirebaseUtils() => _singleton;

  FirebaseUtils._internal();

  Future<bool> handleLogin(
      {@required String email, @required String password}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final AuthResult authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return true;
    } catch (e) {
      print('Invalid details');
      print(e);
    }

    return false;
  }

  Future<bool> handleRegister(
      {@required String email, @required String password}) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    bool result = false;
    try {
      final AuthResult authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      print(authResult);
      result = true;
    } catch (e) {
      print('Invalid details');
      print(e);
    }

    return result;
  }
}
