import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/actions/adapt.dart';
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
          title: 'Adult Content',
          icon: Icons.visibility,
          iconBackgroundColor: const Color(0xFF5568E8),
          value: 'Off',
          trailing: CupertinoSwitch(
            value: false,
            onChanged: (d) {},
          ),
        ),
        SizedBox(height: 15),
        _SettingCell(
          title: 'Notification',
          icon: FontAwesomeIcons.bell,
          iconBackgroundColor: const Color(0xFF5568E8),
          value: 'On',
          trailing: CupertinoSwitch(value: true, onChanged: (d) {}),
        ),
        SizedBox(height: 15),
        _SettingCell(
          title: 'Dark Mode',
          icon: Icons.wb_sunny_outlined,
          iconBackgroundColor: const Color(0xFF28A74E),
          value: 'System',
        ),
        SizedBox(height: 15),
        _SettingCell(
          title: 'Language',
          icon: Icons.language,
          iconBackgroundColor: const Color(0xFF28A74E),
          value: 'Default',
        ),
      ]),
      SizedBox(height: 20),
      _SettingGroup(children: [
        _SettingCell(
          title: 'Feedback',
          icon: Icons.question_answer,
          iconBackgroundColor: const Color(0xFF3E3E3E),
          //value: 'on',
        ),
        SizedBox(height: 15),
        _SettingCell(
          title: 'Version',
          icon: Icons.refresh,
          iconBackgroundColor: const Color(0xFF3E3E3E),
          value: '1.0',
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
    return Row(children: [
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
          style:
              TextStyle(fontSize: Adapt.px(24), color: const Color(0xFF717171)),
        ),
      ),
      trailing ??
          Icon(
            Icons.keyboard_arrow_right,
            color: const Color(0xFF9E9E9E),
          ),
    ]);
  }
}
