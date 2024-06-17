import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty/presentation/screens/widgets/character_item.dart';
import '../../business_logic/characters_cubit.dart';
import '../../data/models/characters.dart';
import '../app_routing.dart';

class CharactersScreen extends StatefulWidget {
  @override
  State<CharactersScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  final _searchTextController = TextEditingController();
  late List<Character> searchedForCharacters;
  bool isSearching = false;

  Widget buildSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        hintText: 'Find a character...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
      ),
      style: TextStyle(color: Colors.grey, fontSize: 18),
      onChanged: (searchedCharacter) {
        searchForItems(searchedCharacter);
      },
    );
  }

  void searchForItems(searchedCharacter) {
    setState(() {
      searchedForCharacters = allCharacters
          .where((character) =>
              character.name!.toLowerCase().startsWith(searchedCharacter))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context).GetCharacters();
  }

  List<Widget> _buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            _stopSearching();
            Navigator.pop(context);
          },
          icon: Icon(Icons.clear, color: Colors.grey),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: _startSearch,
          icon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
        ),
      ];
    }
  }

  void _startSearch() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry()); //onRemove: _stopSearching

    setState(() {
      isSearching = true;
    });
  }

  void _stopSearching() {
    //_clearSearch();

    setState(() {
      _searchTextController.clear();

      isSearching = false;
    });
  }

  Widget _buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: Colors.grey),
    );
  }

  Widget buildBlockWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters;
        return buildLoadedListWidgets();
      } else {
        return Center(child: CircularProgressIndicator(color: Colors.yellow));
      }
    });
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: Colors.grey,
        child: Column(
          children: [
            GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 1,
                ),
                shrinkWrap: true,
                physics: const ClampingScrollPhysics(),
                itemCount: _searchTextController.text.isEmpty
                    ? allCharacters.length
                    : searchedForCharacters.length,
                itemBuilder: (context, index) {
                  return CharacterItem(
                    character: _searchTextController.text.isEmpty
                        ? allCharacters[index]
                        : searchedForCharacters[index],
                  );
                })
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.grey,
            onPressed: () {
              Navigator.pushNamed(context, favcharacters);
            },
            child: Icon(Icons.favorite_border, color: Colors.amber),
          ),
          SizedBox(height: 8),
          // Add this line
        ],
      ),
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        leading: isSearching
            ? BackButton(
                color: Colors.grey,
              )
            : Container(),
        title: isSearching ? buildSearchField() : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: Stack(children: [
        SingleChildScrollView(child: buildBlockWidget()),
      ]),
    );
  }
}
