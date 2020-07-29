import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/episodedetail_page/components/credits_component/action.dart';
import 'package:shimmer/shimmer.dart';
import "package:collection/collection.dart";

import 'state.dart';

Widget buildView(
    CreditsState state, Dispatch dispatch, ViewService viewService) {
  return Container(
    padding: EdgeInsets.fromLTRB(Adapt.px(28), 0, Adapt.px(28), 0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text.rich(TextSpan(children: [
          TextSpan(
              text: I18n.of(viewService.context).guestStars,
              style: TextStyle(
                  fontSize: Adapt.px(35), fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  ' ${state.guestStars != null ? state.guestStars.length.toString() : ''}',
              style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)))
        ])),
        SizedBox(height: Adapt.px(30)),
        _GuestStarsBody(
          guestStars: state.guestStars,
          dispatch: dispatch,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: I18n.of(viewService.context).crew,
              style: TextStyle(
                  fontSize: Adapt.px(35), fontWeight: FontWeight.bold)),
          TextSpan(
              text:
                  ' ${state.crew != null ? state.crew.length.toString() : ''}',
              style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)))
        ])),
        SizedBox(height: Adapt.px(30)),
        _CrewBody(
          dispatch: dispatch,
          data: state.crew,
        ),
      ],
    ),
  );
}

class _CrewCell extends StatelessWidget {
  final CrewData data;
  final Function onTap;
  const _CrewCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final double w = (Adapt.screenW() - Adapt.px(60)) / 2;

    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: Adapt.px(30)),
        width: w,
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'people${data.id}${data.job ?? ''}',
              child: Container(
                width: Adapt.px(100),
                height: Adapt.px(100),
                decoration: BoxDecoration(
                  color: _theme.primaryColorDark,
                  borderRadius: BorderRadius.circular(Adapt.px(50)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      ImageUrl.getUrl(data.profilePath, ImageSize.w300),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: Adapt.px(20),
            ),
            Container(
              width: w - Adapt.px(120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Adapt.px(24)),
                  ),
                  SizedBox(
                    height: Adapt.px(5),
                  ),
                  Text(
                    data.job,
                    style: TextStyle(color: Colors.grey[700]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _GuestCell extends StatelessWidget {
  final Function onTap;
  final CastData data;
  const _GuestCell({this.onTap, this.data});
  @override
  Widget build(BuildContext context) {
    final double w = (Adapt.screenW() - Adapt.px(60)) / 2;
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.only(bottom: Adapt.px(30)),
        width: w,
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'people${data.id}${data.character ?? ''}',
              child: Container(
                width: Adapt.px(100),
                height: Adapt.px(100),
                decoration: BoxDecoration(
                  color: _theme.primaryColorDark,
                  borderRadius: BorderRadius.circular(Adapt.px(50)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      data.profilePath == null
                          ? ImageUrl.emptyimage
                          : ImageUrl.getUrl(data.profilePath, ImageSize.w300),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: Adapt.px(20)),
            Container(
              width: w - Adapt.px(120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: Adapt.px(24)),
                  ),
                  SizedBox(
                    height: Adapt.px(5),
                  ),
                  Text(
                    data.character,
                    style: TextStyle(color: Colors.grey[700]),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _CrewGroup extends StatelessWidget {
  final String title;
  final List<CrewData> data;
  final Dispatch dispatch;
  const _CrewGroup({this.title, this.data, this.dispatch});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(title,
            style:
                TextStyle(fontSize: Adapt.px(28), fontWeight: FontWeight.bold)),
        SizedBox(
          height: Adapt.px(30),
        ),
        Wrap(
          children: data
              .map(
                (d) => _CrewCell(
                  data: d,
                  onTap: () => dispatch(
                    CreditsActionCreator.onCastTapped(
                        d.id, d.profilePath, d.name, d.job),
                  ),
                ),
              )
              .toList(),
        )
      ],
    );
  }
}

class _GuestStarShimmerCell extends StatelessWidget {
  final double w = (Adapt.screenW() - Adapt.px(60)) / 2;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: Adapt.px(30)),
      width: w,
      child: Row(
        children: <Widget>[
          Container(
            width: Adapt.px(100),
            height: Adapt.px(100),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(Adapt.px(50)),
            ),
          ),
          SizedBox(
            width: Adapt.px(20),
          ),
          Container(
            width: w - Adapt.px(120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: Adapt.px(150),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  width: Adapt.px(150),
                  height: Adapt.px(24),
                  color: Colors.grey[200],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _GuestStarsBody extends StatelessWidget {
  final List<CastData> guestStars;
  final Dispatch dispatch;
  const _GuestStarsBody({this.guestStars, this.dispatch});
  @override
  Widget build(BuildContext context) {
    if (guestStars != null) {
      if (guestStars.length > 0)
        return Wrap(
          children: guestStars
              .map((d) => _GuestCell(
                    data: d,
                    onTap: () => dispatch(CreditsActionCreator.onCastTapped(
                        d.id, d.profilePath, d.name, d.character)),
                  ))
              .toList(),
        );
      else
        return Container(
          padding: EdgeInsets.only(bottom: Adapt.px(30)),
          width: Adapt.screenW() - Adapt.px(60),
          child: Text(I18n.of(context).guestStarsEmpty),
        );
    } else
      return _GuestListShimmer();
  }
}

class _GuestListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Wrap(
          children: <Widget>[
            _GuestStarShimmerCell(),
            _GuestStarShimmerCell(),
            _GuestStarShimmerCell(),
            _GuestStarShimmerCell()
          ],
        ));
  }
}

class _CrewBody extends StatelessWidget {
  final List<CrewData> data;
  final Dispatch dispatch;
  const _CrewBody({this.data, this.dispatch});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    if (data != null) {
      if (data.length > 0) {
        var q = groupBy(data, (CrewData s) => s.department);
        var keys = q.keys.toList()..sort();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: keys.map((s) {
            return _CrewGroup(
              title: s,
              data: q[s],
              dispatch: dispatch,
            );
          }).toList(),
        );
      } else
        return Container(
          padding: EdgeInsets.only(bottom: Adapt.px(30)),
          width: Adapt.screenW() - Adapt.px(60),
          child: Text(I18n.of(context).crewEmpty),
        );
    } else
      return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: Adapt.px(28),
              width: Adapt.px(150),
              color: Colors.grey[200],
            ),
            SizedBox(
              height: Adapt.px(30),
            ),
            Wrap(
              children: <Widget>[
                _GuestStarShimmerCell(),
                _GuestStarShimmerCell(),
                _GuestStarShimmerCell(),
              ],
            )
          ],
        ),
      );
  }
}
