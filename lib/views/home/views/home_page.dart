import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innerverse/data/repository/quotes_repository.dart';
import 'package:innerverse/data/repository/user_repository.dart';
import 'package:innerverse/di/dependency_injection.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/app_ui.dart';
import 'package:innerverse/utils/assets_path.dart';
import 'package:innerverse/views/home/views/bloc/home_bloc.dart';
import 'package:innerverse/views/profile/bloc/user_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/top_articles_card.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              HomeBloc(quotesRepository: getIt<QuotesRepository>())
                ..add(const HomeEvent.getQuote()),
        ),
        BlocProvider(
          create: (context) => UserBloc(userRepository: getIt<UserRepository>())
            ..add(const UserEvent.getUser()),
        )
      ],
      child: const HomePageView(),
    );
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      // alignment: Alignment.topCenter,
      children: [
        const SizedBox.expand(
          child: Image(
            image: AssetImage(natureImg),
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          left: 0,
          bottom: 0,
          right: 0,
          top: 0,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.homeGradiantBlackA,
                  AppColors.homeGradiantBlackB
                ],
              ),
            ),
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.transparent,
                body: Padding(
                  padding: EdgeInsets.all(15.toResponsiveWidth(context)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          const CircleAvatar(
                            radius: 30,
                            backgroundImage: AssetImage(girlPrfilePic),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hi there,',
                                style: context.textStyle.semiBold.size20
                                    .withColor(AppColors.white),
                              ),
                              BlocBuilder<UserBloc, UserState>(
                                builder: (context, state) {
                                  return state.maybeWhen(
                                    orElse: () => const SizedBox(),
                                    userLoaded: (userModel) => Text(
                                      userModel.name ?? '',
                                      style: context.textStyle.semiBold.size23
                                          .withColor(AppColors.white),
                                    ),
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 70.toResponsiveHeight(context),
                      ),
                      Stack(
                        alignment: Alignment.topLeft,
                        children: [
                          BlocBuilder<HomeBloc, HomeState>(
                            builder: (context, state) {
                              return state.when(
                                loadQuote: (quote) {
                                  return Text(
                                    quote,
                                    style: context.textStyle.bold.size20
                                        .withColor(AppColors.white),
                                    textAlign: TextAlign.center,
                                  );
                                },
                                initial: (String quote) {
                                  return Text(
                                    quote,
                                    style: context.textStyle.bold.size20
                                        .withColor(AppColors.white),
                                    textAlign: TextAlign.center,
                                  );
                                },
                                error: (String error) {
                                  return Text(
                                    error,
                                    style: context.textStyle.bold.size35
                                        .withColor(AppColors.white),
                                    textAlign: TextAlign.center,
                                  );
                                },
                              );
                            },
                          ),
                          Transform.translate(
                            offset: const Offset(-15, -25),
                            child: Transform.rotate(
                              angle: 135,
                              child: const Icon(
                                Icons.format_quote_sharp,
                                size: 70,
                                color: Color(
                                  0x38FFFFFF,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          context
                              .read<HomeBloc>()
                              .add(const HomeEvent.getQuote());
                        },
                        child: Container(
                          width: 160.toResponsiveWidth(context),
                          decoration: BoxDecoration(
                            color: const Color(
                              0x38FFFFFF,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cached_rounded,
                                color: AppColors.white,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                'Refresh',
                                style: context.textStyle.regular.size20
                                    .withColor(AppColors.white),
                              )
                            ],
                          ),
                        ),
                      ),
                      const Expanded(child: SizedBox()),
                      const TopArticlesCard(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
