import 'package:dio/dio.dart';
import '../models/auth.dart';

class AuthService {
  final Dio _dio = Dio();
  final String apiUrl;

  AuthService({required this.apiUrl});

  // Method for registering a new user
  Future<LoginResult> register(String username, String email, String phone,
      String? role, String password) async {
    try {
      final response = await _dio.post(
        apiUrl,
        data: {
          'username': username,
          'email': email,
          'phone': phone,
          'role': role,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        return LoginResult(
          success: true,
          message: 'SignUp successful!',
          user: Auth.fromJson(response.data['user']),
        );
      }
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.badResponse) {
          final statusCode = e.response?.statusCode ?? 0;
          final message =
              e.response?.data['message'] ?? 'Unknown error occurred.';

          if (statusCode == 400) {
            return LoginResult(
              success: false,
              message: message.isEmpty ? 'User already exists' : message,
            );
          } else {
            return LoginResult(
              success: false,
              message: message,
            );
          }
        }
      }
    }
    return LoginResult(
      success: false,
      message: 'Unexpected error: No valid response from the server.',
    );
  }

  // Method for logging in a user
  Future<LoginResult> login(String identifier, String password) async {
    try {
      final response = await _dio.post(
        apiUrl,
        data: {
          'identifier': identifier,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return LoginResult(
          success: true,
          message: 'Login successful!',
          user: Auth.fromJson(response.data['user']),
        );
      }
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.badResponse) {
          final statusCode = e.response?.statusCode ?? 0;
          final message =
              e.response?.data['message'] ?? 'Unknown error occurred.';

          if (statusCode == 401) {
            return LoginResult(
              success: false,
              message: message.isEmpty ? 'Invalid credentials' : message,
            );
          } else if (statusCode == 404) {
            return LoginResult(
              success: false,
              message: message.isEmpty ? 'User not found!' : message,
            );
          } else {
            return LoginResult(
              success: false,
              message: message,
            );
          }
        }
      }
    }
    return LoginResult(
      success: false,
      message: 'Unexpected error: No valid response from the server.',
    );
  }
}

class LoginResult {
  final bool success;
  final String message;
  final Auth? user;

  LoginResult({required this.success, required this.message, this.user});

  // You can add a factory constructor if needed to handle the result better
}
