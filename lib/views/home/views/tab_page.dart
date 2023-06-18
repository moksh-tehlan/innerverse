import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/app_ui.dart';
import 'package:innerverse/views/chat/views/chat_page.dart';
import 'package:innerverse/views/home/views/home_page.dart';
import 'package:innerverse/views/profile/views/profile_page.dart';

@RoutePage()
class TabPage extends StatelessWidget {
  const TabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const TabBarPageView();
  }
}

class TabBarPageView extends HookWidget {
  const TabBarPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final tabIndex = useState(0);
    const screens = [HomePage(), ChatPage(), ProfilePage()];

    return Scaffold(
      backgroundColor: AppColors.deepCover,
      body: screens[tabIndex.value],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.white.withOpacity(0.30),
              spreadRadius: 0.5,
              blurRadius: 14,
            ),
          ],
          color: AppColors.deepCover,
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        height: 70.toResponsiveHeight(context),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            InkWell(
              highlightColor: AppColors.white,
              splashColor: AppColors.white,
              onTap: () => tabIndex.value = 0,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home_rounded,
                      color: tabIndex.value == 0
                          ? AppColors.orchidPink
                          : AppColors.white,
                    ),
                    Text(
                      'Home',
                      style: context.textStyle.bold.size12.withColor(
                        tabIndex.value == 0
                            ? AppColors.orchidPink
                            : AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            InkWell(
              highlightColor: AppColors.white,
              splashColor: AppColors.white,
              onTap: () => tabIndex.value = 1,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.message_rounded,
                      color: tabIndex.value == 1
                          ? AppColors.orchidPink
                          : AppColors.white,
                    ),
                    Text(
                      'Chat',
                      style: context.textStyle.bold.size12.withColor(
                        tabIndex.value == 1
                            ? AppColors.orchidPink
                            : AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // InkWell(
            //   highlightColor: AppColors.white,
            //   splashColor: AppColors.white,
            //   onTap: () => tabIndex.value = 2,
            //   child: SizedBox(
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(
            //           Icons.post_add_rounded,
            //           color: tabIndex.value == 2
            //               ? AppColors.orchidPink
            //               : AppColors.white,
            //         ),
            //         Text(
            //           'Posts',
            //           style: context.textStyle.bold.size12.withColor(
            //             tabIndex.value == 2
            //                 ? AppColors.orchidPink
            //                 : AppColors.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            InkWell(
              highlightColor: AppColors.white,
              splashColor: AppColors.white,
              onTap: () => tabIndex.value = 2,
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_2_rounded,
                      color: tabIndex.value == 2
                          ? AppColors.orchidPink
                          : AppColors.white,
                    ),
                    Text(
                      'Profile',
                      style: context.textStyle.bold.size12.withColor(
                        tabIndex.value == 2
                            ? AppColors.orchidPink
                            : AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
