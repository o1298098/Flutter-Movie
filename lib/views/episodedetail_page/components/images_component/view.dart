import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/episode_model.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ImagesState state, Dispatch dispatch, ViewService viewService) {
  return AnimatedSwitcher(
    switchInCurve: Curves.easeIn,
    switchOutCurve: Curves.easeOut,
    duration: Duration(milliseconds: 600),
    child: Column(
      key: ValueKey(state.images),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(Adapt.px(28), 0, Adapt.px(28), 0),
          child: Text.rich(TextSpan(children: [
            TextSpan(
                text: I18n.of(viewService.context).episodeImages,
                style: TextStyle(
                    fontSize: Adapt.px(35), fontWeight: FontWeight.bold)),
            TextSpan(
                text:
                    ' ${state.images != null ? state.images.stills.length.toString() : ''}',
                style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)))
          ])),
        ),
        SizedBox(
          height: Adapt.px(30),
        ),
        _ImageList(
          dispatch: dispatch,
          images: state.images,
        ),
        SizedBox(
          height: Adapt.px(30),
        ),
      ],
    ),
  );
}

class _ImageCell extends StatelessWidget {
  final Function onTap;
  final String url;
  final int index;
  const _ImageCell({this.onTap, this.url, this.index});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: onTap,
      child: Hero(
        tag: url + index.toString(),
        child: Container(
          height: Adapt.px(200),
          width: Adapt.px(350),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(15)),
              color: _theme.primaryColorDark,
              image: DecorationImage(
                  fit: BoxFit.cover, image: CachedNetworkImageProvider(url))),
        ),
      ),
    );
  }
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: Adapt.px(20)),
      height: Adapt.px(200),
      width: Adapt.px(350),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Adapt.px(15)),
        color: Colors.grey[200],
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Container(
        height: Adapt.px(200),
        child: ListView(scrollDirection: Axis.horizontal, children: <Widget>[
          SizedBox(width: Adapt.px(30)),
          _ShimmerCell(),
          _ShimmerCell(),
          _ShimmerCell(),
        ]),
      ),
    );
  }
}

class _ImageList extends StatelessWidget {
  final EpisodeImageModel images;
  final Dispatch dispatch;
  const _ImageList({this.images, this.dispatch});
  @override
  Widget build(BuildContext context) {
    if (images != null) {
      if (images.stills.length > 0) {
        return Container(
          height: Adapt.px(200),
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            scrollDirection: Axis.horizontal,
            separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
            itemCount: images.stills.length,
            itemBuilder: (_, index) => _ImageCell(
              url: ImageUrl.getUrl(
                  images.stills[index].filePath, ImageSize.w500),
              onTap: () =>
                  dispatch(ImagesActionCreator.onGalleryImageTapped(index)),
            ),
          ),
        );
      } else
        return Container(
          width: Adapt.screenW(),
          padding: EdgeInsets.only(left: Adapt.px(28)),
          child: Text(I18n.of(context).episodeImages),
        );
    } else
      return _ShimmerList();
  }
}
