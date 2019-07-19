import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/creditsmodel.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/views/episodedetail_page/components/credits_component/action.dart';
import 'package:shimmer/shimmer.dart';
import "package:collection/collection.dart";

import 'state.dart';

Widget buildView(
    CreditsState state, Dispatch dispatch, ViewService viewService) {
  Random random = new Random(DateTime.now().millisecondsSinceEpoch);

  Widget _buildGuestCell(CastData d) {
    double w = (Adapt.screenW() - Adapt.px(60)) / 2;
    return GestureDetector(
      onTap: () => dispatch(
          CreditsActionCreator.onCastTapped(d.id, d.profile_path, d.name,d.character)),
      child: Container(
        padding: EdgeInsets.only(bottom: Adapt.px(30)),
        width: w,
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'people${d.id}${d.character??''}',
              child: Container(
                width: Adapt.px(100),
                height: Adapt.px(100),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextDouble()),
                    borderRadius: BorderRadius.circular(Adapt.px(50)),
                    image: DecorationImage(
                      //alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(d.profile_path == null
                          ? ImageUrl.emptyimage
                          : ImageUrl.getUrl(d.profile_path, ImageSize.w300)),
                    )),
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
                    d.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Adapt.px(24)),
                  ),
                  SizedBox(
                    height: Adapt.px(5),
                  ),
                  Text(
                    d.character,
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

  Widget _buildGuestStarShimmerCell() {
    double w = (Adapt.screenW() - Adapt.px(60)) / 2;
    return Container(
        padding: EdgeInsets.only(bottom: Adapt.px(30)),
        width: w,
        child: Shimmer.fromColors(
          baseColor: Color.fromRGBO(random.nextInt(255), random.nextInt(255),
              random.nextInt(255), random.nextDouble()),
          highlightColor: Colors.grey[100],
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
        ));
  }

  Widget _buildCrewCell(CrewData d) {
    double w = (Adapt.screenW() - Adapt.px(60)) / 2;
    return GestureDetector(
      onTap: () => dispatch(
          CreditsActionCreator.onCastTapped(d.id, d.profile_path, d.name,d.job)),
      child: Container(
        padding: EdgeInsets.only(bottom: Adapt.px(30)),
        width: w,
        child: Row(
          children: <Widget>[
            Hero(
              tag: 'people${d.id}${d.job??''}',
              child: Container(
                width: Adapt.px(100),
                height: Adapt.px(100),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextInt(255),
                        random.nextDouble()),
                    borderRadius: BorderRadius.circular(Adapt.px(50)),
                    image: DecorationImage(
                      //alignment: Alignment.topCenter,
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(d.profile_path == null
                          ? ImageUrl.emptyimage
                          : ImageUrl.getUrl(d.profile_path, ImageSize.w300)),
                    )),
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
                    d.name,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Adapt.px(24)),
                  ),
                  SizedBox(
                    height: Adapt.px(5),
                  ),
                  Text(
                    d.job,
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

  Widget _buildCrewGroup(String s, List<CrewData> d) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(s,
            style: TextStyle(
                color: Colors.black,
                fontSize: Adapt.px(28),
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: Adapt.px(30),
        ),
        Wrap(
          children: d.map(_buildCrewCell).toList(),
        )
      ],
    );
  }

  Widget _getGuestStarsBody() {
    if (state.guestStars != null) {
      if (state.guestStars.length > 0)
        return Wrap(
          children: state.guestStars.map(_buildGuestCell).toList(),
        );
      else
        return Container(
          padding: EdgeInsets.only(bottom: Adapt.px(30)),
          width: Adapt.screenW() - Adapt.px(60),
          child: Text(I18n.of(viewService.context).guestStarsEmpty),
        );
    } else
      return Wrap(
        children: <Widget>[
          _buildGuestStarShimmerCell(),
          _buildGuestStarShimmerCell(),
          _buildGuestStarShimmerCell(),
          _buildGuestStarShimmerCell()
        ],
      );
  }

  Widget _getCrewBody() {
    List<CrewData> d = state.crew;
    if (state.crew != null) {
      if (state.crew.length > 0) {
        var q = groupBy(d, (CrewData s) => s.department);
        var keys = q.keys.toList()..sort();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: keys.map((s) {
            return _buildCrewGroup(s, q[s]);
          }).toList(),
        );
      } else
        return Container(
          padding: EdgeInsets.only(bottom: Adapt.px(30)),
          width: Adapt.screenW() - Adapt.px(60),
          child: Text(I18n.of(viewService.context).crewEmpty),
        );
    } else
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Shimmer.fromColors(
            baseColor: Colors.grey[200],
            highlightColor: Colors.grey[100],
            child: Container(
              height: Adapt.px(28),
              width: Adapt.px(150),
              color: Colors.grey[200],
            ),
          ),
          SizedBox(
            height: Adapt.px(30),
          ),
          Wrap(
            children: <Widget>[
              _buildGuestStarShimmerCell(),
              _buildGuestStarShimmerCell(),
              _buildGuestStarShimmerCell(),
            ],
          )
        ],
      );
  }

  return
  Container(
    padding: EdgeInsets.fromLTRB(Adapt.px(28), 0, Adapt.px(28), 0),
    child: 
   Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Text.rich(TextSpan(children: [
        TextSpan(
            text: I18n.of(viewService.context).guestStars,
            style: TextStyle(
                color: Colors.black,
                fontSize: Adapt.px(35),
                fontWeight: FontWeight.bold)),
        TextSpan(
            text:
                ' ${state.guestStars != null ? state.guestStars.length.toString() : ''}',
            style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)))
      ])),
      SizedBox(
        height: Adapt.px(30),
      ),
      _getGuestStarsBody(),
      Text.rich(TextSpan(children: [
        TextSpan(
            text: I18n.of(viewService.context).crew,
            style: TextStyle(
                color: Colors.black,
                fontSize: Adapt.px(35),
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: ' ${state.crew != null ? state.crew.length.toString() : ''}',
            style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26)))
      ])),
      SizedBox(
        height: Adapt.px(30),
      ),
      _getCrewBody(),

    ],
  ),
  );
}
