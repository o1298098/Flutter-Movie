import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    MyListsPageState state, Dispatch dispatch, ViewService viewService) {
  final _adapter = viewService.buildAdapter();

  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    Widget _buildListShimmerCell() {
      return Container(
        margin: EdgeInsets.only(
            top: Adapt.px(20), left: Adapt.px(20), right: Adapt.px(20)),
        child: ShimmerCell(
          Adapt.screenW(),
          Adapt.px(400),
          Adapt.px(30),
          baseColor: _theme.primaryColorDark,
          highlightColor: _theme.primaryColorLight,
        ),
      );
    }

    Widget _buildList() {
      return state.listData == null
          ? SliverToBoxAdapter(
              child: Column(children: <Widget>[
              _buildListShimmerCell(),
              _buildListShimmerCell(),
              _buildListShimmerCell()
            ]))
          : SliverList(
              delegate:
                  SliverChildBuilderDelegate((BuildContext ctx, int index) {
                return _adapter.itemBuilder(ctx, index);
              }, childCount: _adapter.itemCount),
            );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: _theme.backgroundColor,
          title: Text(
            'My Lists',
            style: _theme.textTheme.body1,
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
            _buildList(),
          ],
        ));
  });
}
