import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/models.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/stream_link/movie_livestream_page/components/bottom_panel_component/components/streamlink_filter_component/components/sort_menu.dart';
import 'package:movie/widgets/overlay_entry_manage.dart';
import 'package:movie/widgets/sliverappbar_delegate.dart';

import 'action.dart';
import 'components/filter_menu.dart';
import 'state.dart';

Widget buildView(
    StreamLinkFilterState state, Dispatch dispatch, ViewService viewService) {
  void _closeMenu(OverlayEntry overlayEntry) {
    overlayEntry?.remove();
    state.overlayStateKey.currentState.setOverlayEntry(null);
    overlayEntry = null;
  }

  void _openFilter() {
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
            FilterMenu(
              selectedHost: state.selectHost,
              selectedLanguage: state.selectLanguage,
              selectedQuality: state.selectQuality,
              hostTap: (host) =>
                  dispatch(StreamLinkFilterActionCreator.hostTap(host)),
              languageTap: (language) =>
                  dispatch(StreamLinkFilterActionCreator.languageTap(language)),
              qualityTap: (quality) =>
                  dispatch(StreamLinkFilterActionCreator.qualityTap(quality)),
            )
          ],
        );
      },
    );
    state.overlayStateKey.currentState.setOverlayEntry(menuOverlayEntry);
    Overlay.of(viewService.context).insert(menuOverlayEntry);
  }

  void _openSort() {
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
            SortMenu(
              sort: state.sort,
              sortAsc: state.sortAsc,
              onSortTap: (s, b) =>
                  dispatch(StreamLinkFilterActionCreator.sortTap(s, b)),
            )
          ],
        );
      },
    );
    state.overlayStateKey.currentState.setOverlayEntry(menuOverlayEntry);
    Overlay.of(viewService.context).insert(menuOverlayEntry);
  }

  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
        backgroundColor: _theme.backgroundColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: SafeArea(
            child: CustomScrollView(
              slivers: [
                _FilterPanel(
                  openFilter: _openFilter,
                  openSort: _openSort,
                  overlayStateKey: state.overlayStateKey,
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (_, index) {
                      final _d = state.filterLinks[index];
                      return _LinkCell(
                        link: _d,
                        onTap: (link) => dispatch(
                            StreamLinkFilterActionCreator.streamlinkTap(link)),
                      );
                    },
                    childCount: state.filterLinks?.length ?? 0,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 20),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _LinkCell extends StatelessWidget {
  final TvShowStreamLink link;
  final Function(TvShowStreamLink) onTap;
  const _LinkCell({this.link, this.onTap});

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _domain = _getDomain(link.streamLink, link.streamLinkType.name);
    final _date = DateFormat.yMMMd().format(DateTime.parse(link.updateTime));
    final _borderColor = _theme.brightness == Brightness.light
        ? const Color(0xFF858585)
        : const Color(0xFFE0E0E0);
    return GestureDetector(
      onTap: () => onTap(link),
      child: Container(
        margin: EdgeInsets.only(top: 15, left: 20, right: 20),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: _borderColor),
          //color: _theme.primaryColorDark,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Text(
                _domain,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 15),
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: const Color(0xFF252525),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  link.quality.name,
                  style: TextStyle(
                    fontSize: 10,
                    color: const Color(0xFFFFFFFF),
                  ),
                ),
              ),
              Spacer(),
              Text(
                _date,
                style: TextStyle(
                  fontSize: 10,
                  color: const Color(0xFF717171),
                ),
              ),
            ]),
            Text(
              link.language.name,
              style: TextStyle(
                fontSize: 12,
                color: const Color(0xFF717171),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _FilterPanel extends StatelessWidget {
  final Function openFilter;
  final Function openSort;
  final Key overlayStateKey;
  const _FilterPanel({this.openFilter, this.openSort, this.overlayStateKey});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _borderColor = _theme.brightness == Brightness.light
        ? const Color(0xFFDEDEDE)
        : const Color(0xFF505050);
    return SliverPersistentHeader(
      floating: true,
      delegate: SliverAppBarDelegate(
        minHeight: Adapt.px(120),
        maxHeight: Adapt.px(120),
        child: Container(
          color: _theme.backgroundColor,
          child: OverlayEntryManage(
            key: overlayStateKey,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
              decoration: BoxDecoration(
                //color: _theme.primaryColorLight,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _borderColor,
                ),
              ),
              height: Adapt.px(80),
              child: Row(
                children: [
                  _FilterOption(
                    title: 'sort',
                    onTap: openSort,
                  ),
                  Spacer(),
                  GestureDetector(
                    onTap: openFilter,
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        color: const Color(0xFF25272E),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        FontAwesomeIcons.filter,
                        size: 10,
                        color: const Color(0xFFFFFFFF),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        border: Border.all(color: _theme.iconTheme.color),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.close,
                        size: 15,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _FilterOption extends StatelessWidget {
  final String title;
  final Function onTap;
  const _FilterOption({Key key, this.title, this.onTap})
      : assert(title != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: _theme.primaryColorDark,
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Text(title),
            SizedBox(width: 5),
            Icon(
              Icons.keyboard_arrow_down,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}

_getDomain(String url, String type) {
  if (type.toLowerCase() == 'youtube') return 'youtube';
  if (type.toLowerCase() == 'torrent') return 'torrent';
  final _strArray = url.split('/');
  if (_strArray.length > 3) return _strArray[2];
  return url;
}
