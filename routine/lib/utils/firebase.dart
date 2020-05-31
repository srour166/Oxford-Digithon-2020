import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:routine/utils/ActivityCategory.dart';
import 'package:routine/utils/Activity.dart';

class FirebaseUtils {
  static final FirebaseUtils _singleton = FirebaseUtils._internal();
  static FirebaseAuth _auth;
  static FirebaseDatabase _db;

  factory FirebaseUtils() => _singleton;

  FirebaseUtils._internal() {
    _auth = FirebaseAuth.instance;
    _db = FirebaseDatabase.instance;
  }

  Future<bool> handleLogin(
      {@required String email, @required String password}) async {
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

  Future<List<Activity>> getActivities() async {
    final ref = _db.reference();
    final DataSnapshot categoriesSnapshot =
        (await ref.child('activities').once());

    List categories = categoriesSnapshot.value;
    List<Activity> categoryObjects = [];
    categories.forEach((element) {
      if (element != null) {
        categoryObjects.add(Activity(
            name: element["name"],
            description: element["description"],
            categories: element["categories"]));
      }
    });

    return categoryObjects;
  }

  Future<List<ActivityCategory>> getCategories() async {
    final ref = _db.reference();
    final DataSnapshot categoriesSnapshot =
        (await ref.child('categories').once());

    Map categories = categoriesSnapshot.value;
    List<ActivityCategory> categoryObjects = [];
    categories.entries.forEach((element) {
      categoryObjects.add(ActivityCategory(
          name: element.key, imageUrl: element.value['image']));
    });

    return categoryObjects;
  }

  Future<bool> setUserPreferences(List<ActivityCategory> categories) async {
    final ref = _db.reference();
    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) return false;

    await ref.child('users').child(currentUser.uid).set({
      'categories': categories.map((e) => e.name).join(','),
    });

    return true;
  }

  Future<void> getActivity() async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference();
    ref.child('activities');
  }

  Future<List<String>> getUserPreferences() async {
    final ref = _db.reference();
    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) return const [];

    final DataSnapshot userPreferences =
        (await ref.child('users').child(currentUser.uid).once());
    return userPreferences.value == null
        ? []
        : userPreferences.value['categories'].toString().split(',');
  }

  Future<List<Activity>> getUserMatchingActivities() async {
    List<String> userPreferences = await getUserPreferences();
    List<Activity> allActivites = await getActivities();
    List<Activity> matchingActivites = allActivites
        .where((activity) => userPreferences.contains(activity.categories))
        .toList();

    if (matchingActivites.isEmpty) return allActivites;
    return matchingActivites;
  }
}
