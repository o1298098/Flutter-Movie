import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

class BottomPanel extends StatelessWidget {
  final int commentCount;
  final int likeCount;
  final bool userLiked;
  final Function likeTap;
  final Function commentTap;
  const BottomPanel(
      {this.commentCount = 0,
      this.likeCount = 0,
      this.userLiked = false,
      this.likeTap,
      this.commentTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
        decoration: BoxDecoration(
          color: _theme.brightness == Brightness.light
              ? const Color(0xFF25272E)
              : _theme.primaryColorDark,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Adapt.px(60)),
          ),
        ),
        child: Row(children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: _ItemButton(
              key: ValueKey('LikeIcons$userLiked'),
              onTap: likeTap,
              icon: userLiked ? Icons.favorite : Icons.favorite_border,
              iconColor:
                  userLiked ? const Color(0xFFAA222E) : const Color(0xFFFFFFFF),
              value: _convertString(likeCount),
            ),
          ),
          _ItemButton(
            icon: Icons.comment,
            onTap: commentTap,
            value: _convertString(commentCount),
          ),
          Icon(
            Icons.tv,
            size: Adapt.px(30),
            color: const Color(0xFFFFFFFF),
          ),
          SizedBox(width: Adapt.px(70)),
          Icon(
            Icons.file_download,
            size: Adapt.px(30),
            color: const Color(0xFFFFFFFF),
          ),
          Spacer(),
          GestureDetector(
              onTap: () => Navigator.of(context).pushNamed('testPage'),
              child: Icon(
                Icons.more_vert,
                color: const Color(0xFFFFFFFF),
              )),
          SizedBox(width: Adapt.px(10)),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: Adapt.px(60),
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ]),
      ),
    );
  }
}

class _ItemButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final Color iconColor;
  final String value;
  const _ItemButton(
      {Key key,
      this.icon,
      this.iconColor = const Color(0xFFFFFFFF),
      this.onTap,
      this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: Adapt.px(110),
        child: Row(
          children: [
            Icon(
              icon,
              key: key,
              size: Adapt.px(30),
              color: iconColor,
            ),
            SizedBox(width: Adapt.px(10)),
            SizedBox(
              width: Adapt.px(70),
              child: Text(
                value,
                maxLines: 1,
                style: TextStyle(
                    color: const Color(0xFFFFFFFF), fontSize: Adapt.px(24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _convertString(int value) {
  String _result = '$value';
  if (value >= 1000 && value < 1000000)
    _result = '${(value / 1000).toStringAsFixed(0)}k';
  else if (value >= 1000000)
    _result = '${(value / 1000000).toStringAsFixed(0)}m';
  return _result;
}
