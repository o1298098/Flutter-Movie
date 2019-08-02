import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/apihelper.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:palette_generator/palette_generator.dart';
import 'action.dart';
import 'state.dart';

Effect<FavoritesPageState> buildEffect() {
  return combineEffects(<Object, Effect<FavoritesPageState>>{
    FavoritesPageAction.action: _onAction,
    FavoritesPageAction.setColor: _setColor,
    Lifecycle.initState: _onInit,
  });
}

void _onAction(Action action, Context<FavoritesPageState> ctx) {}

Future _onInit(Action action, Context<FavoritesPageState> ctx) async {
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 600));
  int accountid = ctx.state.accountId;
  if (accountid != null) {
    var movie = await ApiHelper.getFavoriteMovies(accountid);
    if (movie != null) {
      ctx.dispatch(FavoritesPageActionCreator.setFavoriteMovies(movie));
      if (movie.results.length > 0)
        ctx.dispatch(FavoritesPageActionCreator.setBackground(movie.results[0],Colors.black));
        ctx.state.animationController.forward(from: 0.0);
        //ctx.dispatch(FavoritesPageActionCreator.setColor(r.results[0].poster_path));
    }
    var tv=await ApiHelper.getFavoriteTVShows(accountid);
    if (tv != null) ctx.dispatch(FavoritesPageActionCreator.setFavoriteTV(tv));
  }
}

Future _setColor(Action action, Context<FavoritesPageState> ctx) async {
  final String url = action.payload;
  if (url != null) {
    PaletteGenerator palette =
        await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(
      ImageUrl.getUrl(url, ImageSize.w300),
    ));
      if (palette!=null)ctx.dispatch(FavoritesPageActionCreator.updateColor(palette));
  }
}
