import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/screens/authentication/widgets/register_form.dart';
import 'package:meal_planning_app/utils/image_urls.dart';
import 'package:meal_planning_app/utils/size_config.dart';
import 'package:meal_planning_app/utils/themes.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
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
                color: Themes.lightTheme.primaryColor,
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
                color: Themes.lightTheme.secondaryHeaderColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(200),
                ),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // App logo
                      SizedBox(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.1,
                        child: Image.asset(logoWithoutBg),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.06),
                      // Register title
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.05),
                      // Register form
                      const RegisterForm(),
                      SizedBox(height: SizeConfig.screenHeight * 0.08),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
