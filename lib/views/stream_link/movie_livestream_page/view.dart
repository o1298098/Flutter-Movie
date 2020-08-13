import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'state.dart';

Widget buildView(
    MovieLiveStreamState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);

      return Scaffold(
        backgroundColor: _theme.backgroundColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
                child: CustomScrollView(
                  controller: state.scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                        child:
                            SizedBox(height: Adapt.px(30) + Adapt.padTopH())),
                    viewService.buildComponent('player'),
                    viewService.buildComponent('header'),
                    const _RecommendationTitle(),
                    viewService.buildComponent('recommendation'),
                    const SliverToBoxAdapter(
                        child: const SizedBox(height: 100)),
                  ],
                ),
              ),
              Container(
                color: _theme.backgroundColor,
                height: Adapt.padTopH(),
              ),
              viewService.buildComponent('bottomPanel'),
            ],
          ),
        ),
      );
    },
  );
}

class _RecommendationTitle extends StatelessWidget {
  const _RecommendationTitle();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsetsDirectional.only(top: Adapt.px(40), bottom: Adapt.px(30)),
        child: Text(
          'Recommendations',
          style: TextStyle(
            fontSize: Adapt.px(30),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
