import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:palette_generator/palette_generator.dart';
import 'action.dart';
import 'state.dart';

Effect<FavoritesPageState> buildEffect() {
  return combineEffects(<Object, Effect<FavoritesPageState>>{
    FavoritesPageAction.action: _onAction,
    FavoritesPageAction.setColor: _setColor,
    Lifecycle.initState: _onInit,
    Lifecycle.dispose: _onDispose,
  });
}

void _onAction(Action action, Context<FavoritesPageState> ctx) {}

Future _onInit(Action action, Context<FavoritesPageState> ctx) async {
  final Object ticker = ctx.stfState;
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 600));

  if (ctx.state.user != null) {
    final _baseApi = BaseApi.instance;
    final movie =
        await _baseApi.getFavorite(ctx.state.user.firebaseUser.uid, 'movie');
    if (movie.success) ctx.state.animationController.forward(from: 0.0);
    if ((movie?.result?.data?.length ?? 0) > 0)
      ctx.dispatch(
          FavoritesPageActionCreator.setBackground(movie.result.data[0]));
    ctx.dispatch(FavoritesPageActionCreator.setMovie(movie.result));
    final tv =
        await _baseApi.getFavorite(ctx.state.user.firebaseUser.uid, 'tv');
    if (tv.success)
      ctx.dispatch(FavoritesPageActionCreator.setTVShow(tv.result));
  }
}

void _onDispose(Action action, Context<FavoritesPageState> ctx) {
  ctx.state.animationController.dispose();
}

Future _setColor(Action action, Context<FavoritesPageState> ctx) async {
  final String url = action.payload;
  if (url != null) {
    PaletteGenerator palette =
        await PaletteGenerator.fromImageProvider(CachedNetworkImageProvider(
      ImageUrl.getUrl(url, ImageSize.w300),
    ));
    if (palette != null)
      ctx.dispatch(FavoritesPageActionCreator.updateColor(palette));
  }
}
