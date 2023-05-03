import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:innerverse/l10n/l10n.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/app_ui.dart';
import 'package:innerverse/utils/assets_path.dart';
import 'package:innerverse/utils/my_elevated_button.dart';
import 'package:innerverse/views/on_boarding/widgets/page_content.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

@RoutePage()
class OnBoardingPage extends HookWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final imageController = usePageController();
    final isLastPage = useState(false);

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.deepCover,
        appBar: AppBar(
          backgroundColor: AppColors.deepCover,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.l10n.appName,
                style: context.textStyle.bold.size30.withColor(
                  AppColors.white,
                ),
              ),
              DecoratedBox(
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.white,
                    ),
                  ),
                ),
                child: InkWell(
                  highlightColor: AppColors.deepCover,
                  splashColor: AppColors.deepCover,
                  onTap: () => {
                    pageController.animateToPage(
                      3,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOutSine,
                    )
                  },
                  child: Visibility(
                    visible: !isLastPage.value,
                    child: Text(
                      context.l10n.skip,
                      style: context.textStyle.size15.withColor(
                        AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            //<---------------------Image--------------->
            Expanded(
              child: PageView(
                controller: imageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  Image(
                    image: AssetImage(
                      onBoardingImg1,
                    ),
                  ),
                  Image(
                    image: AssetImage(
                      onBoardingImg2,
                    ),
                  ),
                  Image(
                    image: AssetImage(
                      onBoardingImg3,
                    ),
                  ),
                ],
              ),
            ),

            //<-----------------------Page Content--------->
            Padding(
              padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
              child: Container(
                height: 450.toResponsiveHeight(context),
                decoration: BoxDecoration(
                  color: AppColors.rhino,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 15.toResponsiveHeight(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SmoothPageIndicator(
                        onDotClicked: (index) => pageController.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeOutSine,
                        ),
                        controller: pageController,
                        count: 3,
                        effect: const SlideEffect(
                          activeDotColor: AppColors.orchidPink,
                          dotHeight: 5,
                          dotWidth: 30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.toResponsiveHeight(context),
                    ),
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: const ScrollBehavior().copyWith(
                          overscroll: false,
                        ),
                        child: PageView(
                          controller: pageController,
                          onPageChanged: (index) {
                            isLastPage.value = index == 2;
                            imageController.animateToPage(
                              index,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOutSine,
                            );
                          },
                          children: [
                            PageContent(
                              heading: context.l10n.mindfulnessMeditation,
                              content: context.l10n.loremText,
                            ),
                            PageContent(
                              heading: context.l10n.mindfulness,
                              content: context.l10n.loremText,
                            ),
                            PageContent(
                              heading: context.l10n.meditation,
                              content: context.l10n.loremText,
                            ),
                          ],
                        ),
                      ),
                    ),

                    //<-----------------Button--------------------->
                    Padding(
                      padding: const EdgeInsets.all(
                        15,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        height: 50.toResponsiveHeight(context),
                        child: MyElevatedButton(
                          onPressed: () {
                            isLastPage.value
                                ? AutoRouter.of(context).replaceNamed('/signUp')
                                : pageController.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeOutSine,
                                  );
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Text(
                            isLastPage.value
                                ? context.l10n.start
                                : context.l10n.next,
                            style: context.textStyle.semiBold.size20.withColor(
                              AppColors.black,
                            ),
                          ),
                        ),
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
