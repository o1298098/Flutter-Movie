import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/widgets/expandable_text.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    child: Column(children: [
      _HeaderPanel(
        backgroundUrl: state.posterurl,
        title: state.name,
        seasonName: state.seasonName,
        overview: state.overwatch,
      ),
    ]),
  );
}

class _HeaderPanel extends StatelessWidget {
  final String title;
  final String seasonName;
  final String backgroundUrl;
  final String overview;
  const _HeaderPanel(
      {this.backgroundUrl, this.seasonName, this.title, this.overview});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adapt.screenW(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Adapt.px(40), vertical: Adapt.px(30)),
            child: Text(
              seasonName,
              style: TextStyle(
                fontSize: Adapt.px(50),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            width: Adapt.screenW() - Adapt.px(80),
            height: Adapt.screenW() - Adapt.px(80),
            margin: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Adapt.px(30)),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                  ImageUrl.getUrl(backgroundUrl, ImageSize.w500),
                ),
              ),
            ),
          ),
          overview != null
              ? _OverviewPanel(
                  overview: overview,
                )
              : SizedBox()
        ],
      ),
    );
  }
}

class _OverviewPanel extends StatelessWidget {
  final String overview;
  const _OverviewPanel({this.overview});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Adapt.px(40), vertical: Adapt.px(30)),
          child: Text(
            'Overview',
            style: TextStyle(
              fontSize: Adapt.px(30),
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
          child: ExpandableText(
            overview ?? '',
            maxLines: 3,
            style: TextStyle(
              fontSize: Adapt.px(24),
              color: const Color(0xFF717171),
            ),
          ),
        )
      ],
    );
  }
}
