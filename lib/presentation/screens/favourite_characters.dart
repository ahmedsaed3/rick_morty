import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../data/models/characters.dart';

class FavoriteCharacters extends StatefulWidget {
  @override
  _FavoriteCharactersListState createState() => _FavoriteCharactersListState();
}

class _FavoriteCharactersListState extends State<FavoriteCharacters> {
  List<Character> _favoriteCharacters = [];

  void _handleFavoritePressed(Character character) {
    setState(() {
      if (_favoriteCharacters.contains(character)) {
        _favoriteCharacters.remove(character);
      } else {
        _favoriteCharacters.add(character);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Characters'),
      ),
      body: ListView.builder(
        itemCount: _favoriteCharacters.length,
        itemBuilder: (context, index) {
          final character = _favoriteCharacters[index];
          return ListTile(
            title: Text(character.name!),
          );
        },
      ),
    );
  }
}
