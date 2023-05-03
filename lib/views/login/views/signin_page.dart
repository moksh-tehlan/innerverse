import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/app_ui.dart';
import 'package:innerverse/utils/assets_path.dart';
import 'package:innerverse/utils/my_elevated_button.dart';

@RoutePage()
class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.deepCover,
        body: ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(
            overscroll: false,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(20.toResponsiveWidth(context)),
              height: 765.toResponsiveHeight(context),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        child: const Icon(
                          Icons.arrow_back_ios_new,
                          color: AppColors.white,
                          size: 25,
                        ),
                        onTap: () => AutoRouter.of(context).pop(),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Sign In',
                        style: context.textStyle.bold.size30.withColor(
                          AppColors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Welcome back to\nInnerverse',
                    style: context.textStyle.regular.size18.withColor(
                      AppColors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.toResponsiveWidth(context),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.rhino,
                    ),
                    child: TextField(
                      style: context.textStyle.size18.withColor(
                        AppColors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Email-Id',
                        hintStyle: context.textStyle.size18.withColor(
                          AppColors.white,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: AppColors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.toResponsiveWidth(context),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.rhino,
                    ),
                    child: TextField(
                      style: context.textStyle.size18.withColor(
                        AppColors.white,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Password',
                        hintStyle: context.textStyle.size18.withColor(
                          AppColors.white,
                        ),
                        border: InputBorder.none,
                      ),
                      cursorColor: AppColors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MyElevatedButton(
                    onPressed: () => {},
                    borderRadius: BorderRadius.circular(30),
                    child: Text(
                      'Sign In',
                      style: context.textStyle.semiBold.size20.withColor(
                        AppColors.black,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Text(
                      'or sign in with',
                      style: context.textStyle.semiBold.size14.withColor(
                        AppColors.white,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.toResponsiveWidth(context),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: AppColors.rhino,
                    ),
                    child: Center(
                      child: Image.asset(
                        icnGoogle,
                        height: 50.toResponsiveHeight(context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
