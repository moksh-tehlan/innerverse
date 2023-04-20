import 'package:flutter/material.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/app_ui.dart';

class PageContent extends StatelessWidget {
  const PageContent({super.key,required this.heading, required this.content});
  final String heading;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: context.textStyle.semiBold.size25.withColor(
              AppColors.white,
            ),
          ),
          SizedBox(
            height: 15.toResponsiveHeight(context),
          ),
          Text(
            content,
            style: context.textStyle.size18.withColor(AppColors.white),
          ),
        ],
      ),
    );
  }
}
