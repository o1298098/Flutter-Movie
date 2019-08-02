import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/videolist.dart';
import 'package:palette_generator/palette_generator.dart';

class FavoritesPageState implements Cloneable<FavoritesPageState> {

int accountId;
VideoListModel favoriteMovies;
VideoListModel favoriteTVShows;
VideoListResult selectedMedia;
Color backgroundColor;
String backgroundUrl;
String secbackgroundUrl;
AnimationController animationController;
PaletteGenerator paletteGenerator;
bool isMovie;

  @override
  FavoritesPageState clone() {
    return FavoritesPageState()
    ..accountId=accountId
    ..favoriteMovies=favoriteMovies
    ..favoriteTVShows=favoriteTVShows
    ..backgroundColor=backgroundColor
    ..secbackgroundUrl=secbackgroundUrl
    ..backgroundUrl=backgroundUrl
    ..selectedMedia=selectedMedia
    ..animationController=animationController
    ..paletteGenerator=paletteGenerator
    ..isMovie=isMovie;
  }
}

FavoritesPageState initState(Map<String, dynamic> args) {
  FavoritesPageState state=FavoritesPageState();
  state.accountId=args['accountid'];
  state.isMovie=true;
  state.backgroundColor=Colors.black;
  state.favoriteMovies=VideoListModel.fromParams(results: []);
  state.favoriteTVShows=VideoListModel.fromParams(results: []);
  state.paletteGenerator=PaletteGenerator.fromColors([]);
  return state;
}
