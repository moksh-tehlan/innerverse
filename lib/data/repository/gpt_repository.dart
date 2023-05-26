import 'package:dartz/dartz.dart';
import 'package:innerverse/data/model/GPT/gpt_message_model.dart';
import 'package:innerverse/data/model/error/generic_error.dart';
import 'package:innerverse/data/model/GPT/gpt_model.dart';
import 'package:innerverse/data/network/gpt_call.dart';

class GptRepository {
  GptRepository({required GptCall gptCall}) : _gptCall = gptCall;
  final GptCall _gptCall;

  Future<Either<GptModel, GenericError>> getGptResponse(
      {required List<GptMessageModel> messageModel}) {
    return _gptCall.getResponse(gptMessageModel: messageModel);
  }
}
