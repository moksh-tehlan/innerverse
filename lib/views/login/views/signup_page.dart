import 'package:flutter/material.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.apricot,
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            overscroll: false,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'Sign Up',
                  style: context.textStyle.bold.size30.withColor(
                    AppColors.black,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
