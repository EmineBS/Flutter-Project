import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/constants.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/themes/app_themes.dart';
import '../../../core/utils/validators.dart';
import 'login_button.dart';
import 'package:grocery/views/auth/components/not_found_dialog.dart';
import 'package:grocery/services/auth_service.dart';
import 'package:grocery/models/auth.dart';
import 'package:grocery/core/config/api_constants.dart';
import 'package:grocery/core/utils/user_session.dart'; // Import the UserSession class

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({
    super.key,
  });

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();
  final TextEditingController emailOrPhoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isPasswordShown = false;
  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  Future<void> onLogin() async {
    final bool isFormOkay = _key.currentState?.validate() ?? false;

    if (isFormOkay) {
      const apiUrl = '${ApiConstants.baseUrl}/auth/login';
      AuthService authService = AuthService(apiUrl: apiUrl);
      final result = await authService.login(
          emailOrPhoneController.text, passwordController.text);

      if (result.success) {
        // Set the client data in the singleton
        //ClientSingleton.instance.setClient(clientData);
        UserSession().setUser({
          'id': result.user?.id,
          'username': result.user?.username,
          'email': result.user?.email,
          'phone': result.user?.phone,
          'role': result.user?.role,
        });
        Navigator.pushReplacementNamed(context, AppRoutes.entryPoint);
      } else {
        showClientNotFoundDialog(context, result.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.defaultTheme.copyWith(
        inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppDefaults.padding),
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Identifiant Field
              const Text("Email or Phone Number"),
              const SizedBox(height: 8),
              TextFormField(
                controller: emailOrPhoneController,
                keyboardType: TextInputType.name,
                validator: Validators.requiredWithFieldName('Phone').call,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: AppDefaults.padding),

              // Password Field
              const Text("Password"),
              const SizedBox(height: 8),
              TextFormField(
                controller: passwordController,
                validator: Validators.password.call,
                onFieldSubmitted: (v) => onLogin(),
                textInputAction: TextInputAction.done,
                obscureText: !isPasswordShown,
                decoration: InputDecoration(
                  suffixIcon: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: onPassShowClicked,
                      icon: SvgPicture.asset(
                        AppIcons.eye,
                        width: 24,
                      ),
                    ),
                  ),
                ),
              ),

              // Forget Password labelLarge
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.forgotPassword);
                  },
                  child: const Text('Forget Password?'),
                ),
              ),

              // Login labelLarge
              LoginButton(onPressed: onLogin),
            ],
          ),
        ),
      ),
    );
  }
}
