class UserSession {
  // Private constructor
  UserSession._internal();

  // The single instance of the class
  static final UserSession _instance = UserSession._internal();

  // Factory constructor to return the same instance
  factory UserSession() {
    return _instance;
  }

  // The user data that will be stored after login
  Map<String, dynamic>? _user;

  // Method to set user data
  void setUser(Map<String, dynamic>? newUser) {
    _user = newUser;
  }

  // Method to get user data (with a fallback if not set)
  Map<String, dynamic>? getUser() {
    return _user;
  }

  // Method to check if user data exists
  bool isUserLoggedIn() {
    return _user != null;
  }
}
