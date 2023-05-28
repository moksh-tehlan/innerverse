import 'package:dartz/dartz.dart';
import 'package:innerverse/data/model/error/generic_error.dart';
import 'package:innerverse/data/model/quotes_model.dart';
import 'package:innerverse/data/network/quotes_call.dart';

class QuotesRepository{

  QuotesRepository({required QuotesCall quotesCall}):_quotesCall = quotesCall;
  final QuotesCall _quotesCall;

  Future<Either<QuotesModel,GenericError>>getQuote(){
    return _quotesCall.getQuote();
  }
}