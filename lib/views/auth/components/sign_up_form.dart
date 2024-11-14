import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/constants.dart';
import '../../../core/utils/validators.dart';
import 'already_have_accout.dart';
import 'sign_up_button.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  // Variable to store the selected role: 0 for Grossiste, 1 for Client, and null for none
  int? selectedRole;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.margin),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: AppDefaults.boxShadow,
        borderRadius: AppDefaults.borderRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("E-mail"),
          const SizedBox(height: 7),
          TextFormField(
            validator: Validators.requiredWithFieldName('Name').call,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,

          ),
          const SizedBox(height: AppDefaults.padding),
          const Text("Identifiant"),
          const SizedBox(height: 7),
          TextFormField(
            textInputAction: TextInputAction.next,
            validator: Validators.required.call,
            keyboardType: TextInputType.name,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: 7),
          const SizedBox(height: AppDefaults.padding),
          const Text("Password"),
          const SizedBox(height: 7),
          TextFormField(
            validator: Validators.required.call,
            textInputAction: TextInputAction.next,
            obscureText: true,
            decoration: InputDecoration(
              suffixIcon: Material(
                color: Colors.transparent,
                child: IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                    AppIcons.eye,
                    width: 24,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: AppDefaults.padding),

          // Adding the Row with radio buttons for Grossiste and Client
          const SizedBox(height: 8),
          Text("Type de compte"),
          const SizedBox(height: 7),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Align radio buttons to the left
            children: [
              // Grossiste Radio Button
              Radio<int>(
                value: 0, // Value for Grossiste
                groupValue: selectedRole, // Group value to maintain the selection
                onChanged: (int? value) {
                  setState(() {
                    selectedRole = value; // Update the selected role to Grossiste
                  });
                },
                activeColor: Colors.blue, // Customize color when selected
              ),
              const Text("Grossiste"),

              // Spacer for spacing between the two radio buttons
              const SizedBox(width: 20),

              // Client Radio Button
              Radio<int>(
                value: 1, // Value for Client
                groupValue: selectedRole, // Group value to maintain the selection
                onChanged: (int? value) {
                  setState(() {
                    selectedRole = value; // Update the selected role to Client
                  });
                },
                activeColor: Colors.blue, // Customize color when selected
              ),
              const Text("Client"),
            ],
          ),

          const SizedBox(height: 5),

          // Sign Up Button
          const SignUpButton(),

          // Link to login if user already has an account
          const AlreadyHaveAnAccount(),
          const SizedBox(height: AppDefaults.padding),
        ],
      ),
    );
  }
}
