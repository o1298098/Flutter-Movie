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
    OverlayEntry menuOverlayEntry;
    void showPopupMenu(Widget menu) {
      menuOverlayEntry = OverlayEntry(
        builder: (context) {
          return Stack(
            children: <Widget>[
              Positioned.fill(
                  child: GestureDetector(
                onTap: () => menuOverlayEntry.remove(),
                child: Container(
                  color: Colors.transparent,
                ),
              )),
              menu,
            ],
          );
        },
      );
      Overlay.of(context).insert(menuOverlayEntry);
    }

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
          GestureDetector(
              onTap: () => showPopupMenu(_VideoSourceMenu()),
              child: Icon(
                Icons.tv,
                size: Adapt.px(30),
                color: const Color(0xFFFFFFFF),
              )),
          SizedBox(width: Adapt.px(70)),
          Icon(
            Icons.file_download,
            size: Adapt.px(30),
            color: const Color(0xFFFFFFFF),
          ),
          Spacer(),
          GestureDetector(
              onTap: () => showPopupMenu(_OptionMenu()),
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

class _OptionMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _backGroundColor = const Color(0xFF25272E);
    final double _width = 200;
    final double _arrowSize=20.0;
    final double _menuHeight=200.0;
    return Positioned(
      bottom: 80,
      right: Adapt.px(40),
      width: _width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
           Container(
              height: _menuHeight+_arrowSize,
              padding: EdgeInsets.only(right:Adapt.px(75)),
              alignment: Alignment.bottomRight,
              child: ClipPath(
                clipper: _ArrowClipper(),
                child: Container(
                  width: _arrowSize,
                  height: _arrowSize,
                  color: _backGroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                height: _menuHeight,
                decoration: BoxDecoration(
                  color: _backGroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ), 
          ],
        ),
      ),
    );
  }
}

class _VideoSourceMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _backGroundColor = const Color(0xFF25272E);
    final double _width = 160;
    final double _arrowSize=20.0;
    final double _menuHeight=200.0;
    return Positioned(
      bottom: 80,
      left: Adapt.px(275) - _width / 2,
      width: _width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              height: _menuHeight+_arrowSize,
              alignment: Alignment.bottomCenter,
              child: ClipPath(
                clipper: _ArrowClipper(),
                child: Container(
                  width: _arrowSize,
                  height: _arrowSize,
                  color: _backGroundColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: _backGroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width, 0);
    path.lineTo(size.width / 2, size.height / 2);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
