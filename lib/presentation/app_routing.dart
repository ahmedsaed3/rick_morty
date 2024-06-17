import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/presentation/screens/characters_details.dart';
import 'package:rick_morty/presentation/screens/characters_screen.dart';
import 'package:rick_morty/presentation/screens/favourite_characters.dart';
import '../business_logic/characters_cubit.dart';
import '../data/models/characters.dart';
import '../data/repository/repo_characters.dart';
import '../data/web_services/characters_webservices.dart';

const charactersScreen = '/';
const favcharacters = '/fav';
const characterDetailsScreen = '/character_details';

class AppRouting {
  late RepoOfCharacters repoOfCharacters;
  late CharactersCubit charactersCubit;

  AppRouting() {
    repoOfCharacters = RepoOfCharacters(ApiCharacter());

    charactersCubit = CharactersCubit(repoOfCharacters);
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case charactersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
              create: (BuildContext context) => charactersCubit,
              child: CharactersScreen()),
        );

      case characterDetailsScreen:
        final character = settings.arguments as Character;
        return MaterialPageRoute(
            builder: (_) => CharacterDetailsScreen(
                  character: character,
                  onFavoritePressed: (Character) {},
                ));
      case favcharacters:
        return MaterialPageRoute(builder: (_) => FavoriteCharacters());
    }
  }
}
