import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MyListsPageState state, Dispatch dispatch, ViewService viewService) {
  final _adapter = viewService.buildAdapter();

  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: _theme.backgroundColor,
          title: Text(
            'My Lists',
            style: _theme.textTheme.bodyText1,
          ),
          brightness: _theme.brightness,
          iconTheme: _theme.iconTheme,
          actions: <Widget>[
            IconButton(
              icon: AnimatedSwitcher(
                child: state.isEdit
                    ? Icon(
                        Icons.check,
                        key: ValueKey(state.isEdit),
                      )
                    : Icon(Icons.edit, key: ValueKey(state.isEdit)),
                duration: Duration(milliseconds: 200),
              ),
              onPressed: () async {
                await state.scrollController.position.animateTo(0.0,
                    curve: Curves.ease, duration: Duration(milliseconds: 200));
                final r = !state.isEdit;
                if (r) {
                  await state.animationController.forward(from: 0.0);
                  state.cellAnimationController.repeat();
                  dispatch(MyListsPageActionCreator.onEdit(r));
                } else {
                  await state.animationController.reverse(from: 1.0);
                  state.cellAnimationController.reset();
                  dispatch(MyListsPageActionCreator.onEdit(r));
                }
              },
            ),
          ],
        ),
        body: CustomScrollView(
          controller: state.scrollController,
          slivers: <Widget>[
            viewService.buildComponent('addCell'),
            state.listData == null
                ? _ShimmerList()
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext ctx, int index) {
                      return _adapter.itemBuilder(ctx, index);
                    }, childCount: _adapter.itemCount),
                  ),
          ],
        ));
  });
}

class _ListShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
      width: Adapt.screenW(),
      height: Adapt.px(400),
      decoration: BoxDecoration(
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(Adapt.px(30))),
    );
  }
}

class _ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
        child: Shimmer.fromColors(
            baseColor: _theme.primaryColorDark,
            highlightColor: _theme.primaryColorLight,
            child: Column(children: <Widget>[
              _ListShimmerCell(),
              _ListShimmerCell(),
              _ListShimmerCell()
            ])));
  }
}
