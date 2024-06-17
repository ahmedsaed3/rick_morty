import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/characters.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final Character character;
  final Function(Character) onFavoritePressed;

  CharacterDetailsScreen(
      {Key? key, required this.character, required this.onFavoritePressed})
      : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _loadFavoriteStatus();
  }

  Future<void> _loadFavoriteStatus() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isFavorite = prefs.getBool('favorite_${widget.character.id}') ?? false;
    });
  }

  Future<void> _saveFavoriteStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('favorite_${widget.character.id}', value);
  }

  Widget buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: Colors.grey,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        background: Hero(
          tag: widget.character.id!,
          child: Image.network(
            widget.character.image!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget characterInfo(String title, var value) {
    return RichText(
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent) {
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: Colors.yellow,
      thickness: 2,
    );
  }

  Widget buildIconButton() {
    return IconButton(
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
        _saveFavoriteStatus(_isFavorite);
        widget.onFavoritePressed(
            widget.character);
      },
      iconSize: 50,
      icon: _isFavorite
          ? Icon(Icons.favorite, color: Colors.amber)
          : Icon(Icons.favorite_border, color: Colors.amber),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.character.name!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.amber),
                      ),
                      SizedBox(height: 20),
                      characterInfo('Species: ', widget.character.species!),
                      buildDivider(255),
                      characterInfo('Status: ', widget.character.status!),
                      buildDivider(265),
                      characterInfo('Gender: ', widget.character.gender!),
                      buildDivider(260),
                      characterInfo('Date: ', widget.character.created),
                      buildDivider(280),
                      widget.character.origin!.name!.isEmpty
                          ? Container()
                          : characterInfo(
                              'State: ', widget.character.origin!.name),
                      buildDivider(275),
                      widget.character.location!.name!.isEmpty
                          ? Container()
                          : characterInfo(
                              'Location: ', widget.character.location!.name),
                      buildDivider(250),
                      buildIconButton(),
                      Text('Add To Favorites',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.amber)),
                      SizedBox(height: 500),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
