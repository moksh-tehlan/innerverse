import 'package:flutter/material.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/app_ui.dart';
import 'package:innerverse/utils/assets_path.dart';
import 'package:url_launcher/url_launcher.dart';

class TopArticlesCard extends StatelessWidget {
  const TopArticlesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async{
        final url = Uri.parse('https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwjz55rRpZf_AhVJkmYCHdPzASAYABAAGgJzbQ&ohost=www.google.com&cid=CAESbOD20-vPpvK4k38Qg2FGhNT-D74Pos6cyNJgl5_ac5eVccRVckVx1-CaObNv_YZNUpfZk95NiGcTbTidEGKAnDw3DIWjgVHZKLmuayifGClMsg6Fb-ptH_mnUX6kZHrRtJFq2OYM8fyt2_T6Ug&sig=AOD64_25XbHIhvVYxOHxwoKPa4wq7OSuCA&q&adurl&ved=2ahUKEwjTjZTRpZf_AhV67DgGHUy1CoUQ0Qx6BAgGEAE'); // Replace with your desired URL

        if (await canLaunchUrl(url)) {
        await launchUrl(url,mode: LaunchMode.externalApplication);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.periwinkleGray,
              duration: const Duration(milliseconds: 800),
              content: Text(
                'Something went wrong',
                style: context.textStyle.size14.semiBold
                    .withColor(AppColors.black),
              ),
            ),
          );
        }
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: 210.toResponsiveHeight(context),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: const DecorationImage(
                image: AssetImage(topArticlePic),
                fit: BoxFit.cover,
              ),
            ),
            child: const SizedBox(),
          ),
          Container(
            width: double.infinity,
            height: 210.toResponsiveHeight(context),
            padding: EdgeInsets.all(15.toResponsiveWidth(context)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [
                  Color(0x98000000),
                  Color(0x79000000),
                  Color(0x64000000),
                  Color(0x49000000),
                  Color(0x29000000),
                  Color(0x09000000),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ArticleTag(),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 300.toResponsiveWidth(context),
                  child: Text(
                    'Why mental health matters',
                    style:
                        context.textStyle.bold.size20.withColor(AppColors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 300.toResponsiveWidth(context),
                  child: Text(
                    'One in two people who receive a diagnosis of leprosy or LF will also be affected by mental health problems. Mental health problems are especially high among people who develop',
                    style: context.textStyle.regular.size14
                        .withColor(AppColors.white),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Row(
                  children: [
                    Text(
                      'Read More',
                      style: context.textStyle.regular.size16
                          .withColor(AppColors.white),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                      color: AppColors.white,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ArticleTag extends StatelessWidget {
  const ArticleTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.toResponsiveHeight(context),
      width: 130.toResponsiveWidth(context),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          'Top Article',
          style: context.textStyle.semiBold.size16.withColor(AppColors.black),
        ),
      ),
    );
  }
}
