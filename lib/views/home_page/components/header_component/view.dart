import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/videolist.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/home_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);

  Widget _buildHeaderBody() {
    var _model = state.showHeaderMovie ? state.movie : state.tv;
    return Container(
      height: Adapt.px(400),
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 600),
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: _model.results.length > 0
            ? ListView.separated(
                key: ValueKey(_model),
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => SizedBox(width: Adapt.px(30)),
                itemCount: _model.results.length,
                itemBuilder: (_, index) {
                  final _d = _model.results[index];
                  return _HeaderListCell(
                      data: _model.results[index],
                      onTap: () => dispatch(HomePageActionCreator.onCellTapped(
                          _d.id,
                          _d.backdropPath,
                          _d.title ?? _d.name,
                          _d.posterPath,
                          state.showHeaderMovie
                              ? MediaType.movie
                              : MediaType.tv)));
                })
            : _ShimmerHeaderList(),
      ),
    );
  }

  return Container(
    color: _theme.bottomAppBarColor,
    child: Column(
      children: <Widget>[
        SizedBox(
          height: Adapt.px(30),
        ),
        _TabTitel(
          isMovie: state.showHeaderMovie,
          onTap: () => dispatch(HeaderActionCreator.onHeaderFilterChanged(
              !state.showHeaderMovie)),
        ),
        SizedBox(
          height: Adapt.px(45),
        ),
        _buildHeaderBody()
      ],
    ),
  );
}

class _TabTitel extends StatelessWidget {
  final bool isMovie;
  final Function onTap;
  _TabTitel({this.isMovie, this.onTap});
  final _selectTextStyle = TextStyle(
      color: const Color(0xFFFFFFFF),
      fontSize: Adapt.px(40),
      fontWeight: FontWeight.bold);
  final _unselectTextStyle =
      TextStyle(color: const Color(0xFF9E9E9E), fontSize: Adapt.px(40));
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            InkWell(
              onTap: onTap,
              child: Text(I18n.of(context).inTheaters,
                  style: isMovie ? _selectTextStyle : _unselectTextStyle),
            ),
            SizedBox(
              width: Adapt.px(30),
            ),
            InkWell(
              onTap: onTap,
              child: Text(
                I18n.of(context).onTV,
                style: isMovie ? _unselectTextStyle : _selectTextStyle,
              ),
            )
          ],
        ));
  }
}

class _ShimmerHeaderCell extends StatelessWidget {
  final Color _baseColor = Color.fromRGBO(57, 57, 57, 1);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: Adapt.px(200),
          height: Adapt.px(280),
          color: _baseColor,
        ),
        SizedBox(
          height: Adapt.px(20),
        ),
        Container(
          width: Adapt.px(200),
          height: Adapt.px(20),
          color: _baseColor,
        ),
        SizedBox(
          height: Adapt.px(8),
        ),
        Container(
          width: Adapt.px(150),
          height: Adapt.px(20),
          color: _baseColor,
        ),
      ],
    );
  }
}

class _ShimmerHeaderList extends StatelessWidget {
  final Color _baseColor = Color.fromRGBO(57, 57, 57, 1);
  final Color _highLightColor = Color.fromRGBO(67, 67, 67, 1);
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: _baseColor,
        highlightColor: _highLightColor,
        child: ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 4,
          itemBuilder: (context, index) => _ShimmerHeaderCell(),
          separatorBuilder: (context, index) => SizedBox(width: Adapt.px(30)),
        ));
  }
}

class _HeaderListCell extends StatelessWidget {
  final VideoListResult data;
  final Function onTap;
  const _HeaderListCell({@required this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    String name = data.title ?? data.name;
    return Column(
      key: ValueKey('headercell' + data.id.toString()),
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: Adapt.px(200),
            height: Adapt.px(280),
            decoration: BoxDecoration(
                color: Color.fromRGBO(57, 57, 57, 1),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        ImageUrl.getUrl(data.posterPath, ImageSize.w300)))),
          ),
        ),
        SizedBox(
          height: Adapt.px(20),
        ),
        Container(
          alignment: Alignment.center,
          width: Adapt.px(200),
          height: Adapt.px(70),
          child: Text(name,
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: Adapt.px(26))),
        ),
      ],
    );
  }
}
