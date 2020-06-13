import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/widgets/dialogratingbar.dart';
import 'package:movie/widgets/medialist_card.dart';
import 'package:movie/widgets/share_card.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(MenuState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildListTitel(IconData icon, String title, void onTap(),
      {Color iconColor = const Color.fromRGBO(50, 50, 50, 1)}) {
    TextStyle titleStyle =
        TextStyle(color: Color.fromRGBO(50, 50, 50, 1), fontSize: Adapt.px(40));
    return ListTile(
      leading: Icon(
        icon,
        color: iconColor,
      ),
      title: Text(title, style: titleStyle),
      onTap: onTap,
    );
  }

  void _addToList() {
    Navigator.of(viewService.context).pop();
    showDialog(
        context: viewService.context,
        builder: (ctx) {
          return MediaListCardDialog(
            type: MediaType.movie,
            mediaId: state.id,
          );
        });
  }

  void _rateIt() {
    Navigator.of(viewService.context).pop();
    showDialog(
        context: viewService.context,
        builder: (ctx) {
          double rate = state.accountState.rated?.value ?? 0;
          return DialogRatingBar(
            rating: rate,
            submit: (d) => dispatch(MenuActionCreator.setRating(d)),
          );
        });
  }

  void _share() {
    Navigator.of(viewService.context).pop();
    showDialog(
        context: viewService.context,
        builder: (ctx) {
          var width = (Adapt.screenW() - Adapt.px(60)).floorToDouble();
          var height = ((width - Adapt.px(40)) / 2).floorToDouble();
          return ShareCard(
            backgroundImage: ImageUrl.getUrl(state.backdropPic, ImageSize.w300),
            qrValue:
                'https://www.themoviedb.org/movie/${state.id}?language=${ui.window.locale.languageCode}',
            headerHeight: height,
            header: Column(children: <Widget>[
              SizedBox(
                height: Adapt.px(20),
              ),
              Row(
                children: <Widget>[
                  SizedBox(
                    width: Adapt.px(20),
                  ),
                  Container(
                    width: Adapt.px(120),
                    height: Adapt.px(120),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.white, width: Adapt.px(5)),
                        borderRadius: BorderRadius.circular(Adapt.px(60)),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: CachedNetworkImageProvider(ImageUrl.getUrl(
                                state.posterPic, ImageSize.w300)))),
                  ),
                  SizedBox(
                    width: Adapt.px(20),
                  ),
                  Container(
                    width: width - Adapt.px(310),
                    child: Text(state.name,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: Adapt.px(40),
                            fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(offset: Offset(Adapt.px(1), Adapt.px(1)))
                            ])),
                  ),
                ],
              ),
              SizedBox(
                height: Adapt.px(20),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
                width: width - Adapt.px(40),
                height: height - Adapt.px(170),
                child: Text(state.overWatch,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.px(26),
                        shadows: <Shadow>[
                          Shadow(
                              offset: Offset(Adapt.px(1), Adapt.px(1)),
                              blurRadius: 3)
                        ])),
              )
            ]),
          );
        });
  }

  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(Adapt.px(50)))),
    //padding: EdgeInsets.only(top:Adapt.px(30)),
    child: ListView(
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(Adapt.px(20)),
          height: Adapt.px(100),
          child: Row(
            children: <Widget>[
              Container(
                height: Adapt.px(100),
                width: Adapt.px(100),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(Adapt.px(50)),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(state.posterPic, ImageSize.w300)))),
              ),
              SizedBox(
                width: Adapt.px(30),
              ),
              SizedBox(
                  width: Adapt.screenW() - Adapt.px(170),
                  child: Text(
                    state.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: Adapt.px(40),
                        fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
        Divider(
          height: 1,
        ),
        _buildListTitel(Icons.format_list_bulleted, 'Add to List', _addToList),
        Divider(
          height: Adapt.px(10),
        ),
        _buildListTitel(
            state.accountState.favorite
                ? Icons.favorite
                : Icons.favorite_border,
            'Mark as Favorite', () {
          Navigator.of(viewService.context).pop();
          dispatch(MenuActionCreator.setFavorite(!state.accountState.favorite));
        },
            iconColor: state.accountState.favorite
                ? Colors.pink[400]
                : Color.fromRGBO(50, 50, 50, 1)),
        Divider(
          height: Adapt.px(10),
        ),
        _buildListTitel(
          Icons.flag,
          'Add to your Watchlist',
          () {
            Navigator.of(viewService.context).pop();
            dispatch(
                MenuActionCreator.setWatchlist(!state.accountState.watchlist));
          },
          iconColor: state.accountState.watchlist
              ? Colors.red
              : Color.fromRGBO(50, 50, 50, 1),
        ),
        Divider(
          height: Adapt.px(10),
        ),
        _buildListTitel(
            state.accountState.isRated == true ? Icons.star : Icons.star_border,
            'Rate It',
            _rateIt,
            iconColor: state.accountState.isRated == true
                ? Colors.amber
                : Color.fromRGBO(50, 50, 50, 1)),
        Divider(
          height: Adapt.px(10),
        ),
        _buildListTitel(Icons.share, 'Share', _share),
        Divider(
          height: Adapt.px(10),
        ),
      ],
    ),
  );
}
