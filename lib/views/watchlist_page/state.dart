import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/base_api_model/user_media.dart';
import 'package:movie/models/videolist.dart';

class WatchlistPageState
    implements GlobalBaseState, Cloneable<WatchlistPageState> {
  int accountId;
  AnimationController animationController;
  UserMedia selectMdeia;
  bool isMovie;
  SwiperController swiperController;
  UserMediaModel movies;
  UserMediaModel tvshows;
  @override
  WatchlistPageState clone() {
    return WatchlistPageState()
      ..accountId = accountId
      ..animationController = animationController
      ..selectMdeia = selectMdeia
      ..swiperController = swiperController
      ..isMovie = isMovie
      ..movies = movies
      ..tvshows = tvshows
      ..user = user;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;
}

WatchlistPageState initState(Map<String, dynamic> args) {
  WatchlistPageState state = WatchlistPageState();
  state.accountId = args['accountid'];
  state.isMovie = true;
  return state;
}
