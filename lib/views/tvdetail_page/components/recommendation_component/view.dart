import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/views/tvdetail_page/action.dart';

import 'state.dart';

Widget buildView(
    RecommendationState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Padding(
        padding: EdgeInsets.all(Adapt.px(30)),
        child: Text(I18n.of(viewService.context).recommendations,
            style:
                TextStyle(fontSize: Adapt.px(40), fontWeight: FontWeight.w800)),
      ),
      _RecommendationBody(
        dispatch: dispatch,
        recommendations: state.recommendations ?? [],
      ),
    ],
  ));
}

class _RecommendationCell extends StatelessWidget {
  final VideoListResult d;
  final Function(VideoListResult) onTap;
  const _RecommendationCell({this.d, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: Adapt.px(400),
          height: Adapt.px(400) * 9 / 16,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(Adapt.px(10)),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  width: Adapt.px(400),
                  height: Adapt.px(400) * 9 / 16,
                  placeholder: 'images/CacheBG.jpg',
                  image: ImageUrl.getUrl(
                      d.backdropPath ?? '/eIkFHNlfretLS1spAcIoihKUS62.jpg',
                      ImageSize.w400),
                ),
              ),
              Container(
                padding: EdgeInsets.all(Adapt.px(10)),
                alignment: Alignment.bottomLeft,
                child: Text(
                  d.name ?? '',
                  softWrap: false,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: Adapt.px(28),
                    shadows: <Shadow>[
                      Shadow(
                        blurRadius: 1.2,
                        color: Colors.black87,
                        offset: Offset(
                          Adapt.px(2),
                          Adapt.px(2),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(Adapt.px(10)),
                alignment: Alignment.topRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: Adapt.px(28),
                    ),
                    Text(
                      d.voteAverage.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: Adapt.px(28),
                        shadows: <Shadow>[
                          Shadow(
                            blurRadius: 1.2,
                            color: Colors.black87,
                            offset: Offset(
                              Adapt.px(3),
                              Adapt.px(3),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
      onTap: () => onTap(d),
    );
  }
}

class _RecommendationShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adapt.px(400),
      height: Adapt.px(400) * 9 / 16,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(Adapt.px(10)),
      ),
    );
  }
}

class _RecommendationShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      scrollDirection: Axis.horizontal,
      separatorBuilder: (context, index) => SizedBox(width: Adapt.px(30)),
      itemCount: 3,
      itemBuilder: (_, __) => _RecommendationShimmer(),
    );
  }
}

class _RecommendationBody extends StatelessWidget {
  final List<VideoListResult> recommendations;
  final Dispatch dispatch;
  const _RecommendationBody({this.dispatch, this.recommendations});
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: Adapt.px(30)),
        height: Adapt.px(400) * 9 / 16,
        child: recommendations.length > 0
            ? ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) =>
                    SizedBox(width: Adapt.px(30)),
                itemCount: recommendations.length,
                itemBuilder: (context, index) => _RecommendationCell(
                  d: recommendations[index],
                  onTap: (d) => dispatch(
                    TVDetailPageActionCreator.onRecommendationTapped(
                        d.id, d.backdropPath),
                  ),
                ),
              )
            : _RecommendationShimmerList());
  }
}
