//this class help to store currebnt user total Rewards
class UserTotalRewards {
  static final UserTotalRewards _session = UserTotalRewards._internal();

  int? userTotalRewards;

  factory UserTotalRewards() {
    return _session;
  }

  UserTotalRewards._internal() {}
}
