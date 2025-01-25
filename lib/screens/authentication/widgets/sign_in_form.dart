import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/controllers/login_controller.dart';
import 'package:meal_planning_app/utils/size_config.dart';
import 'package:meal_planning_app/utils/widgets/rounded_text_form_field.dart';

class SignInForm extends StatelessWidget {
  const SignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LoginController>();
    SizeConfig().init(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          RoundedTextFormField(
            hintText: "Enter your email",
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
          RoundedTextFormField(
            hintText: "Enter your password",
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
          SizedBox(height: SizeConfig.screenHeight * 0.05),
          InkWell(
            borderRadius: BorderRadius.circular(15),
            onTap: () => controller.userLogin(),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(),
                color: Colors.white,
              ),
              child: const Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
