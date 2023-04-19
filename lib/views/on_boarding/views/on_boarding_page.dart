import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

@RoutePage()
class OnBoardingPage extends HookWidget {
  const OnBoardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final isLastPage = useState(false);
    final image = useState('assets/images/image1.png');

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
                'Innerverse',
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
                      'Skip',
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
            Expanded(
              child: Container(
                child: Image(
                  image: AssetImage(image.value),
                  // height: 200,
                  // width: 200,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15,bottom: 15,right: 15),
              child: Container(
                height: 450,
                decoration: BoxDecoration(
                  color: AppColors.rhino,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (index) {
                          isLastPage.value = index == 2;
                          switch (index) {
                            case 1:
                              image.value = 'assets/images/image2.png';
                              break;
                            case 2:
                              image.value = 'assets/images/image3.png';
                              break;
                            default:
                              image.value = 'assets/images/image1.png';
                              break;
                          }
                        },
                        children: [
                          Center(
                            child: Text(
                              'Page 1',
                              style: context.textStyle.withColor(
                                AppColors.white,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Page 2',
                              style: context.textStyle.withColor(
                                AppColors.white,
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Page 3',
                              style: context.textStyle.withColor(
                                AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(
                        15,
                      ),
                      child: InkWell(
                        onTap: () => {
                          pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOutSine,
                          )
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            color: AppColors.orchidPink,
                            borderRadius: BorderRadius.circular(
                              30,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              isLastPage.value ? 'Start' : 'Next',
                              style:
                                  context.textStyle.semiBold.size20.withColor(
                                AppColors.black,
                              ),
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
