import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:innerverse/data/repository/quotes_repository.dart';

part 'home_state.dart';
part 'home_event.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required QuotesRepository quotesRepository})
      : _quotesRepository = quotesRepository,
        super(
          const HomeState.initial(quote: 'I choose happiness and growth'),
        ) {
    on<_GetQuote>(onGetQuote);
  }
  final QuotesRepository _quotesRepository;
  List<String> inspirationalQuotes = [
    "Believe you can, and you're halfway there.",
    "Dream big and dare to fail.",
    "The future belongs to those who believe in the beauty of their dreams.",
    "The only way to do great work is to love what you do.",
    "In the middle of difficulty lies opportunity.",
    "The best way to predict the future is to create it.",
    "Your time is limited, don't waste it living someone else's life.",
    "Stay hungry, stay foolish.",
    "Do what you love, love what you do.",
    "Believe in yourself and all that you are.",
    "Hardships often prepare ordinary people for an extraordinary destiny.",
    "Success is not the key to happiness. Happiness is the key to success.",
    "The only person you are destined to become is the person you decide to be.",
    "The harder you work for something, the greater you'll feel when you achieve it.",
    "Don't watch the clock; do what it does. Keep going.",
    "Life is 10% what happens to us and 90% how we react to it.",
    "You are never too old to set another goal or to dream a new dream.",
    "The only limit to our realization of tomorrow will be our doubts of today.",
  ];

  Future<void> onGetQuote(_GetQuote event, Emitter<HomeState> emit) async {
    final response = await _quotesRepository.getQuote();
    response.fold(
      (quoteModel) {
        print(quoteModel.quote?.length);
        if ((quoteModel.quote?.length?? 100) > 80) {
          emit(
            _LoadQuote(
              quote: inspirationalQuotes[
                  Random().nextInt(inspirationalQuotes.length)],
            ),
          );
        } else {
          emit(_LoadQuote(
              quote: quoteModel.quote ??
                  'The best way to predict the future is to create it.'));
        }
      },
      (error) => _Error(error: error.message),
    );
  }
}
