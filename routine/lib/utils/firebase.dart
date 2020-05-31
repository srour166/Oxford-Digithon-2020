import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:routine/utils/ActivityCategory.dart';
import 'package:routine/utils/Activity.dart';
import 'package:routine/utils/User.dart';

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
    final DataSnapshot activitiesSnapshot =
        (await ref.child('activities').once());

    List activities = activitiesSnapshot.value;
    List<Activity> activityObjects = [];

    for (int i = 0; i < activities.length; i++) {
      Map element = activities[i];
      if (element != null) {
        activityObjects.add(Activity(
            id: i,
            name: element["name"],
            description: element["description"],
            categories: element["categories"]));
      }
    }

    return activityObjects;
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

  Future<bool> setUserNewActivity(Activity activity) async {
    final ref = _db.reference();
    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) return false;

    final DataSnapshot userData =
        await ref.child('users').child(currentUser.uid).once();

    Map userMap = userData.value;
    userMap['currentActivity'] = activity.id;

    await ref.child('users').child(currentUser.uid).set(userMap);
    return true;
  }

  Future<bool> setUserCompletedActivity(Activity activity) async {
    final ref = _db.reference();
    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) return false;

    final DataSnapshot userData =
        await ref.child('users').child(currentUser.uid).once();

    Map userMap = userData.value;
    if (userMap.containsKey('activitiesCompleted')) {
      userMap['activitiesCompleted'] = [
        ...(userMap['activitiesCompleted'] as List),
        activity.id
      ];
    } else {
      userMap['activitiesCompleted'] = [activity.id];
    }

    userMap['currentActivity'] = null;
    await ref.child('users').child(currentUser.uid).set(userMap);
    return true;
  }

  Future<bool> userSkipCurrentActivity() async {
    final ref = _db.reference();
    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) return false;

    final DataSnapshot userData =
        await ref.child('users').child(currentUser.uid).once();

    Map userMap = userData.value;
    userMap['currentActivity'] = null;
    await ref.child('users').child(currentUser.uid).set(userMap);
    return true;
  }

  Future<void> getActivity() async {
    final db = FirebaseDatabase.instance;
    final ref = db.reference();
    ref.child('activities');
  }

  Future<User> getUser() async {
    final ref = _db.reference();
    FirebaseUser currentUser = await _auth.currentUser();
    if (currentUser == null) return null;

    final DataSnapshot userData =
        (await ref.child('users').child(currentUser.uid).once());

    Map userMap = userData.value;
    print(userMap);
    print(userMap['activitiesCompleted']);
    return User(
      categories: userMap['categories'] == null
          ? []
          : userMap['categories'].toString().split(','),
      activitiesCompleted: userMap['activitiesCompleted'] == null
          ? []
          : userMap['activitiesCompleted'].cast<int>(),
      currentActivity: userMap['currentActivity'],
    );
  }

  Future<int> getUserCurrentActivity() async {
    final User user = await getUser();
    return user.currentActivity;
  }

  Future<List<int>> getUserCompletedActivites() async {
    final User user = await getUser();
    return user.activitiesCompleted;
  }

  Future<List<String>> getUserPreferences() async {
    final User user = await getUser();
    return user.categories;
  }

  Future<List<Activity>> getUserMatchingActivities() async {
    final User user = await getUser();
    List<String> userPreferences = user.categories;
    List<Activity> allActivites = await getActivities();
    List<Activity> matchingActivites = allActivites
        .where((activity) =>
            userPreferences.contains(activity.categories) &&
            !user.activitiesCompleted.contains(activity.id))
        .toList();

    if (matchingActivites.isEmpty) return allActivites;
    return matchingActivites;
  }
}
