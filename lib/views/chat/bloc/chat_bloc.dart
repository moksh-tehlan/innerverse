import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innerverse/data/model/GPT/gpt_message_model.dart';
import 'package:innerverse/data/repository/gpt_repository.dart';
import 'package:innerverse/di/dependency_injection.dart';
import 'package:innerverse/utils/shared_pref.dart';

part 'chat_state.dart';
part 'chat_event.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc({required GptRepository gptRepository})
      : _gptRepository = gptRepository,
        super(const ChatState.initial()) {
    on<_SendMessage>(onSendMessage);
  }

  final GptRepository _gptRepository;

  Future<void> onSendMessage(
    _SendMessage event,
    Emitter<ChatState> emit,
  ) async {
    gptMessageModelList.add(
      GptMessageModel(role: 'user', content: event.message),
    );
    emit(const _MessageSent());

    emit(const _Loading());

    final response = await _gptRepository.getGptResponse(
      messageModelList: gptMessageModelList,
    );

    response.fold(
      (gptModel) {
        final response = gptModel.choices?[0].message?.content.toString() ?? '';
        gptMessageModelList.add(
            GptMessageModel(role: 'assistant', content: response),
          );
        emit(
          const _Response(),
        );
      },
      (error) => emit(_Error(error: error.message)),
    );
  }
}
