import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/controllers/login_controller.dart';
import 'package:meal_planning_app/utils/image_urls.dart';
import 'package:meal_planning_app/utils/size_config.dart';

import 'register_screen.dart';
import 'widgets/sign_in_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the LoginController
    Get.put(LoginController());
    // Initialize size configuration
    SizeConfig().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background decoration
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.35,
              margin: EdgeInsets.only(right: 1),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(200),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.25,
              margin: EdgeInsets.only(right: 1),
              decoration: BoxDecoration(
                color: Theme.of(context).secondaryHeaderColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(200)),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 25,
                  right: 25,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(height: SizeConfig.screenHeight * 0.1),
                    // App logo
                    SizedBox(
                      width: SizeConfig.screenWidth,
                      height: SizeConfig.screenHeight * 0.1,
                      child: Image.asset(logoWithoutBg),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.06),
                    // Sign in title
                    Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: getProportionateScreenWidth(25),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: SizeConfig.screenHeight * 0.08),
                    // Sign in form
                    const SignInForm(),
                    SizedBox(height: SizeConfig.screenHeight * 0.2),
                    // Register link
                    GestureDetector(
                      onTap: () {
                        Get.to(() => const RegisterScreen());
                      },
                      child: Text(
                        "Not a user? Register here",
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
