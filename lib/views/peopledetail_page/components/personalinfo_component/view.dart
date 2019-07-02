import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
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
  
  Widget _getGender(){
    if(state.peopleDetailModel.gender==null)
    return _buildnamecell(Adapt.px(60));
    else {
    return Text(state.peopleDetailModel.gender==2?'Male':'Female',style: TextStyle(color: Colors.black87,fontSize: Adapt.px(26)),);
    }
  }

  Widget _getBrirthday(){
    if(state.peopleDetailModel.birthday==null)
    return _buildnamecell(Adapt.px(200));
    else {
    return Text(state.peopleDetailModel.birthday,style: TextStyle(color: Colors.black87,fontSize: Adapt.px(26)),);
    }
  }
 
  Widget _getDepartment(){
    if(state.peopleDetailModel.known_for_department==null)
    return _buildnamecell(Adapt.px(100));
    else {
    return Text(state.peopleDetailModel.known_for_department,style: TextStyle(color: Colors.black87,fontSize: Adapt.px(26)),);
    }
  }
  
  Widget _getCreditCount(){
    if(state.creditcount==0)
    return _buildnamecell(Adapt.px(80));
    else {
    return Text(state.creditcount.toString(),style: TextStyle(color: Colors.black87,fontSize: Adapt.px(26)),);
    }
  }

  Widget _getPlaceOfBirth(){
    if(state.peopleDetailModel.place_of_birth==null)
    return _buildnamecell(Adapt.px(500));
    else {
    return Text(state.peopleDetailModel.place_of_birth,style: TextStyle(color: Colors.black87,fontSize: Adapt.px(26)),);
    }
  }
  
  Widget _getOfficialSite(){
    if(state.peopleDetailModel.id==null)
    return _buildnamecell(Adapt.px(500));
    else {
    return Text(state.peopleDetailModel.homepage??'-',style: TextStyle(color: Colors.black87,fontSize: Adapt.px(26)),);
    }
  }
  
  Widget _getKnownAs(){
    if(state.peopleDetailModel.also_known_as==null)
    return _buildnamecell(Adapt.px(500)); 
    else
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: state.peopleDetailModel.also_known_as.map((s){
        return Text(s,style: TextStyle(color: Colors.black87,fontSize: Adapt.px(24)),);
      }).toList(),
    );
  }
  return Container(
    padding: EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(30)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: Adapt.px(30)),
          child: Text(
            I18n.of(viewService.context).personalInfo,
            softWrap: true,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(40)),
          ),
        ),
        SizedBox(height: Adapt.px(20),),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Adapt.px(200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    I18n.of(viewService.context).gender,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Adapt.px(30)),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  _getGender(),
                ],
              ),
            ),
            SizedBox(
              width: Adapt.px(80),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  I18n.of(viewService.context).birthday,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Adapt.px(30)),
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                _getBrirthday(),
              ],
            )
          ],
        ),
        SizedBox(height: Adapt.px(20),),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Adapt.px(200),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    I18n.of(viewService.context).knownFor,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Adapt.px(30)),
                  ),
                  SizedBox(
                    height: Adapt.px(10),
                  ),
                  _getDepartment(),
                ],
              ),
            ),
            SizedBox(
              width: Adapt.px(80),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  I18n.of(viewService.context).knownCredits,
                  softWrap: true,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: Adapt.px(30)),
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                _getCreditCount(),
              ],
            )
          ],
        ),
        SizedBox(height: Adapt.px(20),),
        Text(
          I18n.of(viewService.context).placeOfBirth,
          softWrap: true,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Adapt.px(30)),
        ),
        SizedBox(height: Adapt.px(20),),
        _getPlaceOfBirth(),
        SizedBox(height: Adapt.px(20),),
        Text(
          I18n.of(viewService.context).officialSite,
          softWrap: true,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Adapt.px(30)),
        ),
        SizedBox(height: Adapt.px(20),),
        _getOfficialSite(),
        SizedBox(height: Adapt.px(20),),
        Text(
          I18n.of(viewService.context).alsoKnownAs,
          softWrap: true,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: Adapt.px(30)),
        ),
        SizedBox(
          height: Adapt.px(10),
        ),
        _getKnownAs(),
      ],
    ),
  );
}
