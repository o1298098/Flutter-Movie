import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DataPanelState state, Dispatch dispatch, ViewService viewService) {
  return _SecondPanel(
    state: state,
    openDownloadManager: () =>
        dispatch(DataPanelActionCreator.openDownloadManager()),
  );
}

class _SecondPanel extends StatelessWidget {
  final Function onTap;
  final Function openDownloadManager;
  final DataPanelState state;
  const _SecondPanel({this.state, this.onTap, this.openDownloadManager});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(bottom: 25),
        height: Adapt.px(220),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: const Color(0xFF5568E8),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage('images/account_bar_background.png')),
        ),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _DataItem(
                onTap: openDownloadManager,
                title: 'Download',
                value: '${state.downloadTask?.length ?? 0}',
              ),
              _DataItem(
                onTap: () async =>
                    Navigator.of(context).pushNamed('premiumPage'),
                title: 'What',
                value: '80',
              ),
              _DataItem(
                onTap: () async => Navigator.of(context).pushNamed('testPage'),
                title: 'Here?',
                value: '100',
              ),
              Icon(
                Icons.keyboard_arrow_right,
                color: const Color(0xFFFFFFFF),
                size: 30,
              )
            ]),
      ),
    );
  }
}

class _DataItem extends StatelessWidget {
  final String title;
  final String value;
  final Function onTap;
  const _DataItem({this.onTap, this.title, this.value});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(value,
              style: TextStyle(
                color: const Color(0xFFFFFFFF),
                fontWeight: FontWeight.bold,
                fontSize: Adapt.px(22),
              )),
          SizedBox(height: 5),
          Text(title,
              style: TextStyle(
                  color: const Color(0xFFFFFFFF), fontSize: Adapt.px(24)))
        ],
      ),
    );
  }
}
