import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/models.dart';
import 'package:movie/widgets/keepalive_widget.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:ui' as ui;

import 'action.dart';
import 'state.dart';

Widget buildView(
    StartPageState state, Dispatch dispatch, ViewService viewService) {
  final Map<int, bool> _movieGenres = Map<int, bool>();
  final Map<int, bool> _tvGenres = Map<int, bool>();
  Genres.instance.movieList.keys.forEach((e) => _movieGenres[e] = false);
  Genres.instance.tvList.keys.forEach((e) => _tvGenres[e] = false);
  final pages = [
    _FirstPage(
      continueTapped: () => state.pageController
          .nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease),
    ),
    _SubscribeTopicPage(
        title: '1.${I18n.of(viewService.context).whatKindOfMovieDoYouLike}?',
        buttonTitle: '${I18n.of(viewService.context).next} >',
        tag: 'movie_',
        isMovie: true,
        genres: _movieGenres,
        backTapped: () => state.pageController.previousPage(
            duration: Duration(milliseconds: 400), curve: Curves.ease),
        nextTapped: () {
          SharedPreferences.getInstance().then((_p) => _p.setString(
              'movieTypeSubscribed',
              _movieGenres.keys
                  .map((e) => Item.fromParams(
                      name: e.toString(), value: _movieGenres[e]))
                  .toList()
                  .toString()));
          state.pageController.nextPage(
              duration: Duration(milliseconds: 400), curve: Curves.ease);
        }),
    _SubscribeTopicPage(
        title: '2.${I18n.of(viewService.context).whatKindOfTvShowDoYouLike}?',
        buttonTitle: '${I18n.of(viewService.context).start} >',
        tag: 'tvshow_',
        isMovie: false,
        genres: _tvGenres,
        backTapped: () => state.pageController.previousPage(
            duration: Duration(milliseconds: 400), curve: Curves.ease),
        nextTapped: () {
          SharedPreferences.getInstance().then((_p) => _p.setString(
              'tvTypeSubscribed',
              _tvGenres.keys
                  .map((e) =>
                      Item.fromParams(name: e.toString(), value: _tvGenres[e]))
                  .toList()
                  .toString()));
          dispatch(StartPageActionCreator.onStart());
        }),
  ];

  Widget _buildPage(Widget page) {
    return keepAliveWrapper(page);
  }

  return Scaffold(
    body: FutureBuilder(
        future: _checkContextInit(
          Stream<double>.periodic(Duration(milliseconds: 50),
              (x) => MediaQuery.of(viewService.context).size.height),
        ),
        builder: (_, snapshot) {
          if (snapshot.hasData) if (snapshot.data > 0) {
            Adapt.initContext(viewService.context);
            if (state.isFirstTime != true)
              return Container();
            else
              return PageView.builder(
                physics: NeverScrollableScrollPhysics(),
                controller: state.pageController,
                allowImplicitScrolling: false,
                itemCount: pages.length,
                itemBuilder: (context, index) {
                  return _buildPage(pages[index]);
                },
              );
          }
          return Container();
        }),
  );
}

Future<double> _checkContextInit(Stream<double> source) async {
  await for (double value in source) {
    if (value > 0) {
      return value;
    }
  }
  return 0.0;
}

class _FirstPage extends StatelessWidget {
  final Function continueTapped;
  const _FirstPage({this.continueTapped});
  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(height: Adapt.px(300)),
        SizedBox(
            width: Adapt.screenW(),
            height: Adapt.px(500),
            child: Lottie.asset(
              'images/landscape.json', //Lottie.network(https://assets4.lottiefiles.com/packages/lf20_umBOmV.json')
            )),
        Text(
          '${I18n.of(context).welcome},',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: Adapt.px(20)),
        Text(
          '${I18n.of(context).letStartWithFewSteps}.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Expanded(child: SizedBox()),
        GestureDetector(
            onTap: continueTapped,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xFF202F39),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Text(
                I18n.of(context).continueA,
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
            )),
        SizedBox(height: Adapt.px(20))
      ]),
    ));
  }
}

class _SubscribeTopicPage extends StatefulWidget {
  final String title;
  final String buttonTitle;
  final bool isMovie;
  final String tag;
  final Function backTapped;
  final Function nextTapped;
  final Map<int, bool> genres;
  _SubscribeTopicPage(
      {this.backTapped,
      this.nextTapped,
      this.genres,
      this.isMovie,
      @required this.title,
      @required this.buttonTitle,
      this.tag});
  @override
  _SubscribeTopicPageState createState() => _SubscribeTopicPageState();
}

class _SubscribeTopicPageState extends State<_SubscribeTopicPage> {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Item> _genres = [];
  final _languageCode = ui.window.locale.languageCode;
  @override
  void initState() {
    final _genresMap = widget.isMovie
        ? Genres.instance.getMovieGenresList(_languageCode)
        : Genres.instance.getTvGenresList(_languageCode);
    _genresMap.forEach((key, value) {
      _genres.add(Item.fromParams(name: value, value: key));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SafeArea(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: Adapt.px(80)),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            child: Text(
              widget.title,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            )),
        SizedBox(height: Adapt.px(60)),
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Wrap(
                  direction: Axis.vertical,
                  runSpacing: Adapt.px(20),
                  spacing: Adapt.px(20),
                  children: _genres.map<Widget>((d) {
                    final _index = _genres.indexOf(d);
                    bool _selected = widget.genres[d.value];
                    return GestureDetector(
                        key: ValueKey(d.name),
                        onTap: () {
                          _selected = !_selected;
                          widget.genres[d.value] = _selected;
                          final _topic =
                              '${widget.tag}genre_${d.value}_$_languageCode';
                          _selected
                              ? _firebaseMessaging.subscribeToTopic(_topic)
                              : _firebaseMessaging.unsubscribeFromTopic(_topic);
                          setState(() {});
                        },
                        child: Container(
                          width: Adapt.px(200),
                          height: Adapt.px(200),
                          padding: EdgeInsets.all(Adapt.px(30)),
                          margin: EdgeInsets.only(
                              top: (_index + 4) % 8 == 0 ? Adapt.px(80) : 0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _selected
                                ? const Color(0xFF202F39)
                                : const Color(0xFFF0F0F0),
                          ),
                          child: Center(
                              child: Text(
                            d.name,
                            style: TextStyle(
                                color: _selected
                                    ? const Color(0xFFFFFFFF)
                                    : const Color(0xFF0000000),
                                fontSize: Adapt.px(26),
                                fontWeight: FontWeight.w600),
                          )),
                        ));
                  }).toList()
                    ..add(Container(height: Adapt.px(900), width: Adapt.px(40)))
                    ..insert(0,
                        Container(height: Adapt.px(900), width: Adapt.px(40))),
                ))),
        Row(children: [
          SizedBox(width: Adapt.px(80)),
          InkWell(
              onTap: widget.backTapped,
              child: SizedBox(
                  width: Adapt.px(100),
                  height: Adapt.px(80),
                  child: Center(
                    child: Text(I18n.of(context).back,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  ))),
          Expanded(child: SizedBox()),
          GestureDetector(
              onTap: () async {
                widget.nextTapped();
              },
              child: Container(
                width: Adapt.px(250),
                margin: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
                height: 60,
                decoration: BoxDecoration(
                    color: const Color(0xFF202F39),
                    borderRadius: BorderRadius.circular(30)),
                child: Center(
                    child: Text(
                  widget.buttonTitle,
                  style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
              )),
        ]),
        SizedBox(height: Adapt.px(20))
      ]),
    ));
  }
}
