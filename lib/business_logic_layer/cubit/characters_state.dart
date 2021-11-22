part of 'characters_cubit.dart';

@immutable
abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {
  CharactersLoading(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }
}

class OnlineState extends CharactersState {
  OnlineState(BuildContext context) {
    BlocProvider.of<CharactersCubit>(context).emit(CharactersLoading(context));
  }
}

class OfflineState extends CharactersState {}

class ErrorQuote extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharacterModel> characters;

  CharactersLoaded(this.characters);
}

class QuoteLoading extends CharactersState {}

class QuoteLoaded extends CharactersState {
  final List<QuoteModel> quotes;

  QuoteLoaded(this.quotes);
}
