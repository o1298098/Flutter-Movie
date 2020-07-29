import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SeasonCastState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Container(
      key: ValueKey(state.castData),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(Adapt.px(40)),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: I18n.of(viewService.context).seasonCast,
                    style: TextStyle(
                        fontSize: Adapt.px(30), fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text:
                        ' ${state.castData != null ? state.castData.length.toString() : ''}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: Adapt.px(26),
                    ),
                  ),
                ],
              ),
            ),
          ),
          _CastBody(
            dispatch: dispatch,
            castData: state.castData,
          ),
        ],
      ),
    ),
  );
}

class _CreditsShimmerCell extends StatelessWidget {
  const _CreditsShimmerCell();
  @override
  Widget build(BuildContext context) {
    final _width = Adapt.px(120);
    final _color = const Color(0xFFFFFFFF);
    return SizedBox(
      width: _width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: _width,
            height: _width,
            decoration: BoxDecoration(
              color: _color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(height: Adapt.px(15)),
          Container(
            height: Adapt.px(18),
            color: _color,
          ),
          SizedBox(height: Adapt.px(8)),
          Container(
            height: Adapt.px(18),
            width: Adapt.px(80),
            color: _color,
          ),
        ],
      ),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
        separatorBuilder: (context, index) => SizedBox(width: Adapt.px(40)),
        itemCount: 5,
        itemBuilder: (context, index) => const _CreditsShimmerCell(),
      ),
    );
  }
}

class _CastCell extends StatelessWidget {
  final CastData data;
  final Function(CastData) onTap;
  const _CastCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    final _width = Adapt.px(120);
    return GestureDetector(
      key: ValueKey(data.id),
      onTap: () => onTap(data),
      child: SizedBox(
        width: _width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: _width,
              height: _width,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _theme.primaryColorLight,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(data.profilePath, ImageSize.w200),
                  ),
                ),
              ),
            ),
            SizedBox(height: Adapt.px(8)),
            Text(
              data.name,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.fade,
              style: TextStyle(
                fontSize: Adapt.px(24),
                color: const Color(0xFF717171),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CastBody extends StatelessWidget {
  final List<CastData> castData;
  final Dispatch dispatch;
  const _CastBody({this.castData, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(220),
      child: castData != null
          ? ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              separatorBuilder: (context, index) =>
                  SizedBox(width: Adapt.px(40)),
              itemCount: castData.length,
              itemBuilder: (context, index) => _CastCell(
                data: castData[index],
                onTap: (d) => dispatch(
                  SeasonCastActionCreator.onCastCellTapped(
                      d.id, d.profilePath, d.name),
                ),
              ),
            )
          : const _ShimmerList(),
    );
  }
}
