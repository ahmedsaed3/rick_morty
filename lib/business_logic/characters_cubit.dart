import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../data/models/characters.dart';
import '../data/repository/repo_characters.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {

  final RepoOfCharacters repoOfCharacters;
  List<Character> MyCharacters=[];
  CharactersCubit(this.repoOfCharacters) : super(CharactersInitial());
  List<Character> GetCharacters (){
    repoOfCharacters.getAllCharacters().then((characters) {
      emit(CharactersLoaded(characters ));
      MyCharacters =characters ;
    });
    return MyCharacters!;



  }

}
