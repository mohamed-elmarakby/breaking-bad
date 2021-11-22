import 'data_layer/models/character_model.dart';
import 'data_layer/web_services/characters_webservices.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

void setupGetIt() {
  serviceLocator
      .registerSingleton<CharactersWebServices>(CharactersWebServices());
}
