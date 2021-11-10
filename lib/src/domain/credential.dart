import 'package:flutter/foundation.dart';

class Credential {
  final AuthType type;
  final String name;
  final String email;
  final String password;

  Credential(
      {@required required this.type,
      required this.name,
      @required required this.email,
      required this.password});
}

enum AuthType { email, google }
