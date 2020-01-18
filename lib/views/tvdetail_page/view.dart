import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TVDetailPageState state, Dispatch dispatch, ViewService viewService) {
  final s = state.tvDetailModel;
  //var dominantColor = state.palette?.dominantColor?.color ?? Colors.black38;
  final dominantColor = state.mainColor;

  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return Scaffold(
        key: state.scaffoldkey,
        body: DefaultTabController(
            length: 4,
            child: NestedScrollView(
                headerSliverBuilder: (BuildContext context, bool de) {
                  return <Widget>[
                    SliverOverlapAbsorber(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                      sliver: SliverAppBar(
                          pinned: true,
                          backgroundColor: dominantColor,
                          expandedHeight: Adapt.px(700),
                          centerTitle: false,
                          title: Text(de ? s.name ?? '' : ''),
                          actions: <Widget>[
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              color: Colors.white,
                              iconSize: Adapt.px(50),
                              onPressed: () => dispatch(
                                  TVDetailPageActionCreator.openMenu()),
                            )
                          ],
                          bottom: PreferredSize(
                            preferredSize:
                                new Size(double.infinity, Adapt.px(60)),
                            child: Container(
                                width: Adapt.screenW(),
                                color: _theme.backgroundColor,
                                child: TabBar(
                                  labelColor: _theme.tabBarTheme.labelColor,
                                  indicatorColor: state.tabTintColor,
                                  indicatorSize: TabBarIndicatorSize.label,
                                  isScrollable: true,
                                  labelStyle: TextStyle(
                                      fontSize: Adapt.px(35),
                                      fontWeight: FontWeight.w600),
                                  tabs: <Widget>[
                                    Tab(
                                        text:
                                            I18n.of(viewService.context).main),
                                    Tab(
                                        text: I18n.of(viewService.context)
                                            .videos),
                                    Tab(
                                        text: I18n.of(viewService.context)
                                            .images),
                                    Tab(
                                        text: I18n.of(viewService.context)
                                            .reviews),
                                  ],
                                )),
                          ),
                          flexibleSpace: FlexibleSpaceBar(
                            centerTitle: false,
                            background: viewService.buildComponent('header'),
                          )),
                    )
                  ];
                },
                body: TabBarView(
                  children: <Widget>[
                    Container(child: Builder(builder: (BuildContext context) {
                      return CustomScrollView(slivers: <Widget>[
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        viewService.buildComponent('tvInfo'),
                        viewService.buildComponent('currentSeason'),
                        viewService.buildComponent('keywords'),
                        viewService.buildComponent('recommendations'),
                        viewService.buildComponent('info'),
                      ]);
                    })),
                    viewService.buildComponent('videos'),
                    viewService.buildComponent('images'),
                    viewService.buildComponent('reviews'),
                  ],
                ))));
  });
}
