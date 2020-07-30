import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    SeasonDetailPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Stack(
      children: [
        Scaffold(
            appBar: AppBar(
              brightness: _theme.brightness,
              iconTheme: _theme.iconTheme,
              backgroundColor: _theme.backgroundColor,
              elevation: 0.0,
              centerTitle: false,
              title: Text(
                state.tvShowName ?? '',
                style: _theme.textTheme.bodyText1,
              ),
            ),
            backgroundColor: _theme.backgroundColor,
            body: CustomScrollView(
              slivers: [
                viewService.buildComponent('header'),
                viewService.buildComponent('seasonCast'),
                _EpisodesTitle(
                  title:
                      ' ${state.seasonDetailModel?.episodes != null ? state.seasonDetailModel?.episodes?.length?.toString() : ''}',
                ),
                viewService.buildComponent('episode'),
              ],
            )),
      ],
    );
  });
}

class _EpisodesTitle extends StatelessWidget {
  final String title;
  const _EpisodesTitle({this.title});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Adapt.px(40), vertical: Adapt.px(30)),
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                  text: I18n.of(context).episodes,
                  style: TextStyle(
                      fontSize: Adapt.px(30), fontWeight: FontWeight.w600)),
              TextSpan(
                  text: title,
                  style: TextStyle(
                      color: const Color(0xFF9E9E9E), fontSize: Adapt.px(26)))
            ],
          ),
        ),
      ),
    );
  }
}
