import 'package:flutter/material.dart';

import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import '../../data_layer/models/character_model.dart';

class CharacterGridBuilder extends StatelessWidget {
  final List<CharacterModel> characters;
  final int itemsCount;
  final double fontSize;
  final double childAspectRatio;
  const CharacterGridBuilder({
    Key? key,
    required this.characters,
    this.fontSize = 16,
    this.childAspectRatio = 5 / 6,
    this.itemsCount = 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: itemsCount,
          childAspectRatio: childAspectRatio,
          // crossAxisSpacing: 0,
          // mainAxisSpacing: 1,
        ),
        shrinkWrap: true,
        addAutomaticKeepAlives: false,
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: characters.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () async {
                Navigator.pushNamed(
                  context,
                  characterDetailRoute,
                  arguments: characters[index],
                );
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(9),
                  ),
                ),
                child: GridTile(
                  footer: Hero(
                    tag: characters[index].charId.toString(),
                    child: Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            characters[index].name.toString(),
                            style: TextStyle(
                              color: MyColors.myWhite,
                              fontSize: fontSize,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  child: FadeInImage.assetNetwork(
                    placeholder: 'assets/images/loading.gif',
                    image: characters[index].img.toString(),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
