import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/models.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    StreamLinkFilterState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(),
    body: ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      separatorBuilder: (_, __) => SizedBox(height: 20),
      itemBuilder: (_, index) {
        final _d = state.streamLinks.list[index];
        return _LinkCell(
          link: _d,
          onTap: (link) =>
              dispatch(StreamLinkFilterActionCreator.streamlinkTap(link)),
        );
      },
      itemCount: state.streamLinks?.list?.length ?? 0,
    ),
  );
}

class _LinkCell extends StatelessWidget {
  final MovieStreamLink link;
  final Function(MovieStreamLink) onTap;
  const _LinkCell({this.link, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(link),
      child: Container(
        decoration: BoxDecoration(),
        child: Text(link.linkName),
      ),
    );
  }
}
