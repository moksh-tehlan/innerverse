import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:innerverse/data/model/GPT/gpt_message_model.dart';
import 'package:innerverse/data/repository/gpt_repository.dart';
import 'package:innerverse/di/dependency_injection.dart';
import 'package:innerverse/typography/text_style.dart';
import 'package:innerverse/utils/app_colors.dart';
import 'package:innerverse/utils/app_ui.dart';
import 'package:innerverse/views/chat/bloc/chat_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatBloc(gptRepository: getIt<GptRepository>()),
      child: const ChatPageView(),
    );
  }
}

class ChatPageView extends HookWidget {
  const ChatPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final messageController = useTextEditingController();
    final loadingNotifier = useValueNotifier(false);

    return BlocListener<ChatBloc, ChatState>(
      listener: (context, state) {
        state.maybeWhen(
          error: (error){
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: AppColors.periwinkleGray,
                duration: const Duration(milliseconds: 1000),
                content: Text(
                  error,
                  style: context.textStyle.size14.semiBold
                      .withColor(AppColors.black),
                ),
              ),
            );
          },
          orElse: () {
            loadingNotifier.value = false;
          },
          loading: () {
            loadingNotifier.value = true;
          },
        );
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.deepCover,
          appBar: AppBar(
            backgroundColor: AppColors.deepCover,
            title: Row(
              children: [
                const CircleAvatar(
                  radius: 21,
                  backgroundImage: AssetImage('assets/images/ai_girl.jpg'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  'Ai Assistant',
                  style: context.textStyle.regular.size22
                      .withColor(AppColors.white),
                ),
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BlocBuilder<ChatBloc, ChatState>(
                    builder: (context, state) {
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: state.maybeWhen(
                            orElse: () => gptMessageModelList.length,
                            ),
                        itemBuilder: (context, index) {
                          final gptMessageModel = state.maybeWhen(
                            orElse: () => gptMessageModelList[
                                gptMessageModelList.length - index - 1],
                          );
                          if (gptMessageModel.role == 'user') {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: BubbleSpecialOne(
                                text: gptMessageModel.content.toString(),
                                textStyle: context.textStyle.regular.size16
                                    .withColor(AppColors.white),
                                color: AppColors.orchidPink,
                              ),
                            );
                          } else if (gptMessageModel.role == 'assistant') {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: BubbleSpecialOne(
                                text: gptMessageModel.content.toString(),
                                textStyle: context.textStyle.regular.size16
                                    .withColor(AppColors.white),
                                color: AppColors.blueMarguerite,
                                isSender: false,
                              ),
                            );
                          }else {
                            return const SizedBox();
                          }
                        },
                      );
                    },
                  ),
                ),
                HookBuilder(
                  builder: (context){
                    final loadingListener = useValueListenable(loadingNotifier);
                    return Visibility(
                    visible: loadingListener,
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: LoadingAnimationWidget.waveDots(
                              color: AppColors.white,
                              size: 50,
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  );
                  },
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20.toResponsiveWidth(context),
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: AppColors.rhino,
                        ),
                        child: TextField(
                          controller: messageController,
                          minLines: 1,
                          maxLines: 6,
                          onChanged: (value) {},
                          style: context.textStyle.size18.withColor(
                            AppColors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: 'Send a Message',
                            hintStyle: context.textStyle.size18.withColor(
                              AppColors.paleWhite,
                            ),
                            border: InputBorder.none,
                          ),
                          cursorColor: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    InkWell(
                      onTap: () {
                        if(messageController.text.isNotEmpty){
                          context.read<ChatBloc>().add(
                            ChatEvent.sendMessage(
                              message: messageController.text,
                            ),
                          );
                          messageController.text = '';
                        }
                      },
                      child: const Icon(
                        Icons.send,
                        color: AppColors.white,
                        size: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
