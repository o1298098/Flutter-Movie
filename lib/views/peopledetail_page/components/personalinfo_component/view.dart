import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';

import 'state.dart';

Widget buildView(
    PersonalInfoState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildInfoBody() {
    var _titleStyle =
        TextStyle(color: Colors.grey[600], fontSize: Adapt.px(26));
    var _valueStyle =
        TextStyle(fontSize: Adapt.px(30), fontWeight: FontWeight.w500);
    var _data = state.peopleDetailModel;
    String birthday;
    if (_data?.birthday != null)
      birthday = DateFormat.yMMMMd().format(DateTime.parse(_data.birthday));
    return Card(
      //margin: EdgeInsets.all(Adapt.px(10)),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(30))),
      child: Container(
        padding: EdgeInsets.all(Adapt.px(20)),
        width: Adapt.screenW() - Adapt.px(60),
        //height: Adapt.px(400),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              I18n.of(viewService.context).gender,
              style: _titleStyle,
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Text(
              _data?.gender == 2 ? 'Male' : 'Female',
              style: _valueStyle,
            ),
            Divider(
              height: Adapt.px(40),
            ),
            Text(
              I18n.of(viewService.context).knownFor,
              style: _titleStyle,
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Text(
              _data?.knownForDepartment ?? '',
              style: _valueStyle,
            ),
            Divider(
              height: Adapt.px(40),
            ),
            Text(
              'Birth',
              style: _titleStyle,
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Text(
              '${birthday ?? ''} in ${_data?.placeOfBirth ?? ''}',
              style: _valueStyle,
            ),
            Divider(
              height: Adapt.px(40),
            ),
            Text(
              I18n.of(viewService.context).knownCredits,
              style: _titleStyle,
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Text(
              '${state.creditcount ?? 0}',
              style: _valueStyle,
            ),
            Divider(
              height: Adapt.px(40),
            ),
            Text(
              I18n.of(viewService.context).officialSite,
              style: _titleStyle,
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Text(
              '${_data?.homepage ?? '-'}',
              style: _valueStyle,
            ),
            Divider(
              height: Adapt.px(40),
            ),
            Text(
              I18n.of(viewService.context).alsoKnownAs,
              style: _titleStyle,
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Text(
              _data?.alsoKnownAs?.join(' , ') ?? '-',
              style: _valueStyle,
            ),
          ],
        ),
      ),
    );
  }

  return Container(
    padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          I18n.of(viewService.context).personalInfo,
          softWrap: true,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: Adapt.px(40)),
        ),
        SizedBox(
          height: Adapt.px(50),
        ),
        _buildInfoBody(),
        SizedBox(
          height: Adapt.px(50),
        ),
      ],
    ),
  );
}
