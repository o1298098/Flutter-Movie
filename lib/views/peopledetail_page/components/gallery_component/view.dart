import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/image_model.dart';
import 'package:movie/models/people_detail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    GalleryState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Container(
      key: ValueKey('gallery'),
      padding: EdgeInsets.only(top: Adapt.px(50)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              child: Row(
                children: <Widget>[
                  Text(
                    'Photos',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: Container()),
                  InkWell(
                    onTap: () =>
                        dispatch(GalleryActionCreator.viewMoreTapped()),
                    child: Text(
                      'View more',
                      style:
                          TextStyle(color: Colors.grey, fontSize: Adapt.px(24)),
                    ),
                  )
                ],
              )),
          SizedBox(height: Adapt.px(30)),
          _Gallery(images: state?.images),
          SizedBox(height: Adapt.px(50)),
        ],
      ),
    ),
  );
}

class _ImageCell extends StatelessWidget {
  final ImageData data;
  const _ImageCell({this.data});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Hero(
      key: ValueKey('image${data.filePath}'),
      tag: 'image${data.filePath}',
      child: Container(
        width: Adapt.px(200),
        height: Adapt.px(180),
        decoration: BoxDecoration(
          color: _theme.primaryColorDark,
          borderRadius: BorderRadius.circular(Adapt.px(20)),
          image: DecorationImage(
            fit: BoxFit.cover,
            image: CachedNetworkImageProvider(
              ImageUrl.getUrl(data.filePath, ImageSize.w300),
            ),
          ),
        ),
      ),
    );
  }
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adapt.px(200),
      height: Adapt.px(180),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(Adapt.px(20)),
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
          itemCount: 4,
          itemBuilder: (context, index) => _ShimmerCell(),
        ));
  }
}

class _Gallery extends StatelessWidget {
  final ProfileImages images;
  const _Gallery({this.images});
  @override
  Widget build(BuildContext context) {
    var _model = images?.profiles ?? [];
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 300),
      child: Container(
        key: ValueKey(_model),
        height: Adapt.px(180),
        child: _model.length > 0
            ? ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>
                    SizedBox(width: Adapt.px(30)),
                itemCount: _model.length,
                itemBuilder: (_, index) => _ImageCell(data: _model[index]),
              )
            : _ShimmerList(),
      ),
    );
  }
}
