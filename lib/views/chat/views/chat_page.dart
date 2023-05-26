import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatPageView();
  }
}

class ChatPageView extends StatelessWidget {
  const ChatPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.deepCover,
      appBar: AppBar(
        backgroundColor: AppColors.deepCover,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 21,
              backgroundImage: AssetImage('assets/images/ai_girl.jpg'),
            ),
            const SizedBox(width: 15,),
            Text(
              'Ai Assistant',
              style:
                  context.textStyle.regular.size22.withColor(AppColors.white),
            ),
          ],
        ),
      ),
      body:const BubbleSpecialOne(text: 'Hi there',),
    );
  }
}
