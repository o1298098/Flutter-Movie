import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/combinedcredits.dart';
import 'package:movie/models/peopledetail.dart';
import 'components/gallery_component/state.dart';
import 'components/header_component/state.dart';
import 'components/knownfor_component/state.dart';
import 'components/personalinfo_component/state.dart';
import 'components/timeline_component/state.dart';

class PeopleDetailPageState extends MutableSource
    implements GlobalBaseState, Cloneable<PeopleDetailPageState> {
  PeopleDetailModel peopleDetailModel;
  CombinedCreditsModel creditsModel;
  List<CastData> knowForCast;
  int peopleid;
  double biographyHeight;
  bool isBiographyOpen;
  bool showmovie;
  String profilePath;
  String profileName;
  String character;
  ScrollPhysics pageScrollPhysics;
  @override
  PeopleDetailPageState clone() {
    return PeopleDetailPageState()
      ..peopleDetailModel = peopleDetailModel
      ..peopleid = peopleid
      ..profilePath = profilePath
      ..profileName = profileName
      ..creditsModel = creditsModel
      ..isBiographyOpen = isBiographyOpen
      ..biographyHeight = biographyHeight
      ..showmovie = showmovie
      ..knowForCast = knowForCast
      ..pageScrollPhysics = pageScrollPhysics;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  FirebaseUser user;

  @override
  Object getItemData(int index) {
    switch (index) {
      case 0:
        return HeaderState(
            peopleid: peopleid,
            biography: peopleDetailModel.biography,
            profileName: profileName,
            profilePath: profilePath,
            character: character,
            deathday: peopleDetailModel.deathday,
            birthday: peopleDetailModel?.birthday);
      case 1:
        return PersonalInfoState(
            peopleDetailModel: peopleDetailModel,
            creditcount: creditsModel.cast.length + creditsModel.crew.length);
      case 2:
        return KnownForState(cast: knowForCast);
      case 3:
        return GalleryState(images: peopleDetailModel.images);
      case 4:
        return TimeLineState(
            creditsModel: creditsModel,
            department: peopleDetailModel.knownForDepartment,
            showmovie: showmovie,
            scrollPhysics: PageScrollPhysics(parent: pageScrollPhysics));
      default:
        return null;
    }
  }

  @override
  String getItemType(int index) {
    switch (index) {
      case 0:
        return 'header';
      case 1:
        return 'personalinfo';
      case 2:
        return 'knownfor';
      case 3:
        return 'gallery';
      case 4:
        return 'timeline';
      default:
        return 'header';
    }
  }

  @override
  int get itemCount => 5;

  @override
  void setItemData(int index, Object data) {
    if (index == 4) {
      TimeLineState d = data;
      showmovie = d.showmovie;
    }
  }
}

PeopleDetailPageState initState(Map<String, dynamic> args) {
  var state = PeopleDetailPageState();
  state.peopleDetailModel =
      PeopleDetailModel.fromParams(alsoKnownAs: List<String>());
  state.creditsModel = CombinedCreditsModel.fromParams(
      cast: List<CastData>(), crew: List<CrewData>());
  state.biographyHeight = Adapt.px(200.0);
  state.isBiographyOpen = false;
  state.showmovie = true;
  state.pageScrollPhysics = new ScrollPhysics();
  state.knowForCast = [];
  state.peopleid = args['peopleid'];
  state.profilePath = args['profilePath'];
  state.profileName = args['profileName'];
  state.character = args['character'];
  return state;
}
