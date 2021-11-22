import '../../constants/my_colors.dart';
import 'package:flutter/material.dart';

class CharacterInfo extends StatefulWidget {
  final String title, description;
  CharacterInfo({
    Key? key,
    required this.description,
    required this.title,
  }) : super(key: key);

  @override
  State<CharacterInfo> createState() => _CharacterInfoState();
}

class _CharacterInfoState extends State<CharacterInfo> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _cardWidgetSize = _cardWidgetKey.currentContext!.size;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.title,
                  style: TextStyle(
                    color: MyColors.myYellow,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          title: Text(
            widget.description,
            style: TextStyle(
              color: MyColors.myWhite,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Divider(
            thickness: 1,
            color: MyColors.myYellow,
          ),
        ),
      ],
    );
  }
}
