import 'package:flutter_mongo_stitch/flutter_mongo_stitch.dart';

class MongoHelpers {
  static final MongoHelpers _singleton = MongoHelpers._internal();
  MongoStitchClient _client;

  factory MongoHelpers() => _singleton;

  MongoHelpers._internal() {
    _client = MongoStitchClient();
  }

  Future<bool> register(String email, String password) async {
    final auth = _client.auth;
    return await auth.registerWithEmail(email: email, password: password);
  }
}
