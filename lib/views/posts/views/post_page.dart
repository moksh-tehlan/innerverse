import 'package:flutter/material.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const PostPageView();
  }
}

class PostPageView extends StatelessWidget {
  const PostPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      backgroundColor: AppColors.deepCover,
      appBar:  AppBar(
        backgroundColor: AppColors.deepCover,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Community',style: context.textStyle.size22.bold.withColor(AppColors.white)),
            Icon(Icons.edit_note_rounded,color: AppColors.orchidPink,size: 30,),
          ],
        ),
      ),
      body: const Placeholder(),
    ));
  }
}

