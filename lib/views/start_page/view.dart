import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/keepalive_widget.dart';
import 'package:movie/models/enums/genres.dart';
import 'package:movie/models/item.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    StartPageState state, Dispatch dispatch, ViewService viewService) {
  final pages = [
    _FirstPage(
      continueTapped: () => state.pageController
          .nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease),
    ),
    _SecondPage(
      backTapped: () => state.pageController.previousPage(
          duration: Duration(milliseconds: 400), curve: Curves.ease),
      nextTapped: () => state.pageController
          .nextPage(duration: Duration(milliseconds: 400), curve: Curves.ease),
    ),
    _ThirdPage(
      backTapped: () => state.pageController.previousPage(
          duration: Duration(milliseconds: 400), curve: Curves.ease),
      nextTapped: () => dispatch(StartPageActionCreator.onStart()),
    ),
  ];
  Widget _buildPage(Widget page) {
    return keepAliveWrapper(page);
  }

  return Scaffold(
    // backgroundColor: const Color(0xFFFFFFFF),
    body: FutureBuilder(
        future: _checkContextInit(
          Stream<double>.periodic(Duration(milliseconds: 50),
              (x) => MediaQuery.of(viewService.context).size.height),
        ),
        builder: (_, snapshot) {
          if (snapshot.hasData) if (snapshot.data > 0) {
            Adapt.initContext(viewService.context);
            if(state.isFirstTime!=true)
            return Container();
            else
            return  PageView.builder(
              physics: NeverScrollableScrollPhysics(),
              controller: state.pageController,
              allowImplicitScrolling: false,
              itemCount: pages.length,
              itemBuilder: (context, index) {
                return _buildPage(pages[index]);
              },
            );
          }

          return Container(
            color: const Color(0xFFFFFFFF),
          );
        }),
  );
}

Future<double> _checkContextInit(Stream<double> source) async {
  await for (double value in source) {
    if (value > 0) {
      return value;
    }
  }
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
          'Welcome,',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
        ),
        SizedBox(height: Adapt.px(20)),
        Text(
          'let start with few steps.',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
        ),
        Expanded(child: SizedBox()),
        GestureDetector(
            onTap: continueTapped,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
              height: Adapt.px(120),
              decoration: BoxDecoration(
                  color: const Color(0xFF202F39),
                  borderRadius: BorderRadius.circular(Adapt.px(60))),
              child: Center(
                  child: Text(
                'Continue',
                style: TextStyle(
                    color: const Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              )),
            )),
      ]),
    ));
  }
}

class _SecondPage extends StatefulWidget {
  final Function backTapped;
  final Function nextTapped;
  _SecondPage({this.backTapped, this.nextTapped});
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<_SecondPage> {
  List<Item> _genres;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    _genres = Genres.movieList.values
        .map((e) => Item(name: e, value: false))
        .toList();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure();
    _firebaseMessaging.autoInitEnabled();
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
              '1.What kind of movie do you like?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            )),
        SizedBox(height: Adapt.px(60)),
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.vertical,
                  runSpacing: 20,
                  spacing: 20,
                  children: _genres.map<Widget>((d) {
                    final _index = _genres.indexOf(d);
                    return GestureDetector(
                        key: ValueKey(d.name),
                        onTap: () {
                          d.value = !d.value;
                          d.value
                              ? _firebaseMessaging.subscribeToTopic(d.name)
                              : _firebaseMessaging.unsubscribeFromTopic(d.name);
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
                            color: d.value
                                ? const Color(0xFF202F39)
                                : const Color(0xFFF0F0F0),
                          ),
                          child: Center(
                              child: Text(
                            d.name,
                            style: TextStyle(
                                color: d.value
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
                    child: Text('Back',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  ))),
          Expanded(child: SizedBox()),
          GestureDetector(
              onTap: () async {
                SharedPreferences.getInstance().then((_p) =>
                    _p.setString('movieTypeSubscribed', _genres.toString()));

                widget.nextTapped();
              },
              child: Container(
                width: Adapt.px(250),
                margin: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
                height: Adapt.px(120),
                decoration: BoxDecoration(
                    color: const Color(0xFF202F39),
                    borderRadius: BorderRadius.circular(Adapt.px(60))),
                child: Center(
                    child: Text(
                  'Next  >',
                  style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
              )),
        ]),
      ]),
    ));
  }
}

class _ThirdPage extends StatefulWidget {
  final Function backTapped;
  final Function nextTapped;
  _ThirdPage({this.backTapped, this.nextTapped});
  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<_ThirdPage> {
  List<Item> _genres;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  @override
  void initState() {
    _genres =
        Genres.tvList.values.map((e) => Item(name: e, value: false)).toList();
    _firebaseMessaging.requestNotificationPermissions();
    _firebaseMessaging.configure();
    _firebaseMessaging.autoInitEnabled();
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
              '1.What kind of tv show do you like?',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            )),
        SizedBox(height: Adapt.px(60)),
        Expanded(
            child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Wrap(
                  direction: Axis.vertical,
                  runSpacing: 20,
                  spacing: 20,
                  children: _genres.map<Widget>((d) {
                    final _index = _genres.indexOf(d);
                    return GestureDetector(
                        key: ValueKey(d.name),
                        onTap: () {
                          d.value = !d.value;
                          d.value
                              ? _firebaseMessaging.subscribeToTopic(d.name)
                              : _firebaseMessaging.unsubscribeFromTopic(d.name);
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
                            color: d.value
                                ? const Color(0xFF202F39)
                                : const Color(0xFFF0F0F0),
                          ),
                          child: Center(
                              child: Text(
                            d.name,
                            style: TextStyle(
                                color: d.value
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
                    child: Text('Back',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        )),
                  ))),
          Expanded(child: SizedBox()),
          GestureDetector(
              onTap: () async {
                SharedPreferences.getInstance().then((_p) =>
                    _p.setString('tvTypeSubscribed', _genres.toString()));

                widget.nextTapped();
              },
              child: Container(
                width: Adapt.px(250),
                margin: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
                height: Adapt.px(120),
                decoration: BoxDecoration(
                    color: const Color(0xFF202F39),
                    borderRadius: BorderRadius.circular(Adapt.px(60))),
                child: Center(
                    child: Text(
                  'Start  >',
                  style: TextStyle(
                      color: const Color(0xFFFFFFFF),
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                )),
              )),
        ]),
      ]),
    ));
  }
}
