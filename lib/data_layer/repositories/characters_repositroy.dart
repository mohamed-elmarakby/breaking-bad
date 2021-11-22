import '../../business_logic_layer/cubit/characters_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/quote_model.dart';

import '../models/character_model.dart';
import '../web_services/characters_webservices.dart';
import '../../service_locator.dart';

class CharactersRepository {
  final CharactersWebServices charactersWebServices;

  CharactersRepository(this.charactersWebServices);
  Future<List<CharacterModel>> getAllCharacters() async {
    final characters =
        await serviceLocator<CharactersWebServices>().getAllCharacters();
    return characters.map((e) => CharacterModel.fromJson(e)).toList();
  }

  Future<List<QuoteModel>> getRandomQuoteByAuthor(String name) async {
    final quote = await serviceLocator<CharactersWebServices>()
        .getRandomQuoteByAuthor(name);
    return quote.map((quote) => QuoteModel.fromJson(quote)).toList();
  }
}
