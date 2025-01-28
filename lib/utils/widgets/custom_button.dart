import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_planning_app/utils/widgets/size_config.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const CustomButton({super.key, required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SizedBox(
      width: Get.mediaQuery.size.width * 0.5,
      height: 50,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        color: Colors.white,
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(fontSize: getProportionateScreenWidth(14)),
        ),
      ),
    );
  }
}
