import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:innerverse/data/repository/firebase_authentication_repository.dart';
import 'package:innerverse/di/dependency_injection.dart';
import 'package:innerverse/l10n/l10n.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/app_ui.dart';
import 'package:innerverse/utils/assets_path.dart';
import 'package:innerverse/utils/my_elevated_button.dart';
import 'package:innerverse/views/login/authentication/authentication_bloc.dart';

@RoutePage()
class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthenticationBloc(
        firebaseAuthenticationRepository:
            getIt<FirebaseAuthenticationRepository>(),
      ),
      child: const _SignupPageView(),
    );
  }
}

class _SignupPageView extends HookWidget {
  const _SignupPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final emailController = useTextEditingController();
    final createPasswordController = useTextEditingController();
    final confirmPasswordController = useTextEditingController();
    final nameError = useState(false);
    final emailError = useState(false);
    final createPasswordError = useState(false);
    final confirmPasswordError = useState(false);
    final nameFocusNode = useFocusNode();
    nameFocusNode.addListener(() {
      if (!nameFocusNode.hasFocus) {
        nameError.value = nameController.text.length < 3;
      }
    });
    final emailFocusNode = useFocusNode();
    emailFocusNode.addListener(() {
      if (!emailFocusNode.hasFocus) {
        emailError.value = !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$')
            .hasMatch(emailController.text);
      }
    });
    final createPasswordFocusNode = useFocusNode();
    createPasswordFocusNode.addListener(() {
      if (!createPasswordFocusNode.hasFocus) {
        createPasswordError.value = createPasswordController.text.length < 6;
        if (createPasswordController.text.isNotEmpty &&
            confirmPasswordController.text.isNotEmpty) {
          confirmPasswordError.value =
              createPasswordController.text != confirmPasswordController.text;
        }
      }
    });
    final confirmPasswordFocusNode = useFocusNode();
    confirmPasswordFocusNode.addListener(() {
      if (!confirmPasswordFocusNode.hasFocus) {
        confirmPasswordError.value =
            createPasswordController.text != confirmPasswordController.text;
      }
    });

    bool isError() {
      nameError.value = nameController.text.length < 3;
      emailError.value = !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$')
          .hasMatch(emailController.text);
      createPasswordError.value = createPasswordController.text.length < 6;
      confirmPasswordError.value =
          createPasswordController.text != confirmPasswordController.text;
      return !nameError.value &&
          !emailError.value &&
          !createPasswordError.value &&
          !confirmPasswordError.value;
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
            signUpSuccessfull: (user){},);
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
                    Text(
                      context.l10n.signUp,
                      style: context.textStyle.bold.size30.withColor(
                        AppColors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      context.l10n.createAccount,
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
                        focusNode: nameFocusNode,
                        onChanged: (value) => nameError.value = false,
                        onSubmitted: (value) =>
                            nameError.value = nameController.text.length < 3,
                        controller: nameController,
                        style: context.textStyle.size18.withColor(
                          AppColors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Name',
                          hintStyle: context.textStyle.size18.withColor(
                            AppColors.white,
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.white,
                      ),
                    ),
                    Visibility(
                      visible: nameError.value,
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
                              context.l10n.nameError,
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
                          emailError.value = false;
                        },
                        focusNode: emailFocusNode,
                        onSubmitted: (value) {
                          emailError.value =
                              !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$')
                                  .hasMatch(value);
                        },
                        controller: emailController,
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
                          createPasswordError.value = false;
                        },
                        focusNode: createPasswordFocusNode,
                        onSubmitted: (value) {
                          createPasswordError.value = value.length < 6;
                        },
                        controller: createPasswordController,
                        style: context.textStyle.size18.withColor(
                          AppColors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Create Password',
                          hintStyle: context.textStyle.size18.withColor(
                            AppColors.white,
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.white,
                      ),
                    ),
                    Visibility(
                      visible: createPasswordError.value,
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
                          confirmPasswordError.value = false;
                        },
                        focusNode: confirmPasswordFocusNode,
                        onSubmitted: (value) {
                          confirmPasswordError.value =
                              createPasswordController.text != value;
                        },
                        controller: confirmPasswordController,
                        style: context.textStyle.size18.withColor(
                          AppColors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: context.textStyle.size18.withColor(
                            AppColors.white,
                          ),
                          border: InputBorder.none,
                        ),
                        cursorColor: AppColors.white,
                      ),
                    ),
                    Visibility(
                      visible: confirmPasswordError.value,
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
                              context.l10n.confirmPasswordError,
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
                                AuthenticationEvent.signup(
                                  emailAddress: emailController.text,
                                  password: confirmPasswordController.text,
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
                              context.l10n.signUp,
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
                        context.l10n.signUpWith,
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
                    const Expanded(child: SizedBox()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          context.l10n.accountExists,
                          style: context.textStyle.semiBold.size14.withColor(
                            AppColors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        DecoratedBox(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.orchidPink),
                            ),
                          ),
                          child: InkWell(
                            onTap: () =>
                                AutoRouter.of(context).pushNamed('/signin'),
                            child: Text(
                              context.l10n.login,
                              style:
                                  context.textStyle.semiBold.size14.withColor(
                                AppColors.orchidPink,
                              ),
                            ),
                          ),
                        )
                      ],
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
