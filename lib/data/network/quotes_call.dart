import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:innerverse/data/model/error/generic_error.dart';
import 'package:innerverse/data/model/quotes_model.dart';
import 'package:innerverse/data/network/collections.dart';
import 'package:innerverse/data/network/dio_client.dart';

class QuotesCall {
  QuotesCall({required DioClient dioClient}) : _dioClient = dioClient;
  final DioClient _dioClient;

  Future<Either<QuotesModel, GenericError>> getQuote() async {
    try{
      final response = await _dioClient.get(
        Collections.quoteUrl,
        queryParameters: {'category': 'life'},
        options: Options(
          headers: {
            'X-Api-Key': Collections.quoteApiKey,
          },
        ),
      );
      final quoteModel = quotesModelFromJson(response.data);
      return left(quoteModel);
    }catch(e){
      return right(GenericError(message: e.toString()));
    }
  }
}
