class UserData {
  // Create a private constructor so that the class can only be instantiated
  // inside this file
  UserData._privateConstructor();

  // Create a static instance of the class
  static final UserData _instance = UserData._privateConstructor();

  // Fields for the user's name and email
  late String name;
  late String email;

  // Provide a factory constructor that takes a JSON map and creates an
  // instance of the class
  //data comes from ProfileAfterLogin Page --> Data Comes From realtime db
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData._instance
      ..name = json['Name']
      ..email = json['Email'];
  }

  // Provide a getter for accessing the instance of the class
  static UserData get instance => _instance;
}
