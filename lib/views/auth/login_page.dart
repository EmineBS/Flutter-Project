import 'package:flutter/material.dart';
import '../../core/constants/constants.dart';
import 'components/dont_have_account_row.dart';
import 'components/login_header.dart';
import 'components/login_page_form.dart';
import '../../../core/routes/app_routes.dart';
import 'package:grocery/core/utils/user_session.dart'; // Import the UserSession class

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    _checkUserSession();
  }

  void _checkUserSession() {
    // Check if the user is already logged in
    if (UserSession().getUser() != null) {
      // Navigate to the entry point page if user data exists
      Future.microtask(() {
        Navigator.pushReplacementNamed(context, AppRoutes.entryPoint);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LoginPageHeader(),
                LoginPageForm(),
                SizedBox(height: AppDefaults.padding),
                // SocialLogins(),
                DontHaveAccountRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
