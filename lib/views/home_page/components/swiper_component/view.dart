import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/widgets/shimmercell.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/video_list.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/home_page/action.dart';

import 'state.dart';

Widget buildView(
    SwiperState state, Dispatch dispatch, ViewService viewService) {
  return SizedBox(
    height: Adapt.px(225),
    child: _Swiper(
      model: state.showHeaderMovie ? state.movie : state.tv,
      showMovie: state.showHeaderMovie,
      dispatch: dispatch,
    ),
  );
}

class _Cell extends StatelessWidget {
  final VideoListResult data;
  final Function onTap;
  const _Cell({@required this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      key: ValueKey('card${data.id}'),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: new BoxDecoration(
              color: _theme.brightness == Brightness.light
                  ? const Color(0xFFFFFFFF)
                  : const Color(0xFF404040),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: _theme.brightness == Brightness.light
                        ? Colors.grey[200]
                        : Colors.transparent,
                    offset: Offset(0, Adapt.px(20)),
                    blurRadius: Adapt.px(30),
                    spreadRadius: Adapt.px(1)),
              ],
            ),
            margin: EdgeInsets.fromLTRB(
                Adapt.px(30), Adapt.px(5), Adapt.px(30), Adapt.px(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(120),
                  height: Adapt.px(170),
                  decoration: BoxDecoration(
                    color: _theme.primaryColorLight,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(data.posterPath, ImageSize.w300),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: Adapt.px(20)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: Adapt.px(20)),
                    Row(
                      children: <Widget>[
                        Container(
                          width: Adapt.screenW() - Adapt.px(450),
                          child: Text(
                            data.title ?? data.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                //color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: Adapt.px(28)),
                          ),
                        ),
                        Container(
                          width: Adapt.px(160),
                          child: RatingBarIndicator(
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            unratedColor: Colors.grey[300],
                            itemSize: Adapt.px(22),
                            itemPadding: EdgeInsets.only(right: Adapt.px(8)),
                            rating: data.voteAverage / 2,
                          ),
                        ),
                        Text(
                          data.voteAverage.toStringAsFixed(1),
                          style: TextStyle(
                              fontSize: Adapt.px(22),
                              fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                    SizedBox(height: Adapt.px(20)),
                    Container(
                      width: Adapt.screenW() - Adapt.px(210),
                      child: Text(
                        data.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: Adapt.px(22)),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _ShimmerCell extends StatelessWidget {
  const _ShimmerCell();
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      margin: EdgeInsets.only(bottom: Adapt.px(55)),
      child: ShimmerCell(
        Adapt.screenW() - Adapt.px(60),
        Adapt.px(170),
        0,
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
      ),
    );
  }
}

class _Swiper extends StatelessWidget {
  final VideoListModel model;
  final bool showMovie;
  final Dispatch dispatch;
  const _Swiper({this.model, this.showMovie, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 600),
      switchInCurve: Curves.easeIn,
      switchOutCurve: Curves.easeOut,
      child: model.results.length > 0
          ? Swiper(
              key: ValueKey(model),
              autoplay: true,
              duration: 1000,
              autoplayDelay: 10000,
              viewportFraction: 0.9999,
              itemCount: model.results.length,
              itemBuilder: (ctx, index) {
                var d = model.results[index];
                return _Cell(
                  data: d,
                  onTap: () => dispatch(HomePageActionCreator.onCellTapped(
                      d.id,
                      d.backdropPath,
                      d.title ?? d.name,
                      d.posterPath,
                      showMovie ? MediaType.movie : MediaType.tv)),
                );
              },
            )
          : const _ShimmerCell(),
    );
  }
}
