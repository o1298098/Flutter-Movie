import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    PersonalInfoState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildnamecell(double d) {
    return SizedBox(
        child: Shimmer.fromColors(
      baseColor: Colors.grey[200],
      highlightColor: Colors.grey[100],
      child: Container(
        height: Adapt.px(50),
        width: d,
        color: Colors.grey[200],
      ),
    ));
  }

  Widget _getGender() {
    if (state.peopleDetailModel.gender == null)
      return _buildnamecell(Adapt.px(60));
    else {
      return Text(
        state.peopleDetailModel.gender == 2 ? 'Male' : 'Female',
        style: TextStyle(color: Colors.black87, fontSize: Adapt.px(26)),
      );
    }
  }

  Widget _getBrirthday() {
    if (state.peopleDetailModel.birthday == null)
      return _buildnamecell(Adapt.px(200));
    else {
      return Text(
        state.peopleDetailModel.birthday,
        style: TextStyle(color: Colors.black87, fontSize: Adapt.px(26)),
      );
    }
  }

  Widget _getDepartment() {
    if (state.peopleDetailModel.known_for_department == null)
      return _buildnamecell(Adapt.px(100));
    else {
      return Text(
        state.peopleDetailModel.known_for_department,
        style: TextStyle(color: Colors.black87, fontSize: Adapt.px(26)),
      );
    }
  }

  Widget _getCreditCount() {
    if (state.creditcount == 0)
      return _buildnamecell(Adapt.px(80));
    else {
      return Text(
        state.creditcount.toString(),
        style: TextStyle(color: Colors.black87, fontSize: Adapt.px(26)),
      );
    }
  }

  Widget _getPlaceOfBirth() {
    if (state.peopleDetailModel.place_of_birth == null)
      return _buildnamecell(Adapt.px(500));
    else {
      return Text(
        state.peopleDetailModel.place_of_birth,
        style: TextStyle(color: Colors.black87, fontSize: Adapt.px(26)),
      );
    }
  }

  Widget _getOfficialSite() {
    if (state.peopleDetailModel.id == null)
      return _buildnamecell(Adapt.px(500));
    else {
      return Text(
        state.peopleDetailModel.homepage ?? '-',
        style: TextStyle(color: Colors.black87, fontSize: Adapt.px(26)),
      );
    }
  }

  Widget _getKnownAs() {
    if (state.peopleDetailModel.also_known_as == null)
      return _buildnamecell(Adapt.px(500));
    else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: state.peopleDetailModel.also_known_as.map((s) {
          return Text(
            s,
            style: TextStyle(color: Colors.black87, fontSize: Adapt.px(24)),
          );
        }).toList(),
      );
  }

  Widget _buildInfoBody() {
    var _titleStyle =
        TextStyle(color: Colors.grey[600], fontSize: Adapt.px(26));
    var _valueStyle = TextStyle(
        color: Colors.black,
        fontSize: Adapt.px(30),
        fontWeight: FontWeight.w500);
    var _data = state.peopleDetailModel;
    String birthday;
    if (_data?.birthday != null)
      birthday = DateFormat.yMMMMd().format(DateTime.parse(_data.birthday));
    return Container(
      padding: EdgeInsets.all(Adapt.px(30)),
      width: Adapt.screenW() - Adapt.px(60),
      //height: Adapt.px(400),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(Adapt.px(30))),
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
            _data?.known_for_department ?? '',
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
            '${birthday ?? ''} in ${_data?.place_of_birth ?? ''}',
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
            _data?.also_known_as?.join(' , ') ?? '-',
            style: _valueStyle,
          ),
        ],
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
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: Adapt.px(40)),
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
