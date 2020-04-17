import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SeasonCastState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    key: ValueKey(state.castData),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: I18n.of(viewService.context).seasonCast,
                  style: TextStyle(
                      fontSize: Adapt.px(35), fontWeight: FontWeight.bold),
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
  );
}

class _CreditsShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Adapt.px(220),
      height: Adapt.px(450),
      child: Column(
        children: <Widget>[
          Container(
            color: Colors.grey[200],
            width: Adapt.px(220),
            height: Adapt.px(300),
          ),
          Container(
            height: Adapt.px(24),
            margin: EdgeInsets.fromLTRB(0, Adapt.px(15), Adapt.px(20), 0),
            color: Colors.grey[200],
          ),
          Container(
            height: Adapt.px(24),
            margin: EdgeInsets.fromLTRB(0, Adapt.px(5), Adapt.px(20), 0),
            color: Colors.grey[200],
          ),
          Container(
            height: Adapt.px(24),
            margin:
                EdgeInsets.fromLTRB(0, Adapt.px(5), Adapt.px(70), Adapt.px(20)),
            color: Colors.grey[200],
          ),
        ],
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
    return GestureDetector(
      key: ValueKey(data.id),
      onTap: () => onTap(data),
      child: Container(
        child: Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                  tag: 'people' + data.id.toString(),
                  child: Container(
                    width: Adapt.px(220),
                    height: Adapt.px(300),
                    decoration: BoxDecoration(
                      color: _theme.primaryColorLight,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(data.profilePath, ImageSize.w200),
                        ),
                      ),
                    ),
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(
                    Adapt.px(8), Adapt.px(10), Adapt.px(8), 0),
                width: Adapt.px(220),
                child: Text(
                  data.name,
                  style: TextStyle(
                      fontSize: Adapt.px(26), fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(Adapt.px(8), 0, Adapt.px(8), 0),
                width: Adapt.px(220),
                child: Text(
                  data.character,
                  maxLines: 2,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: Adapt.px(26),
                  ),
                ),
              )
            ],
          ),
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
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Container(
      height: Adapt.px(450),
      child: castData != null
          ? ListView.separated(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              separatorBuilder: (context, index) =>
                  SizedBox(width: Adapt.px(30)),
              itemCount: castData.length,
              itemBuilder: (context, index) => _CastCell(
                data: castData[index],
                onTap: (d) => dispatch(SeasonCastActionCreator.onCastCellTapped(
                    d.id, d.profilePath, d.name)),
              ),
            )
          : Shimmer.fromColors(
              baseColor: _theme.primaryColorDark,
              highlightColor: _theme.primaryColorLight,
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                separatorBuilder: (context, index) =>
                    SizedBox(width: Adapt.px(30)),
                itemCount: 3,
                itemBuilder: (context, index) => _CreditsShimmerCell(),
              ),
            ),
    );
  }
}
