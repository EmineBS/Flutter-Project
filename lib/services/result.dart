import '../models/auth.dart';

class Result {
  final bool success;
  final String message;
  final Auth? user;

  Result({required this.success, required this.message, this.user});

// You can add a factory constructor if needed to handle the result better
}