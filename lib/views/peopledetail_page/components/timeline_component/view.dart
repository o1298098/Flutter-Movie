import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/combinedcredits.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/peopledetail_page/action.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TimeLineState state, Dispatch dispatch, ViewService viewService) {
  final ThemeData _theme = ThemeStyle.getTheme(viewService.context);
  List<CastData> _movies;
  List<CastData> _tvshows;
  void initList() {
    var _model = state.creditsModel.cast ?? [];
    _movies = _model.where((d) => d.mediaType == 'movie').toList();
    _tvshows = _model.where((d) => d.mediaType == 'tv').toList();
  }

  Widget _buildTitle() {
    if (state.department == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: Container(
          height: Adapt.px(40),
          width: Adapt.px(150),
          color: Colors.grey[200],
        ),
      ));
    else
      return Text(
        state.department ?? '',
        softWrap: true,
        style: TextStyle(fontWeight: FontWeight.w500, fontSize: Adapt.px(40)),
      );
  }

  Widget _buildActingBody() {
    if (_movies == null || _tvshows == null) initList();
    var _data = state.showmovie ? _movies : _tvshows;
    return Card(
        //margin: EdgeInsets.all(Adapt.px(10)),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Adapt.px(30))),
        child: Container(
          padding: EdgeInsets.all(Adapt.px(30)),
          child: _data.length > 0
              ? ListView.separated(
                  physics: PageScrollPhysics(),
                  separatorBuilder: (_, __) => Divider(),
                  shrinkWrap: true,
                  itemCount: _data.length,
                  itemBuilder: (_, i) {
                    final d = _data[i];
                    return _Cell(
                      data: d,
                      onTap: () => dispatch(
                          PeopleDetailPageActionCreator.onCellTapped(
                              d.id,
                              d.backdropPath,
                              d.title ?? d.name,
                              d.posterPath,
                              d.mediaType == 'movie'
                                  ? MediaType.movie
                                  : MediaType.person)),
                    );
                  })
              : _ShimmerList(),
        ));
  }

  final _selectTextStyle = TextStyle(fontWeight: FontWeight.w500);
  final _unSelectTextStyle = TextStyle(color: Colors.grey);
  return Column(
      key: ValueKey('timeLine'),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.fromLTRB(
                Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _buildTitle(),
                Expanded(
                  child: Container(),
                ),
                GestureDetector(
                  onTap: () =>
                      dispatch(TimeLineActionCreator.onActingChanged(true)),
                  child: Text(I18n.of(viewService.context).movies,
                      style: state.showmovie
                          ? _selectTextStyle
                          : _unSelectTextStyle),
                ),
                SizedBox(
                  width: Adapt.px(20),
                ),
                GestureDetector(
                  onTap: () =>
                      dispatch(TimeLineActionCreator.onActingChanged(false)),
                  child: Text(I18n.of(viewService.context).tvShows,
                      style: state.showmovie
                          ? _unSelectTextStyle
                          : _selectTextStyle),
                )
              ],
            )),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
          child: _buildActingBody(),
        ),
      ]);
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: Adapt.px(24),
              width: Adapt.px(500),
              color: const Color(0xFFEEEEEE),
            ),
            SizedBox(
              height: Adapt.px(8),
            ),
            Container(
              height: Adapt.px(24),
              width: Adapt.px(150),
              color: const Color(0xFFEEEEEE),
            ),
          ],
        ),
      ],
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Shimmer.fromColors(
        baseColor: _theme.primaryColorDark,
        highlightColor: _theme.primaryColorLight,
        child: ListView.separated(
          physics: PageScrollPhysics(),
          separatorBuilder: (_, __) => Divider(),
          shrinkWrap: true,
          itemCount: 5,
          itemBuilder: (_, i) => _ShimmerCell(),
        ));
  }
}

class _Cell extends StatelessWidget {
  final CastData data;
  final Function onTap;
  const _Cell({@required this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final double _leftwidth = (Adapt.screenW() - Adapt.px(120)) * 0.8;
    String date =
        data.mediaType == 'movie' ? data.releaseDate : data.firstAirDate;
    date = date == null || date?.isEmpty == true
        ? '-'
        : DateTime.parse(date).year.toString();
    return GestureDetector(
        key: ValueKey('timelineCell${data.creditId}'),
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: _leftwidth,
                  child: Text(data.title ?? data.name,
                      style: TextStyle(fontWeight: FontWeight.w600)),
                ),
                SizedBox(
                    width: _leftwidth,
                    child: Text(
                        data?.character?.isEmpty == true ||
                                data.character == null
                            ? '-'
                            : data.character,
                        style: TextStyle(color: Colors.grey[400])))
              ],
            ),
            Text(date)
          ],
        ));
  }
}
