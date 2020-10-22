import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/video_panel.dart';

import 'state.dart';

Widget buildView(
    PlayerState state, Dispatch dispatch, ViewService viewService) {
  return SliverToBoxAdapter(
    child: AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Adapt.px(30)),
        child: PlayerPanel(
          loading: state.loading,
          background: state.background,
          streamLink: state.streamLink,
          playerType: state.playerType,
          linkId: state.streamLinkId,
          streamInBrowser: state.streamInBrowser,
          useVideoSourceApi: state.useVideoSourceApi,
          needAd: state.user.isPremium ? false : state.needAd,
        ),
      ),
    ),
  );
}
