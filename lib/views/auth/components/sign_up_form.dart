import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/constants/constants.dart';
import '../../../core/utils/validators.dart';
import 'already_have_accout.dart';
import 'sign_up_button.dart';
import 'package:grocery/views/auth/components/not_found_dialog.dart';
import 'package:grocery/services/auth_service.dart';
import 'package:grocery/models/auth.dart';
import 'package:grocery/core/config/api_constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Variable to store the selected role
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  String? selectedRole;
  final List<String> roles = ['Client', 'Wholesaler'];

  final _key = GlobalKey<FormState>();

  bool isPasswordShown = false;
  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  bool isRePasswordShown = false;
  onRePassShowClicked() {
    isRePasswordShown = !isRePasswordShown;
    setState(() {});
  }

  Future<void> onSignUp() async {
    final bool isFormOkay = _key.currentState?.validate() ?? false;

    if (isFormOkay) {
      const apiUrl = '${ApiConstants.baseUrl}/auth/register';
      AuthService authService = AuthService(apiUrl: apiUrl);
      final result = await authService.register(
          usernameController.text,
          emailController.text,
          phoneController.text,
          selectedRole,
          passwordController.text);

      if (result.success) {
        // Set the client data in the singleton
        //ClientSingleton.instance.setClient(clientData);

        Navigator.pushReplacementNamed(context, AppRoutes.entryPoint);
      } else {
        showClientNotFoundDialog(context, result.message);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Form(
        key: _key,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Name Field
            const Text("Name"),
            const SizedBox(height: 7),
            TextFormField(
              controller: usernameController,
              validator: (value) => value!.isEmpty ? 'Name is required' : null,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
            ),
            const SizedBox(height: 16.0),

            // Phone Field
            const Text("Phone"),
            const SizedBox(height: 7),
            TextFormField(
              controller: phoneController,
              validator: (value) => value!.isEmpty ? 'Phone is required' : null,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
            const SizedBox(height: 16.0),

            // Email Field
            const Text("Email"),
            const SizedBox(height: 7),
            TextFormField(
              controller: emailController,
              validator: (value) => value!.isEmpty ? 'Email is required' : null,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),

            // Password Field
            const Text("Password"),
            const SizedBox(height: 7),
            TextFormField(
              controller: passwordController,
              validator: Validators.password.call,
              textInputAction: TextInputAction.next,
              obscureText: !isPasswordShown,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    onPassShowClicked();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Confirm Password Field
            const Text("Retype Password"),
            const SizedBox(height: 7),
            TextFormField(
              controller: confirmPasswordController,
              validator: (value) {
                if (value!.isEmpty) return 'Please confirm your password';
                if (value != passwordController.text)
                  return 'Passwords do not match';
                return null;
              },
              textInputAction: TextInputAction.done,
              obscureText: !isRePasswordShown,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: () {
                    onRePassShowClicked();
                  },
                ),
              ),
            ),
            const SizedBox(height: 16.0),

            // Scroll List for selecting role
            const Text("Role"),
            const SizedBox(height: 7),
            DropdownButtonFormField<String>(
              value: selectedRole,
              items: roles.map((role) {
                return DropdownMenuItem(
                  value: role,
                  child: Text(role),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedRole = value;
                });
              },
              validator: (value) =>
                  value == null ? 'Please select a role' : null,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),

            // Sign Up Button
            LoginButton(onPressed: onSignUp),

            // Link to login if user already has an account
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.login);
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
