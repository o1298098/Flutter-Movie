import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/credits_model.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/episode_model.dart';
import 'package:movie/models/season_detail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/expandable_text.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    EpisodeLiveStreamState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);

      return Scaffold(
        backgroundColor: _theme.backgroundColor,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: _theme.brightness == Brightness.light
              ? SystemUiOverlayStyle.dark
              : SystemUiOverlayStyle.light,
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
                child: CustomScrollView(
                  controller: state.scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: SizedBox(height: Adapt.px(30) + Adapt.padTopH()),
                    ),
                    viewService.buildComponent('player'),
                    _Header(
                      episode: state.selectedEpisode,
                      season: state.season,
                    ),
                    const _EpisodeTitle(),
                    _Episodes(
                      episodes: state.season.episodes,
                      episodeNumber: state.selectedEpisode.episodeNumber,
                      onTap: (d) => dispatch(
                          EpisodeLiveStreamActionCreator.episodeTapped(d)),
                    ),
                    SliverToBoxAdapter(child: const SizedBox(height: 100)),
                  ],
                ),
              ),
              Container(
                color: _theme.backgroundColor,
                height: Adapt.padTopH(),
              ),
              viewService.buildComponent('bottomPanel'),
            ],
          ),
        ),
      );
    },
  );
}

class _Header extends StatelessWidget {
  final Episode episode;
  final Season season;
  const _Header({this.episode, this.season});
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.only(top: Adapt.px(40)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              episode.name,
              style: TextStyle(
                fontSize: Adapt.px(35),
                fontWeight: FontWeight.bold,
                height: 1.5,
              ),
            ),
            SizedBox(height: Adapt.px(40)),
            Row(children: [
              Container(
                width: Adapt.px(80),
                height: Adapt.px(80),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Adapt.px(20)),
                  image: season.posterPath != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(season.posterPath, ImageSize.w300),
                          ),
                        )
                      : null,
                ),
              ),
              SizedBox(width: Adapt.px(10)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: Adapt.screenW() - Adapt.px(410),
                    child: Text(
                      season.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    DateFormat.yMMMd().format(DateTime.parse(season.airDate)),
                    style: TextStyle(
                      fontSize: Adapt.px(24),
                      color: const Color(0xFF717171),
                    ),
                  ),
                ],
              ),
              Spacer(),
              _CastCell(casts: season.credits.cast)
            ]),
            SizedBox(height: Adapt.px(40)),
            ExpandableText(
              season.overview,
              maxLines: 3,
              style: TextStyle(color: const Color(0xFF717171), height: 1.5),
            )
          ],
        ),
      ),
    );
  }
}

class _CastCell extends StatelessWidget {
  final List<CastData> casts;
  const _CastCell({this.casts});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      width: Adapt.px(240),
      child: Row(
        children: casts
            .take(4)
            .map((e) {
              final int _index = casts.indexOf(e);
              return Container(
                width: Adapt.px(60),
                height: Adapt.px(60),
                transform: Matrix4.translationValues(10.0 * _index, 0, 0),
                decoration: BoxDecoration(
                  color: _theme.primaryColorDark,
                  border: Border.all(
                    color: const Color(0xFFFFFFFF),
                    width: 1,
                  ),
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                      ImageUrl.getUrl(e.profilePath, ImageSize.w300),
                    ),
                  ),
                ),
              );
            })
            .toList()
            .reversed
            .toList(),
      ),
    );
  }
}

class _EpisodeTitle extends StatelessWidget {
  const _EpisodeTitle();
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding:
            EdgeInsetsDirectional.only(top: Adapt.px(40), bottom: Adapt.px(30)),
        child: Text(
          'Next Episode',
          style: TextStyle(
            fontSize: Adapt.px(30),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _Episodes extends StatelessWidget {
  final List<Episode> episodes;
  final int episodeNumber;
  final Function(Episode) onTap;

  const _Episodes({this.episodes, this.episodeNumber, this.onTap});
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((_, index) {
        int _episodeIndex = episodeNumber - 1;
        int _d = _episodeIndex + index;
        final int _index = _d < episodes.length ? _d : _d - episodes.length;
        return _EpisodeCell(
          episode: episodes[_index],
          playing: episodeNumber == episodes[_index].episodeNumber,
          onTap: onTap,
        );
      }, childCount: episodes.length),
    );
  }
}

class _EpisodeCell extends StatelessWidget {
  final Episode episode;
  final bool playing;
  final Function(Episode) onTap;
  const _EpisodeCell({this.episode, this.onTap, this.playing = false});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: () => onTap(episode),
      child: Padding(
        padding: EdgeInsets.only(bottom: Adapt.px(30)),
        child: Row(
          children: [
            Container(
              width: Adapt.px(220),
              height: Adapt.px(122),
              decoration: BoxDecoration(
                color: _theme.primaryColorDark,
                borderRadius: BorderRadius.circular(Adapt.px(15)),
                image: episode.stillPath == null
                    ? null
                    : DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          ImageUrl.getUrl(episode.stillPath, ImageSize.w300),
                        ),
                      ),
              ),
              child: _WatchedCell(
                watched: episode.playState,
                playing: playing,
              ),
            ),
            SizedBox(width: Adapt.px(20)),
            SizedBox(
              width: Adapt.screenW() - Adapt.px(320),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EP${episode.episodeNumber}',
                    style: TextStyle(
                        fontSize: Adapt.px(28), fontWeight: FontWeight.bold),
                  ),
                  Text(episode.name),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _WatchedCell extends StatelessWidget {
  final bool playing;
  final bool watched;
  const _WatchedCell({this.watched = false, this.playing = false});
  @override
  Widget build(BuildContext context) {
    final _brightness = MediaQuery.of(context).platformBrightness;
    return playing || watched
        ? Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: EdgeInsets.all(4),
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: _brightness == Brightness.light
                      ? const Color(0xAAF0F0F0)
                      : const Color(0xAA202020),
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                playing ? 'Playing' : 'Watched',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        : const SizedBox();
  }
}
