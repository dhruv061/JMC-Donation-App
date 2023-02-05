//this class help to store total payment of currwnt Users
class UserTotalPayment {
  static final UserTotalPayment _session = UserTotalPayment._internal();

  num? userTotalPayment;

  factory UserTotalPayment() {
    return _session;
  }

  UserTotalPayment._internal() {}
}
