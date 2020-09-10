import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/app_language.dart';
import 'package:movie/models/item.dart';
import 'package:movie/views/setting_page/action.dart';

class SettingBody extends StatelessWidget {
  final AnimationController pageAnimation;
  final AnimationController userEditAnimation;
  final FirebaseUser user;
  final bool adultSwitchValue;
  final double cachedSize;
  final bool loading;
  final String version;
  final Item appLanguage;
  final Dispatch dispatch;
  const SettingBody(
      {this.adultSwitchValue,
      this.cachedSize,
      this.dispatch,
      this.loading,
      this.pageAnimation,
      this.user,
      this.userEditAnimation,
      this.version,
      this.appLanguage});
  @override
  Widget build(BuildContext context) {
    final double _margin = Adapt.px(120) + Adapt.padTopH();
    final Animation _run = Tween(begin: .00, end: 1.0).animate(
        CurvedAnimation(parent: userEditAnimation, curve: Curves.ease));
    return AnimatedBuilder(
      animation: userEditAnimation,
      builder: (_, __) {
        return Padding(
          padding: EdgeInsets.only(
              top: _margin, left: Adapt.px(60), right: Adapt.px(60)),
          child: Container(
            transform: Matrix4.identity()..scale(1.0 - _run.value, 1.0, 1.0),
            height: Adapt.screenH() - _margin,
            child: ListView(
              physics: ClampingScrollPhysics(),
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: <Widget>[
                _UserCell(
                  pageAnimation: pageAnimation,
                  userEditAnimation: userEditAnimation,
                  user: user,
                ),
                _AdultCell(
                  pageAnimation: pageAnimation,
                  adultSwitchValue: adultSwitchValue,
                  onTap: () =>
                      dispatch(SettingPageActionCreator.adultCellTapped()),
                ),
                _LanguageCell(
                  pageAnimation: pageAnimation,
                  language: appLanguage,
                  onTap: (language) =>
                      dispatch(SettingPageActionCreator.languageTap(language)),
                ),
                _VersionCell(
                  pageAnimation: pageAnimation,
                  version: version,
                  loading: loading,
                  onTap: () =>
                      dispatch(SettingPageActionCreator.onCheckUpdate()),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

class _UserCell extends StatelessWidget {
  final AnimationController pageAnimation;
  final AnimationController userEditAnimation;
  final FirebaseUser user;
  const _UserCell({this.pageAnimation, this.user, this.userEditAnimation});
  @override
  Widget build(BuildContext context) {
    return _ListCell(
      pageAnimation: pageAnimation,
      begin: .1,
      end: .7,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(30), vertical: Adapt.px(60)),
        child: ListTile(
          leading: Container(
            width: Adapt.px(80),
            height: Adapt.px(80),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF303030),
              image: user?.photoUrl != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(user?.photoUrl),
                    )
                  : null,
            ),
          ),
          title: Text(
            user?.displayName ?? 'Guest',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(35)),
          ),
          subtitle: Text(
            user?.email ?? '-',
            maxLines: 1,
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(24)),
          ),
          trailing: IconButton(
            onPressed: () {
              if (user != null) userEditAnimation.forward();
            },
            icon: Icon(Icons.edit),
            color: Colors.white,
            iconSize: Adapt.px(60),
          ),
        ),
      ),
    );
  }
}

class _AdultCell extends StatelessWidget {
  final Function onTap;
  final AnimationController pageAnimation;
  final bool adultSwitchValue;
  const _AdultCell({this.onTap, this.adultSwitchValue, this.pageAnimation});
  @override
  Widget build(BuildContext context) {
    return _ListCell(
      pageAnimation: pageAnimation,
      begin: .2,
      end: .8,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(30), vertical: Adapt.px(60)),
        child: ListTile(
          onTap: onTap,
          leading: Icon(
            adultSwitchValue ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
            size: Adapt.px(80),
          ),
          title: Text(
            'Adult Items',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(35)),
          ),
          subtitle: Text(
            adultSwitchValue ? 'on' : 'off',
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(35)),
          ),
          trailing: CupertinoSwitch(
            onChanged: (b) => onTap(),
            activeColor: Color(0xFF111111),
            trackColor: Color(0xFFD0D0D0),
            value: adultSwitchValue,
          ),
        ),
      ),
    );
  }
}

