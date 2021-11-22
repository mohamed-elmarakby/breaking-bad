import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'business_logic_layer/cubit/characters_cubit.dart';
import 'constants/strings.dart';
import 'data_layer/models/character_model.dart';
import 'data_layer/repositories/characters_repositroy.dart';
import 'data_layer/web_services/characters_webservices.dart';
import 'presentation_layer/screens/character_details_screen.dart';
import 'presentation_layer/screens/characters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository = CharactersRepository(CharactersWebServices());
    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case allCharactersRoute:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CharactersCubit>(
            create: (context) => charactersCubit,
            child: CharactersScreen(),
          ),
        );
      case characterDetailRoute:
        final character = settings.arguments as CharacterModel;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<CharactersCubit>.value(
            value: charactersCubit,
            child: CharacterDetailsScreen(character: character),
          ),
        );
    }
  }
}
