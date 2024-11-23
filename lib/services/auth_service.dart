import 'package:dio/dio.dart';
import '../models/auth.dart';
import '../services/result.dart';


class AuthService {
  final Dio _dio = Dio();
  final String apiUrl;

  AuthService({required this.apiUrl});

  // Method for registering a new user
  Future<Result> register(String username, String email, String phone,
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
        return Result(
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
            return Result(
              success: false,
              message: message.isEmpty ? 'User already exists' : message,
            );
          } else {
            return Result(
              success: false,
              message: message,
            );
          }
        }
      }
    }
    return Result(
      success: false,
      message: 'Unexpected error: No valid response from the server.',
    );
  }

  // Method for logging in a user
  Future<Result> login(String identifier, String password) async {
    try {
      final response = await _dio.post(
        apiUrl,
        data: {
          'identifier': identifier,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        return Result(
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
            return Result(
              success: false,
              message: message.isEmpty ? 'Invalid credentials' : message,
            );
          } else if (statusCode == 404) {
            return Result(
              success: false,
              message: message.isEmpty ? 'User not found!' : message,
            );
          } else {
            return Result(
              success: false,
              message: message,
            );
          }
        }
      }
    }
    return Result(
      success: false,
      message: 'Unexpected error: No valid response from the server.',
    );
  }
}