class _VersionCell extends StatelessWidget {
  final Function onTap;
  final AnimationController pageAnimation;
  final bool loading;
  final String version;
  const _VersionCell(
      {this.onTap, this.pageAnimation, this.loading, this.version});
  @override
  Widget build(BuildContext context) {
    return _ListCell(
      pageAnimation: pageAnimation,
      begin: .4,
      end: 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(30), vertical: Adapt.px(60)),
        child: ListTile(
          leading: Icon(
            Icons.system_update,
            color: Colors.white,
            size: Adapt.px(80),
          ),
          title: Text(
            'Version',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(35)),
          ),
          subtitle: Text(
            version ?? '-',
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(35)),
          ),
          trailing: IconButton(
            onPressed: onTap,
            icon: loading
                ? SizedBox(
                    width: Adapt.px(40),
                    height: Adapt.px(40),
                    child: CircularProgressIndicator(
                      strokeWidth: Adapt.px(5),
                      valueColor:
                          AlwaysStoppedAnimation(const Color(0xFFFFFFFF)),
                    ))
                : Icon(Icons.refresh),
            color: Colors.white,
            iconSize: Adapt.px(60),
          ),
        ),
      ),
    );
  }
}

class _LanguageCell extends StatelessWidget {
  final Function(Item) onTap;
  final AnimationController pageAnimation;
  final Item language;
  const _LanguageCell({this.onTap, this.pageAnimation, this.language});
  @override
  Widget build(BuildContext context) {
    return _ListCell(
      pageAnimation: pageAnimation,
      begin: .3,
      end: .9,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(30), vertical: Adapt.px(60)),
        child: ListTile(
          onTap: () => showDialog(
            context: context,
            builder: (_) => _LanguageList(
              onTap: onTap,
              selected: language,
            ),
          ),
          leading: Icon(
            Icons.language,
            color: Colors.white,
            size: Adapt.px(80),
          ),
          title: Text(
            'Language',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(35)),
          ),
          subtitle: Text(
            language?.name ?? 'System default',
            style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(35)),
          ),
          trailing: Icon(
            Icons.translate,
            color: Colors.white,
            size: Adapt.px(60),
          ),
        ),
      ),
    );
  }
}

class _ListCell extends StatelessWidget {
  final AnimationController pageAnimation;
  final double begin;
  final double end;
  final Widget child;
  const _ListCell(
      {this.pageAnimation, this.begin, this.end, @required this.child});
  @override
  Widget build(BuildContext context) {
    final CurvedAnimation _animation = CurvedAnimation(
        parent: pageAnimation, curve: Interval(begin, end, curve: Curves.ease));
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(_animation),
      child: SlideTransition(
        position:
            Tween(begin: Offset(0, 2), end: Offset.zero).animate(_animation),
        child: Container(
          height: Adapt.px(250),
          margin: EdgeInsets.only(bottom: Adapt.px(40)),
          decoration: BoxDecoration(
            color: const Color(0xFF202020),
            borderRadius: BorderRadius.circular(Adapt.px(20)),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _LanguageList extends StatelessWidget {
  final Function(Item) onTap;
  final Item selected;
  const _LanguageList({this.onTap, this.selected});
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final List<Item> data = AppLanguage.instance.supportLanguages;
    return SimpleDialog(
      elevation: 0.0,
      backgroundColor: const Color(0xFF252525),
      titleTextStyle: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 20),
      title: Text(
        'Support Language',
      ),
      children: [
        Container(
          height: _size.height / 2,
          width: _size.width,
          child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
              separatorBuilder: (_, __) => SizedBox(height: 10),
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (_, index) {
                final _language = data[index];
                return GestureDetector(
                  onTap: () {
                    onTap(_language);
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: selected.name == _language.name
                        ? BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: const Color(0xFFFFFFFF)))
                        : null,
                    child: Text(
                      _language.name,
                      style: TextStyle(
                          color: const Color(0xFFFFFFFF), fontSize: 18),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
