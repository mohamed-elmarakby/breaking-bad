import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../data_layer/models/character_model.dart';
import '../../data_layer/models/quote_model.dart';
import '../../data_layer/repositories/characters_repositroy.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
  final CharactersRepository charactersRepository;
  List<CharacterModel> characters = [];
  List<QuoteModel>? quotes = [];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());

  List<CharacterModel> getAllCharacters() {
    charactersRepository.getAllCharacters().then((listOfCharacters) {
      emit(CharactersLoaded(listOfCharacters));
      characters = listOfCharacters;
    });
    return characters;
  }

  loadQuote() {
    emit(QuoteLoading());
  }

  getRandomQuoteByAuthor(String name) {
    charactersRepository.getRandomQuoteByAuthor(name).then((quotes) {
      emit(QuoteLoaded(quotes));
      this.quotes = quotes;
      print(this.quotes!.toString());
    }).onError((error, stackTrace) {
      emit(ErrorQuote());
    });
  }
}
