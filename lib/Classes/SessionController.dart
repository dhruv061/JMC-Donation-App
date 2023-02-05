//this is singlon class in which we store current user Id
//after that using this user id we can fetch yser data from firebase

class SessionController {
  //this  _instance use beacuse we can easily access the UserData class data in every page
  static final SessionController _session = SessionController._internal();

  String? userId;

  factory SessionController() {
    return _session;
  }

  SessionController._internal() {}
}
