import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../business_logic_layer/cubit/characters_cubit.dart';
import '../../constants/my_colors.dart';
import '../../data_layer/models/character_model.dart';
import '../widgets/character_info.dart';

class CharacterDetailsScreen extends StatefulWidget {
  final CharacterModel character;
  const CharacterDetailsScreen({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  State<CharacterDetailsScreen> createState() => _CharacterDetailsScreenState();
}

class _CharacterDetailsScreenState extends State<CharacterDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<CharactersCubit>(context).loadQuote();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      return SafeArea(
        child: WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Scaffold(
            backgroundColor: MyColors.myGrey,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: MyColors.myGrey,
                  leading: BackButton(
                    color: MyColors.myWhite,
                    onPressed: () {
                      BlocProvider.of<CharactersCubit>(context).emit(
                          CharactersLoaded(
                              BlocProvider.of<CharactersCubit>(context)
                                  .characters));
                      Navigator.pop(context);
                    },
                  ),
                  expandedHeight:
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? MediaQuery.of(context).size.height * 0.7
                          : MediaQuery.of(context).size.height * 0.7,
                  pinned: true,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text(
                      widget.character.nickname!,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    background: Image.network(
                      widget.character.img!,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        // margin: EdgeInsets.fromLTRB(4, 4, 4, 0),
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: MyColors.myGrey,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            CharacterInfo(
                              description:
                                  widget.character.occupation!.join(", "),
                              title: 'Job: ',
                            ),
                            CharacterInfo(
                              description: widget.character.category!,
                              title: 'Appeared In: ',
                            ),
                            widget.character.appearance != null &&
                                    widget.character.appearance!.isNotEmpty
                                ? CharacterInfo(
                                    description:
                                        widget.character.appearance!.join(", "),
                                    title: 'Seasons: ',
                                  )
                                : Container(),
                            CharacterInfo(
                              description: widget.character.status.toString(),
                              title: 'Status: ',
                            ),
                            widget.character.betterCallSaulAppearance != null &&
                                    widget.character.betterCallSaulAppearance!
                                        .isNotEmpty
                                ? CharacterInfo(
                                    description: widget
                                        .character.betterCallSaulAppearance!
                                        .join(", "),
                                    title: 'Better Call Saull Seasons: ',
                                  )
                                : Container(),
                            CharacterInfo(
                              description: widget.character.portrayed!,
                              title: 'Actor/Actress: ',
                            )
                          ],
                        ),
                      ),
                      BlocBuilder<CharactersCubit, CharactersState>(
                        builder: (context, state) {
                          if (state is QuoteLoading) {
                            BlocProvider.of<CharactersCubit>(context)
                                .getRandomQuoteByAuthor(widget.character.name!);
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 28),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SpinKitWave(
                                      size: 24,
                                      color: MyColors.myYellow,
                                    ),
                                    Padding(
                                      padding: const EdgeInsetsDirectional.only(
                                          top: 14.0),
                                      child: Text(
                                        'Checking Quotes...',
                                        style:
                                            TextStyle(color: MyColors.myWhite),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (state is QuoteLoaded) {
                            if (BlocProvider.of<CharactersCubit>(context)
                                .quotes!
                                .isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Center(
                                  child: AnimatedTextKit(
                                    repeatForever: true,
                                    animatedTexts: [
                                      FlickerAnimatedText(
                                        '"${BlocProvider.of<CharactersCubit>(context).quotes![0].quote.toString().trim()}"',
                                        textAlign: TextAlign.center,
                                        textStyle: TextStyle(
                                          color: MyColors.myWhite,
                                          fontSize: 20,
                                          fontStyle: FontStyle.italic,
                                          shadows: [
                                            Shadow(
                                                blurRadius: 8,
                                                color: MyColors.myYellow,
                                                offset: Offset(0, 0))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            } else {
                              return Container();
                            }
                          } else if (state is ErrorQuote) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    FlickerAnimatedText(
                                      'Error Getting Quote Check Connection',
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                        color: MyColors.myWhite,
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 8,
                                              color: MyColors.myYellow,
                                              offset: Offset(0, 0))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else if (state is OfflineState) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Center(
                                child: AnimatedTextKit(
                                  repeatForever: true,
                                  animatedTexts: [
                                    FlickerAnimatedText(
                                      'No Internet connection to get Quote',
                                      textAlign: TextAlign.center,
                                      textStyle: TextStyle(
                                        color: MyColors.myWhite,
                                        fontSize: 20,
                                        fontStyle: FontStyle.italic,
                                        shadows: [
                                          Shadow(
                                              blurRadius: 8,
                                              color: MyColors.myYellow,
                                              offset: Offset(0, 0))
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
