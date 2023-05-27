import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:innerverse/data/repository/firebase_authentication_repository.dart';
import 'package:innerverse/di/dependency_injection.dart';
import 'package:innerverse/l10n/l10n.dart';
import 'package:innerverse/navigation/routes.gr.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/app_ui.dart';
import 'package:innerverse/utils/assets_path.dart';
import 'package:innerverse/utils/my_elevated_button.dart';
import 'package:innerverse/views/login/bloc/authentication_bloc.dart';

@RoutePage()
class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        firebaseAuthenticationRepository:
            getIt<FirebaseAuthenticationRepository>(),
      ),
      child: const SigninPageView(),
    );
  }
}

class SigninPageView extends HookWidget {
  const SigninPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailController = useTextEditingController(text: 'user@mail.com');
    final passwordController = useTextEditingController(text: 'test123');
    final emailError = useState(false);
    final passwordError = useState(false);
    final emailFocusNode = useFocusNode();
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        emailError.value = !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$')
            .hasMatch(emailController.text);
      }
    });
    final passwordFocusNode = useFocusNode();
    passwordFocusNode.addListener(() {
      if (!passwordFocusNode.hasFocus) {
        passwordError.value = passwordController.text.length < 6;
      }
    });

    bool isError() {
      emailError.value = !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$')
          .hasMatch(emailController.text);
      passwordError.value = passwordController.text.length < 6;
      return !emailError.value && !passwordError.value;
    }

    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        state.maybeWhen(
          orElse: () {},
          error: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.periwinkleGray,
                duration: const Duration(milliseconds: 800),
                content: Text(
                  error,
                  style: context.textStyle.size14.semiBold
                      .withColor(AppColors.black),
                ),
              ),
            );
          },
          signInSuccessfull: (user) {
            AutoRouter.of(context).replaceAll(
              <PageRouteInfo>[const TabRoute()],
            );
          },
        );
      },
      child: SafeArea(
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
                        controller: emailController,
                        onChanged: (value) {
                          emailError.value = false;
                        },
                        focusNode: emailFocusNode,
                        onSubmitted: (value) {
                          emailError.value =
                              !RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,}$')
                                  .hasMatch(value);
                        },
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
                    Visibility(
                      visible: emailError.value,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20.toResponsiveWidth(context),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 9,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              context.l10n.emailError,
                              style:
                                  context.textStyle.semiBold.size14.withColor(
                                Colors.red,
                              ),
                            ),
                          ],
                        ),
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
                        onChanged: (value) {
                          passwordError.value = false;
                        },
                        focusNode: passwordFocusNode,
                        onSubmitted: (value) {
                          passwordError.value = value.length < 6;
                        },
                        controller: passwordController,
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
                    Visibility(
                      visible: passwordError.value,
                      child: Padding(
                        padding: EdgeInsets.only(
                          left: 20.toResponsiveWidth(context),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.circle,
                              size: 9,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              context.l10n.createPasswordError,
                              style:
                                  context.textStyle.semiBold.size14.withColor(
                                Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MyElevatedButton(
                      onPressed: () {
                        if (isError()) {
                          context.read<AuthenticationBloc>().add(
                                AuthenticationEvent.signin(
                                  email: emailController.text,
                                  password: passwordController.text,
                                ),
                              );
                        }
                      },
                      borderRadius: BorderRadius.circular(30),
                      child:
                          BlocBuilder<AuthenticationBloc, AuthenticationState>(
                        builder: (context, state) {
                          return state.maybeWhen(
                            orElse: () => Text(
                              'Sign In',
                              style:
                                  context.textStyle.semiBold.size20.withColor(
                                AppColors.black,
                              ),
                            ),
                            loading: () => const SizedBox(
                              height: 25,
                              width: 25,
                              child: CircularProgressIndicator(
                                color: AppColors.black,
                              ),
                            ),
                          );
                        },
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
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.rhino,
                      ),
                      child: ElevatedButton(
                        onPressed: () => context.read<AuthenticationBloc>().add(
                              const AuthenticationEvent.signInWithGoogle(),
                            ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.transparent,
                          shadowColor: AppColors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            icnGoogle,
                            height: 50.toResponsiveHeight(context),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
