import 'package:flutter_offline/flutter_offline.dart';

import '../widgets/character_grid_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../business_logic_layer/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data_layer/models/character_model.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    // BlocProvider.of<CharactersCubit>(context).emit(CharactersLoading(context));
    super.initState();
  }

  bool _searching = false;
  bool _offline = false;
  TextEditingController _textEditingController = TextEditingController();
  List<CharacterModel> SearchedForList = [];
  Widget _buildSearchAppBar() {
    return TextField(
      controller: _textEditingController,
      decoration: InputDecoration(
        hintText: 'Search CharacterModel...',
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
        border: InputBorder.none,
      ),
      style: TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (value) {
        setState(() {
          SearchedForList = BlocProvider.of<CharactersCubit>(context)
              .characters
              .where((element) => element.name!.contains(value))
              .map((character) => CharacterModel().copyWith(
                  character.charId,
                  character.name,
                  character.birthday,
                  character.occupation,
                  character.img,
                  character.status,
                  character.nickname,
                  character.appearance,
                  character.portrayed,
                  character.category,
                  character.betterCallSaulAppearance))
              .toList();
        });
      },
    );
  }

  void _startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
    setState(() {
      _searching = true;
    });
  }

  void _stopSearching() {
    setState(() {
      _textEditingController.clear();
      _searching = false;
      SearchedForList.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OfflineBuilder(
        connectivityBuilder: (BuildContext context,
            ConnectivityResult connectivity, Widget child) {
          final bool connected = connectivity != ConnectivityResult.none;
          return Scaffold(
            backgroundColor: MyColors.myGrey,
            appBar: !connected
                ? null
                : AppBar(
                    backgroundColor: MyColors.myYellow,
                    title: _searching
                        ? _buildSearchAppBar()
                        : const Text(
                            'Characters',
                            style: TextStyle(
                              color: MyColors.myGrey,
                            ),
                          ),
                    actions: [
                      _searching
                          ? IconButton(
                              icon: Icon(Icons.clear),
                              color: MyColors.myGrey,
                              onPressed: _stopSearching,
                            )
                          : IconButton(
                              icon: Icon(Icons.search),
                              color: MyColors.myGrey,
                              onPressed: _startSearching,
                            ),
                    ],
                    leading: _searching
                        ? BackButton(
                            color: MyColors.myGrey,
                            onPressed: _stopSearching,
                          )
                        : Container(),
                  ),
            body: OfflineBuilder(
              connectivityBuilder: (BuildContext context,
                  ConnectivityResult connectivity, Widget child) {
                final bool connected = connectivity != ConnectivityResult.none;

                if (!connected) {
                  BlocProvider.of<CharactersCubit>(context)
                      .emit(OfflineState());
                  return LayoutBuilder(builder:
                      (BuildContext context, BoxConstraints constraints) {
                    if (constraints.maxWidth < 500) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/images/no-connection-transparenat.png',
                              fit: BoxFit.cover,
                            ),
                            Text(
                              'Can\'t connect .. check internet',
                              style: TextStyle(
                                fontSize: 22,
                                color: MyColors.myYellow,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      BlocProvider.of<CharactersCubit>(context)
                          .emit(OnlineState(context));
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              flex: 7,
                              child: Image.asset(
                                'assets/images/no-connection-transparenat.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Can\'t connect .. check internet',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: MyColors.myYellow,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  });
                } else {
                  return BlocBuilder<CharactersCubit, CharactersState>(
                    builder: (context, state) {
                      if (state is CharactersLoaded) {
                        return LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          if (constraints.maxWidth < 500) {
                            return CharacterGridBuilder(
                              childAspectRatio: 5 / 6,
                              characters: _searching
                                  ? SearchedForList.isNotEmpty
                                      ? SearchedForList
                                      : (state).characters
                                  : (state).characters,
                              fontSize: 16,
                              itemsCount: 2,
                            );
                          } else if (constraints.maxWidth > 500 &&
                              constraints.maxWidth < 1000) {
                            return CharacterGridBuilder(
                              childAspectRatio: 3 / 4,
                              characters: _searching
                                  ? SearchedForList.isNotEmpty
                                      ? SearchedForList
                                      : (state).characters
                                  : (state).characters,
                              fontSize: 18,
                              itemsCount: 3,
                            );
                          } else {
                            return CharacterGridBuilder(
                              childAspectRatio: 2 / 3,
                              characters: _searching
                                  ? SearchedForList.isNotEmpty
                                      ? SearchedForList
                                      : (state).characters
                                  : (state).characters,
                              fontSize: 24,
                              itemsCount: 5,
                            );
                          }
                        });
                      } else if (state is CharactersLoading) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpinKitFadingCube(
                                color: MyColors.myYellow,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 26.0),
                                child: Text(
                                  'Getting Data...',
                                  style: TextStyle(color: MyColors.myWhite),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is CharactersInitial) {
                        BlocProvider.of<CharactersCubit>(context)
                            .emit(CharactersLoading(context));
                        print(state);
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpinKitFadingCube(
                                color: MyColors.myYellow,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 26.0),
                                child: Text(
                                  'Getting Data...',
                                  style: TextStyle(color: MyColors.myWhite),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else if (state is OfflineState) {
                        BlocProvider.of<CharactersCubit>(context)
                            .emit(CharactersLoading(context));
                        print(state);
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpinKitFadingCube(
                                color: MyColors.myYellow,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 26.0),
                                child: Text(
                                  'Getting Data...',
                                  style: TextStyle(color: MyColors.myWhite),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SpinKitFadingCube(
                                color: MyColors.myYellow,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsetsDirectional.only(top: 26.0),
                                child: Text(
                                  'Getting Data...',
                                  style: TextStyle(color: MyColors.myWhite),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  );
                }
              },
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
        child: Container(),
      ),
    );
  }
}
