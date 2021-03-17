import 'dart:ui';

import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/app_user.dart';
import 'package:movie/models/models.dart';
import 'package:movie/models/people_detail.dart';

class PeopleDetailPageState
    implements GlobalBaseState, Cloneable<PeopleDetailPageState> {
  PeopleDetailModel peopleDetailModel;
  CombinedCreditsModel creditsModel;
  List<CombinedCastData> knowForCast;
  List<CombinedCastData> movies;
  List<CombinedCastData> tvshows;
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
      ..pageScrollPhysics = pageScrollPhysics
      ..movies = movies
      ..tvshows = tvshows;
  }

  @override
  Color themeColor;

  @override
  Locale locale;

  @override
  AppUser user;
}

PeopleDetailPageState initState(Map<String, dynamic> args) {
  var state = PeopleDetailPageState();
  state.peopleDetailModel =
      PeopleDetailModel.fromParams(alsoKnownAs: []);
  state.creditsModel = CombinedCreditsModel.fromParams(
      cast: [], crew: []);
  state.biographyHeight = Adapt.px(200.0);
  state.isBiographyOpen = false;
  state.showmovie = true;
  state.pageScrollPhysics = ClampingScrollPhysics();
  state.knowForCast = [];
  state.peopleid = args['peopleid'];
  state.profilePath = args['profilePath'];
  state.profileName = args['profileName'];
  state.character = args['character'];
  state.movies = [];
  state.tvshows = [];
  return state;
}
