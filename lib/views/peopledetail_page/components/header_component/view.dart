import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/peopledetail_page/components/header_component/components/cast_list.dart';
import 'package:movie/widgets/expandable_text.dart';
import 'package:shimmer/shimmer.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: Container(
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
                        spreadRadius: -15.0,
                        offset: Offset(0, 25),
                        color: Colors.black38),
                  ],
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(Adapt.px(50)),
                  ),
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
          _NamePanel(
            id: state.peopleid,
            name: state.profileName,
            birthday: state.birthday,
            deathday: state.deathday,
            profilePath: state.profilePath,
          ),
          SizedBox(height: Adapt.px(50)),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            child: Text(
              I18n.of(viewService.context).biography,
              softWrap: true,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
            ),
          ),
          SizedBox(height: Adapt.px(30)),
          _BiographyCell(
            biography: state.biography,
            profileName: state.profileName,
          ),
          SizedBox(height: Adapt.px(50))
        ],
      ),
    ),
  );
}

class _BiographyShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    final Color _baseColor = Colors.grey[200];
    return Shimmer.fromColors(
      baseColor: _theme.primaryColorDark,
      highlightColor: _theme.primaryColorLight,
      child: Container(
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: Adapt.px(60)),
              color: _baseColor,
              height: Adapt.px(30),
            ),
            SizedBox(height: Adapt.px(10)),
            Container(
              color: _baseColor,
              height: Adapt.px(30),
            ),
            SizedBox(height: Adapt.px(10)),
            Container(
              color: _baseColor,
              height: Adapt.px(30),
            ),
            SizedBox(height: Adapt.px(10)),
            Container(
              color: _baseColor,
              height: Adapt.px(30),
            ),
            SizedBox(height: Adapt.px(10)),
            Container(
              color: _baseColor,
              height: Adapt.px(30),
            ),
            SizedBox(height: Adapt.px(10)),
            Container(
              color: _baseColor,
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
    final _theme = ThemeStyle.getTheme(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
      child: biography == null
          ? _BiographyShimmer()
          : ExpandableText(
              biography == null || biography?.isEmpty == true
                  ? "We don't have a biography for $profileName"
                  : biography,
              maxLines: 5,
              style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: _theme.textTheme.bodyText1.color),
            ),
    );
  }
}

class _NameCell extends StatelessWidget {
  final String profileName;
  const _NameCell({this.profileName});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    final Size _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width - 120,
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
          : Text(
              profileName ?? '',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
            ),
    );
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
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ));
    } else
      return SizedBox(
        height: Adapt.px(35),
      );
  }
}

class _NamePanel extends StatelessWidget {
  final int id;
  final String profilePath;
  final String name;
  final String birthday;
  final String deathday;
  const _NamePanel(
      {this.id, this.name, this.birthday, this.deathday, this.profilePath});
  @override
  Widget build(BuildContext context) {
    void _showCsatList() {
      showDialog(
          context: context,
          builder: (_) => CastList(
              cast: BaseCast.fromParams(
                  name: name, castId: id, profileUrl: profilePath)));
    }

    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _NameCell(
              profileName: name,
            ),
            _YearsOld(
              birthday: birthday,
              deathday: deathday,
            ),
          ],
        ),
        Spacer(),
        GestureDetector(
          onTap: _showCsatList,
          child: Icon(
            Icons.add_circle_outline,
            size: 20,
          ),
        ),
        SizedBox(width: 15),
        GestureDetector(
            onTap: () async {
              await Navigator.of(context).pushNamed("castListPage");
            },
            child: Icon(
              Icons.favorite_border,
              size: 20,
            )),
        SizedBox(width: Adapt.px(40))
      ],
    );
  }
}
