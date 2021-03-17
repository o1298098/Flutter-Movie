import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/account_state.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/keyword.dart';
import 'package:movie/models/review.dart';
import 'package:movie/models/tvshow_detail.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/models/video_model.dart';

class TvShowDetailState implements Cloneable<TvShowDetailState> {
  GlobalKey<ScaffoldState> scaffoldkey;
  TVDetailModel tvDetailModel;
  int tvid;
  CreditsModel creditsModel;
  ImageModel imagesmodel;
  ReviewModel reviewModel;
  VideoListModel recommendations;
  KeyWordModel keywords;
  VideoModel videomodel;
  AccountState accountState;
  @override
  TvShowDetailState clone() {
    return TvShowDetailState()
      ..scaffoldkey = scaffoldkey
      ..tvDetailModel = tvDetailModel
      ..creditsModel = creditsModel
      ..tvid = tvid
      ..reviewModel = reviewModel
      ..imagesmodel = imagesmodel
      ..recommendations = recommendations
      ..keywords = keywords
      ..videomodel = videomodel
      ..accountState = accountState;
  }
}

TvShowDetailState initState(Map<String, dynamic> args) {
  TvShowDetailState state = TvShowDetailState();
  state.scaffoldkey =
      GlobalKey<ScaffoldState>(debugLabel: '_TvShowDetailPagekey');
  state.tvid = args['id'];

  state.tvDetailModel = new TVDetailModel.fromParams();
  state.creditsModel = new CreditsModel.fromParams(
      cast: [], crew: []);

  state.imagesmodel = new ImageModel.fromParams(
      posters: [], backdrops:[]);
  state.reviewModel = new ReviewModel.fromParams(results: []);
  state.recommendations =
      new VideoListModel.fromParams(results: []);
  state.keywords = new KeyWordModel.fromParams(
      keywords: [], results: []);
  state.videomodel = new VideoModel.fromParams(results: []);
  state.accountState = AccountState.fromParams(
      id: 0,
      uid: GlobalStore.store.getState().user?.firebaseUser?.uid,
      mediaId: state.tvid,
      favorite: false,
      watchlist: false,
      mediaType: 'tv');
  return state;
}
