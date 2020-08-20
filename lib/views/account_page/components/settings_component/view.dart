import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/app_language.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/item.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SettingsState state, Dispatch dispatch, ViewService viewService) {
  return SliverList(
      delegate: SliverChildListDelegate(
    [
      _SettingGroup(children: [
        _SettingCell(
          title: I18n.of(viewService.context).adultContent,
          icon: state.adultContent
              ? Icons.visibility
              : Icons.visibility_off_outlined,
          iconBackgroundColor: const Color(0xFF5568E8),
          value: state.adultContent ? 'On' : 'Off',
          onTap: () => dispatch(SettingsActionCreator.adultContentTapped()),
          trailing: Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: state.adultContent,
              onChanged: (d) => dispatch(
                SettingsActionCreator.adultContentTapped(),
              ),
            ),
          ),
        ),
        SizedBox(height: 15),
        _SettingCell(
          title: I18n.of(viewService.context).notifications,
          icon: FontAwesomeIcons.bell,
          iconBackgroundColor: const Color(0xFF5568E8),
          onTap: () => dispatch(SettingsActionCreator.notificationsTap()),
          value: state.enableNotifications ? 'On' : 'Off',
          trailing: Transform.scale(
            scale: 0.8,
            child: CupertinoSwitch(
              value: state.enableNotifications,
              onChanged: (d) =>
                  dispatch(SettingsActionCreator.notificationsTap()),
            ),
          ),
        ),
        SizedBox(height: 15),
        _SettingCell(
          title: I18n.of(viewService.context).darkMode,
          icon: Icons.wb_sunny_outlined,
          iconBackgroundColor: const Color(0xFF28A74E),
          value: 'System',
          onTap: () => dispatch(SettingsActionCreator.darkModeTap()),
        ),
        SizedBox(height: 15),
        _SettingCell(
          title: I18n.of(viewService.context).language,
          icon: Icons.language,
          iconBackgroundColor: const Color(0xFF28A74E),
          value: state.appLanguage?.name ?? 'System default',
          onTap: () => showDialog(
            context: viewService.context,
            builder: (_) => _LanguageList(
              onTap: (d) => dispatch(SettingsActionCreator.languageTap(d)),
              selected: state.appLanguage,
            ),
          ),
        ),
      ]),
      SizedBox(height: 20),
      _SettingGroup(children: [
        _SettingCell(
          title: I18n.of(viewService.context).feedback,
          icon: Icons.question_answer,
          iconBackgroundColor: const Color(0xFF3E3E3E),
          onTap: () => dispatch(SettingsActionCreator.feedbackTap()),
        ),
        SizedBox(height: 15),
        _SettingCell(
          title: I18n.of(viewService.context).version,
          icon: Icons.refresh,
          iconBackgroundColor: const Color(0xFF3E3E3E),
          value: '${state.version}',
          onTap: () => dispatch(SettingsActionCreator.onCheckUpdate()),
        ),
      ]),
      SizedBox(height: 15),
    ],
  ));
}

class _SettingGroup extends StatelessWidget {
  final List<Widget> children;
  const _SettingGroup({this.children});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          border: Border.all(color: _theme.primaryColorDark),
          color: _theme.cardColor,
          borderRadius: BorderRadius.circular(15)),
      child: Column(children: children),
    );
  }
}

class _SettingCell extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconBackgroundColor;
  final String value;
  final Widget trailing;
  final Function onTap;
  const _SettingCell(
      {Key key,
      @required this.title,
      @required this.icon,
      this.iconBackgroundColor,
      this.value,
      this.trailing,
      this.onTap})
      : assert(title != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        enableFeedback: false,
        onTap: onTap,
        child: Row(children: [
          Container(
            width: Adapt.px(60),
            height: Adapt.px(60),
            decoration: BoxDecoration(
                color: iconBackgroundColor,
                borderRadius: BorderRadius.circular(Adapt.px(15))),
            child: Icon(
              icon,
              color: const Color(0xFFFFFFFF),
              size: 18,
            ),
          ),
          SizedBox(width: 15),
          Text(
            title,
            style: TextStyle(fontSize: Adapt.px(26)),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(right: 5),
            child: Text(
              value ?? '',
              style: TextStyle(
                  fontSize: Adapt.px(24), color: const Color(0xFF717171)),
            ),
          ),
          trailing ??
              Icon(
                Icons.keyboard_arrow_right,
                color: const Color(0xFF9E9E9E),
              ),
        ]));
  }
}

class _LangageListCell extends StatelessWidget {
  final Function onTap;
  final Item language;
  final bool selected;
  const _LangageListCell({this.onTap, this.language, this.selected = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(language);
        Navigator.of(context).pop();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: selected
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: const Color(0xFFFFFFFF)))
            : null,
        child: Text(
          language.name,
          style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 14),
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
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    final List<Item> data = AppLanguage.instance.supportLanguages;
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 0.0,
      backgroundColor: _backGroundColor,
      titleTextStyle: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 18),
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
              return _LangageListCell(
                onTap: (l) => onTap(l),
                selected: selected.name == _language.name,
                language: _language,
              );
            },
          ),
        ),
      ],
    );
  }
}
