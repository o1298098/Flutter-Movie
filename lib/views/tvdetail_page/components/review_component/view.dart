import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:url_launcher/url_launcher.dart';

import 'state.dart';

Widget buildView(
    ReviewState state, Dispatch dispatch, ViewService viewService) {
  return Container(child: Builder(builder: (BuildContext context) {
    return CustomScrollView(slivers: <Widget>[
      SliverOverlapInjector(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      ),
      SliverList(
        delegate: SliverChildBuilderDelegate((BuildContext contxt, int index) {
          return GestureDetector(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  Adapt.px(30), 0, Adapt.px(30), Adapt.px(30)),
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(Adapt.px(30)),
                  height: 300,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'A Review by ${state.reviewResults[index].author}',
                        style: TextStyle(
                            fontSize: Adapt.px(30),
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: Adapt.px(20),
                      ),
                      new Expanded(
                        child: new LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints constraints) {
                          print(constraints);
                          return new Text(
                            state.reviewResults[index].content,
                            overflow: TextOverflow.fade,
                            maxLines: (constraints.maxHeight /
                                    Theme.of(context).textTheme.body1.fontSize)
                                .floor(),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onTap: () async {
              var url = state.reviewResults[index].url;
              if (await canLaunch(url)) {
                await launch(url);
              }
            },
          );
        }, childCount: state.reviewResults.length),
      ),
    ]);
  }));
}
