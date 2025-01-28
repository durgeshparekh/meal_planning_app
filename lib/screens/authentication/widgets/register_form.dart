import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/controllers/login_controller.dart';
import 'package:meal_planning_app/utils/widgets/size_config.dart';
import 'package:meal_planning_app/utils/widgets/rounded_text_form_field.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the login controller
    var controller = Get.find<LoginController>();
    // Clear text fields in the controller
    controller.clearTextFields();
    // Initialize size configuration
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Name input field
          RoundedTextFormField(
            hintText: "Your Name",
            labelText: "Name",
            controller: controller.nameController,
            prefixIcon: Icon(Icons.person),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Name is required";
              }
              return null;
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          // Email input field
          RoundedTextFormField(
            hintText: "Email",
            labelText: "Email",
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icon(Icons.email),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Email is required";
              }
              return null;
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          // Password input field
          RoundedTextFormField(
            hintText: "Password",
            labelText: "Password",
            controller: controller.passwordController,
            isPasswordField: true,
            prefixIcon: Icon(Icons.lock),
            validator: (value) {
              if (value == null || value.length < 6) {
                return "Password must be at least 6 characters long";
              }
              return null;
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.03),
          // Confirm password input field
          RoundedTextFormField(
            hintText: "Confirm Password",
            labelText: "Confirm Password",
            controller: controller.confirmPasswordController,
            isPasswordField: true,
            prefixIcon: Icon(Icons.lock),
            validator: (value) {
              if (value == null ||
                  value != controller.passwordController.text) {
                return "Passwords do not match";
              }
              return null;
            },
          ),
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          // Register button
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () => controller.registerUser(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(),
                color: Colors.white,
              ),
              child: const Text("Register"),
            ),
          ),
        ],
      ),
    );
  }
}
