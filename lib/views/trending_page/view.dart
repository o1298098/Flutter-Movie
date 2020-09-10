import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TrendingPageState state, Dispatch dispatch, ViewService viewService) {
  final _adapter = viewService.buildAdapter();
  return Builder(
    builder: (context) {
      final ThemeData _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        appBar: AppBar(
          brightness: _theme.brightness,
          backgroundColor: _theme.backgroundColor,
          elevation: 0.0,
          iconTheme: _theme.iconTheme,
          title:
              Text('Trending', style: TextStyle(color: _theme.iconTheme.color)),
          actions: <Widget>[
            IconButton(
              alignment: Alignment.centerLeft,
              icon: AnimatedIcon(
                progress: Tween<double>(begin: 0.0, end: 1.0)
                    .animate(state.animationController),
                icon: AnimatedIcons.menu_close,
              ),
              onPressed: () => dispatch(TrendingPageActionCreator.showFilter()),
            ),
          ],
        ),
        body: CustomScrollView(
          key: ValueKey(state.trending),
          physics: BouncingScrollPhysics(),
          controller: state.controller,
          slivers: <Widget>[
            viewService.buildComponent('filter'),
            _Refreshing(refreshController: state.refreshController),
            SliverToBoxAdapter(
              child: SizedBox(height: Adapt.px(30)),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((ctx, index) {
                return _adapter.itemBuilder(ctx, index);
              }, childCount: _adapter.itemCount),
            ),
            _Loading(),
          ],
        ),
      );
    },
  );
}

class _Refreshing extends StatelessWidget {
  final AnimationController refreshController;
  const _Refreshing({this.refreshController});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: FadeTransition(
        opacity: Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
          parent: refreshController,
          curve: Curves.ease,
        )),
        child: SizedBox(
          height: Adapt.px(5),
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF505050)),
          ),
        ),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.only(bottom: Adapt.px(30)),
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(_theme.iconTheme.color),
        ),
      ),
    );
  }
}
