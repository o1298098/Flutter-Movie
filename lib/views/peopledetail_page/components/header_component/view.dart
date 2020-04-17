import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../style/themestyle.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  void _bioReadMore() async {
    if (state.biography == null || state.biography.isEmpty) return;
    await showGeneralDialog(
        context: viewService.context,
        barrierLabel: 'bio',
        barrierColor: Colors.black45,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secAnimation) {
          return Center(
            child: Material(
              color: _theme.backgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Adapt.px(20))),
              child: Container(
                padding: EdgeInsets.all(Adapt.px(30)),
                width: Adapt.screenW() - Adapt.px(60),
                height: Adapt.screenH() - Adapt.px(400),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Text(
                      state?.biography == null ||
                              state?.biography?.isEmpty == true
                          ? "We don't have a biography for ${state.profileName}"
                          : state.biography,
                      style: TextStyle(
                          fontSize: Adapt.px(30),
                          height: 1.2,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  return Container(
      key: ValueKey('header'),
      width: Adapt.screenW(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: 'people${state.peopleid}',
            child: Material(
              child: Container(
                height: Adapt.px(900),
                decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        blurRadius: 20,
                        offset: Offset(0, 5),
                        color: Colors.black38),
                  ],
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(Adapt.px(50)),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(state.profilePath, ImageSize.w300)),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: Adapt.px(50)),
          _NameCell(
            peopleid: state.peopleid,
            profileName: state.profileName,
          ),
          _YearsOld(
            birthday: state.birthday,
            deathday: state.deathday,
          ),
          SizedBox(height: Adapt.px(50)),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    I18n.of(viewService.context).biography,
                    softWrap: true,
                    style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: Adapt.px(40)),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  InkWell(
                      onTap: () => _bioReadMore(),
                      child: Text(
                        'Read more',
                        style: TextStyle(color: Colors.grey[500]),
                      ))
                ],
              )),
          SizedBox(height: Adapt.px(30)),
          _BiographyCell(
            biography: state.biography,
            profileName: state.profileName,
          ),
          SizedBox(height: Adapt.px(50))
        ],
      ));
}

class _NameCell extends StatelessWidget {
  final String profileName;
  final int peopleid;
  const _NameCell({this.peopleid, this.profileName});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      child: profileName == null
          ? SizedBox(
              child: Shimmer.fromColors(
                baseColor: _theme.primaryColorDark,
                highlightColor: _theme.primaryColorLight,
                child: Container(
                  height: Adapt.px(50),
                  width: Adapt.px(300),
                  color: Colors.grey[200],
                ),
              ),
            )
          : Hero(
              tag: 'Actor' + peopleid.toString(),
              child: Material(
                color: Colors.transparent,
                child: Text(
                  profileName ?? '',
                  style: TextStyle(
                      fontSize: Adapt.px(50), fontWeight: FontWeight.w700),
                ),
              ),
            ),
    );
  }
}

class _BiographyShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: Adapt.px(60)),
              color: Colors.grey[200],
              height: Adapt.px(30),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: Colors.grey[200],
              height: Adapt.px(30),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: Colors.grey[200],
              height: Adapt.px(30),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: Colors.grey[200],
              height: Adapt.px(30),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: Colors.grey[200],
              height: Adapt.px(30),
            ),
            SizedBox(
              height: Adapt.px(10),
            ),
            Container(
              color: Colors.grey[200],
              height: Adapt.px(30),
            ),
          ],
        ),
      ),
    );
  }
}

class _BiographyCell extends StatelessWidget {
  final String biography;
  final String profileName;
  const _BiographyCell({this.biography, this.profileName});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
        child: biography == null
            ? _BiographyShimmer()
            : Text(
                biography == null || biography?.isEmpty == true
                    ? "We don't have a biography for $profileName"
                    : biography,
                maxLines: 10,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: Adapt.px(30)),
              ));
  }
}

class _YearsOld extends StatelessWidget {
  final String birthday;
  final String deathday;
  const _YearsOld({this.birthday, this.deathday});
  @override
  Widget build(BuildContext context) {
    if (birthday != null) {
      final _now = deathday != null
          ? DateTime.parse(deathday).year
          : DateTime.now().year;

      int yearold = _now - DateTime.parse(birthday).year;
      return Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          child: Text(
            '$yearold years old',
            style: TextStyle(color: Colors.grey[600], fontSize: Adapt.px(32)),
          ));
    } else
      return SizedBox(
        height: Adapt.px(35),
      );
  }
}
