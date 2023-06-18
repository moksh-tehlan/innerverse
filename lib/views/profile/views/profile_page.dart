import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:innerverse/data/repository/user_repository.dart';
import 'package:innerverse/di/dependency_injection.dart';
import 'package:innerverse/navigation/routes.gr.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/assets_path.dart';
import 'package:innerverse/utils/my_elevated_button.dart';
import 'package:innerverse/views/profile/bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserBloc(userRepository: getIt<UserRepository>())
        ..add(const UserEvent.getUser()),
      child: const ProfilePageView(),
    );
  }
}

class ProfilePageView extends StatelessWidget {
  const ProfilePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.deepCover,
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              return Column(
                children: [
                  const Center(
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: AssetImage(girlPrfilePic),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  state.maybeWhen(
                    orElse: () => const SizedBox(),
                    userLoaded: (userModel) => Text(
                      userModel.name ?? '',
                      style: context.textStyle.regular.size22
                          .withColor(AppColors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(15),
                    width: double.infinity,
                    height: 250,
                    decoration: BoxDecoration(
                      color: AppColors.rhino,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Information',
                          style: context.textStyle.regular.size20
                              .withColor(AppColors.white),
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(
                              Icons.person,
                              color: AppColors.orchidPink,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            state.maybeWhen(
                              orElse: () => const SizedBox(),
                              userLoaded: (userModel) => Text(
                                userModel.name ?? '',
                                style: context.textStyle.regular.size16
                                    .withColor(AppColors.paleWhite),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppColors.white,
                        ),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const Icon(
                              Icons.mail_outline_rounded,
                              color: AppColors.orchidPink,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            state.maybeWhen(
                              orElse: () => const SizedBox(),
                              userLoaded: (userModel) => Text(
                                userModel.email ?? '',
                                style: context.textStyle.regular.size16
                                    .withColor(AppColors.paleWhite),
                              ),
                            ),
                          ],
                        ),
                        const Divider(
                          color: AppColors.white,
                        ),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  MyElevatedButton(
                    onPressed: ()  async{
                      await firebaseAuth.signOut();
                      final sharedPref = await SharedPreferences.getInstance();
                      await sharedPref.clear();
                      gptMessageModelList.clear();
                      AutoRouter.of(context).replaceAll(
                        <PageRouteInfo>[const SignupRoute()],
                      );
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Text(
                      'Log Out',
                      style: context.textStyle.semiBold.size20.withColor(
                        AppColors.black,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
