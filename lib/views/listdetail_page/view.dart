import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'state.dart';

Widget buildView(
    ListDetailPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(builder: (context) {
    return Scaffold(
      body: CustomScrollView(
        controller: state.scrollController,
        slivers: <Widget>[
          SliverAppBar(
            backgroundColor: Color.fromRGBO(50, 50, 50, 1),
            pinned: true,
            title: Text(
              state?.listDetailModel?.listName ?? '',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            expandedHeight: Adapt.px(550),
            flexibleSpace: viewService.buildComponent('header'),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Adapt.px(100)),
              child: viewService.buildComponent('infoGroup'),
            ),
          ),
          viewService.buildComponent('body'),
          const SliverToBoxAdapter(
            child: const SizedBox(height: 20),
          )
        ],
      ),
    );
  });
}
