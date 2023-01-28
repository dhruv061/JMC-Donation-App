//this is singlon class in which we store current user Id
//after that using this user id we can fetch yser data from firebase

class SessionController {
  static final SessionController _session = SessionController._internal();

  String? userId;

  factory SessionController() {
    return _session;
  }

  SessionController._internal() {}
}
