import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/screens/authentication/widgets/register_form.dart';
import 'package:meal_planning_app/utils/size_config.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: SizeConfig.screenWidth,
              height: SizeConfig.screenHeight * 0.35,
              margin: EdgeInsets.only(right: 1),
              decoration: BoxDecoration(
                color: Colors.indigo.shade300,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(200),
                  // topLeft: Radius.circular(50),
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
                color: Colors.indigo.shade600,
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
                      SizedBox(
                        width: SizeConfig.screenWidth,
                        height: SizeConfig.screenHeight * 0.1,
                        // child: Image.asset(logoWithoutBg),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.06),
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: getProportionateScreenWidth(25),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: SizeConfig.screenHeight * 0.05),
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
