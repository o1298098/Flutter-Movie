import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/stream_link/movie_livestream_page/components/bottom_panel_component/components/download_menu.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';

import 'action.dart';
import 'components/option_menu.dart';
import 'components/video_source_menu.dart';
import 'state.dart';

Widget buildView(
    BottomPanelState state, Dispatch dispatch, ViewService viewService) {
  void _closeMenu(OverlayEntry overlayEntry) {
    overlayEntry?.remove();
    state.overlayStateKey.currentState.setOverlayEntry(null);
    overlayEntry = null;
  }

  void _showOptionMenu() {
    OverlayEntry menuOverlayEntry;
    menuOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
                child: GestureDetector(
              onTap: () => _closeMenu(menuOverlayEntry),
              child: Container(
                color: Colors.transparent,
              ),
            )),
            OptionMenu(
              useVideoSourceApi: state.useVideoSourceApi,
              streamInBrowser: state.streamInBrowser,
              host: state.preferHost,
              languageCode: state.defaultVideoLanguage,
              closeMenu: () => _closeMenu(menuOverlayEntry),
              reportTap: () {
                dispatch(BottomPanelActionCreator.reportStreamLink());
                _closeMenu(menuOverlayEntry);
              },
              streamLinkRequestTap: () {
                dispatch(BottomPanelActionCreator.requestStreamLink());
                _closeMenu(menuOverlayEntry);
              },
              onUseApiTap: (b) =>
                  dispatch(BottomPanelActionCreator.useVideoSource(b)),
              onStreamInBrowserTap: (b) =>
                  dispatch(BottomPanelActionCreator.streamInBrowser(b)),
              onHostSelected: (s) =>
                  dispatch(BottomPanelActionCreator.preferHostTap(s)),
              onLanguageSelected: (code) =>
                  dispatch(BottomPanelActionCreator.defaultLanguageTap(code)),
            ),
          ],
        );
      },
    );
    state.overlayStateKey.currentState.setOverlayEntry(menuOverlayEntry);
    Overlay.of(viewService.context).insert(menuOverlayEntry);
  }

  void _showSourceMenu() {
    OverlayEntry menuOverlayEntry;
    menuOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
                child: GestureDetector(
              onTap: () => _closeMenu(menuOverlayEntry),
              child: Container(
                color: Colors.transparent,
              ),
            )),
            VideoSourceMenu(
              onTap: (d) {
                _closeMenu(menuOverlayEntry);
                dispatch(BottomPanelActionCreator.seletedLink(d));
              },
              moreTap: () {
                _closeMenu(menuOverlayEntry);
                dispatch(BottomPanelActionCreator.showStreamLinkFilter());
              },
              streamLinkRequestTap: () {
                dispatch(BottomPanelActionCreator.requestStreamLink());
                _closeMenu(menuOverlayEntry);
              },
              selectedLinkId: state.selectedLink?.sid ?? 0,
              links: state.streamLinks?.list ?? [],
            ),
          ],
        );
      },
    );
    state.overlayStateKey.currentState.setOverlayEntry(menuOverlayEntry);
    Overlay.of(viewService.context).insert(menuOverlayEntry);
  }

  void _showDownloadMenu() {
    OverlayEntry menuOverlayEntry;
    menuOverlayEntry = OverlayEntry(
      builder: (context) {
        return Stack(
          children: <Widget>[
            Positioned.fill(
                child: GestureDetector(
              onTap: () => _closeMenu(menuOverlayEntry),
              child: Container(
                color: Colors.transparent,
              ),
            )),
            DownloadMenu(
              links: state.streamLinks?.list ?? [],
              movieName: state.movieName,
              playVideo: (d) {
                dispatch(BottomPanelActionCreator.seletedLink(d));
                _closeMenu(menuOverlayEntry);
              },
            ),
          ],
        );
      },
    );
    state.overlayStateKey.currentState.setOverlayEntry(menuOverlayEntry);
    Overlay.of(viewService.context).insert(menuOverlayEntry);
  }

  final _theme = ThemeStyle.getTheme(viewService.context);
  return OverlayEntryManage(
    key: state.overlayStateKey,
    child: Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: 80,
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
        decoration: BoxDecoration(
          color: _theme.brightness == Brightness.light
              ? const Color(0xFF25272E)
              : _theme.primaryColorDark,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(Adapt.px(60)),
          ),
        ),
        child: Row(children: [
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: _ItemButton(
              key: ValueKey('LikeIcons$state.userLiked'),
              onTap: () => dispatch(BottomPanelActionCreator.likeMovie()),
              icon: state.userLiked ? Icons.favorite : Icons.favorite_border,
              iconColor: state.userLiked
                  ? const Color(0xFFAA222E)
                  : const Color(0xFFFFFFFF),
              value: _convertString(state.likeCount),
            ),
          ),
          _ItemButton(
            icon: Icons.comment,
            onTap: () => dispatch(BottomPanelActionCreator.commentTap()),
            value: _convertString(state.commentCount),
          ),
          GestureDetector(
              onTap: _showSourceMenu,
              child: Icon(
                Icons.tv,
                size: Adapt.px(30),
                color: const Color(0xFFFFFFFF),
              )),
          SizedBox(width: Adapt.px(70)),
          GestureDetector(
            onTap: _showDownloadMenu,
            child: Icon(
              Icons.file_download,
              size: Adapt.px(30),
              color: const Color(0xFFFFFFFF),
            ),
          ),
          Spacer(),
          GestureDetector(
              onTap: () => _showOptionMenu(),
              child: Icon(
                Icons.more_vert,
                color: const Color(0xFFFFFFFF),
              )),
          SizedBox(width: Adapt.px(10)),
          GestureDetector(
            onTap: () => Navigator.of(viewService.context).pop(),
            child: Icon(
              Icons.keyboard_arrow_down,
              size: Adapt.px(60),
              color: const Color(0xFFFFFFFF),
            ),
          ),
        ]),
      ),
    ),
  );
}

class _ItemButton extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final Color iconColor;
  final String value;
  const _ItemButton(
      {Key key,
      this.icon,
      this.iconColor = const Color(0xFFFFFFFF),
      this.onTap,
      this.value})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: Adapt.px(110),
        child: Row(
          children: [
            Icon(
              icon,
              key: key,
              size: Adapt.px(30),
              color: iconColor,
            ),
            SizedBox(width: Adapt.px(10)),
            SizedBox(
              width: Adapt.px(70),
              child: Text(
                value,
                maxLines: 1,
                style: TextStyle(
                    color: const Color(0xFFFFFFFF), fontSize: Adapt.px(24)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String _convertString(int value) {
  String _result = '$value';
  if (value >= 1000 && value < 1000000)
    _result = '${(value / 1000).toStringAsFixed(0)}k';
  else if (value >= 1000000)
    _result = '${(value / 1000000).toStringAsFixed(0)}m';
  return _result;
}
