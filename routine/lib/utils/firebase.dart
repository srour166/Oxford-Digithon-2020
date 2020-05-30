import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

import 'package:routine/utils/Category.dart' as prefix;

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

  Future<Category> getCategories() async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference();
    final DataSnapshot categories = (await ref.child('categories').once());
    print(categories.value);
  }

  Future<bool> setUserPreferences(List<Category> categories) {}

  Future<void> getActivity() async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference();
    ref.child('activities');
  }
}
