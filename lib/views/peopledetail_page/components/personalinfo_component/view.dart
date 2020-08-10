import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/people_detail.dart';

import 'state.dart';

Widget buildView(
    PersonalInfoState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            I18n.of(viewService.context).personalInfo,
            softWrap: true,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
          ),
          SizedBox(height: Adapt.px(50)),
          _InfoBody(
            data: state.peopleDetailModel,
            creditcount: state.creditcount,
          ),
          SizedBox(height: Adapt.px(50)),
        ],
      ),
    ),
  );
}

class _InfoBody extends StatelessWidget {
  final PeopleDetailModel data;
  final int creditcount;
  const _InfoBody({this.data, this.creditcount});
  @override
  Widget build(BuildContext context) {
    final _titleStyle = TextStyle(color: Colors.grey[600], fontSize: 14);
    final _valueStyle = TextStyle(fontSize: 16, fontWeight: FontWeight.w500);
    String birthday;
    if (data?.birthday != null)
      birthday = DateFormat.yMMMMd().format(DateTime.parse(data.birthday));
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(30))),
      child: Container(
        padding: EdgeInsets.all(Adapt.px(30)),
        width: Adapt.screenW() - Adapt.px(60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              I18n.of(context).gender,
              style: _titleStyle,
            ),
            SizedBox(height: Adapt.px(8)),
            Text(
              data?.gender == 2 ? 'Male' : 'Female',
              style: _valueStyle,
            ),
            Divider(height: Adapt.px(40)),
            Text(
              I18n.of(context).knownFor,
              style: _titleStyle,
            ),
            SizedBox(height: Adapt.px(8)),
            Text(
              data?.knownForDepartment ?? '',
              style: _valueStyle,
            ),
            Divider(height: Adapt.px(40)),
            Text(
              'Birth',
              style: _titleStyle,
            ),
            SizedBox(height: Adapt.px(8)),
            Text(
              '${birthday ?? ''} in ${data?.placeOfBirth ?? ''}',
              style: _valueStyle,
            ),
            Divider(height: Adapt.px(40)),
            Text(
              I18n.of(context).knownCredits,
              style: _titleStyle,
            ),
            SizedBox(height: Adapt.px(8)),
            Text(
              '${creditcount ?? 0}',
              style: _valueStyle,
            ),
            Divider(height: Adapt.px(40)),
            Text(
              I18n.of(context).officialSite,
              style: _titleStyle,
            ),
            SizedBox(height: Adapt.px(8)),
            Text(
              '${data?.homepage ?? '-'}',
              style: _valueStyle,
            ),
            Divider(height: Adapt.px(40)),
            Text(
              I18n.of(context).alsoKnownAs,
              style: _titleStyle,
            ),
            SizedBox(height: Adapt.px(8)),
            Text(
              data?.alsoKnownAs?.join(' , ') ?? '-',
              style: _valueStyle,
            ),
          ],
        ),
      ),
    );
  }
}
