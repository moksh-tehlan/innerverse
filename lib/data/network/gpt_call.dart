import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:innerverse/data/model/GPT/gpt_message_model.dart';
import 'package:innerverse/data/model/error/generic_error.dart';
import 'package:innerverse/data/model/GPT/gpt_model.dart';
import 'package:innerverse/data/network/collections.dart';
import 'package:innerverse/data/network/dio_client.dart';

class GptCall {
  GptCall({required DioClient dioClient}) : _dioClient = dioClient;
  final DioClient _dioClient;

  Future<Either<GptModel, GenericError>> getResponse({
    required List<GptMessageModel> gptMessageModel,
  }) async {
    try {
      final response = await _dioClient.post(
        Collections.gptUrl,
        data: {
          'model': 'gpt-3.5-turbo',
          'messages': gptMessageModel
        },
      );
      return left(gptModelFromJson(response.data.toString()));
    } catch (e) {
      return right(GenericError(message: e.toString()));
    }
  }
}