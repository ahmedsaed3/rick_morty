import '../models/characters.dart';
import '../web_services/characters_webservices.dart';

class RepoOfCharacters {
  final ApiCharacter  apiCharacter;
  RepoOfCharacters( this.apiCharacter);
  Future<List<Character>> getAllCharacters() async {
    final characters = await apiCharacter.GetCharacters();
    return  characters.map((character) => Character.fromJson(character))
        .toList();
  }
}