import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/actions/apihelper.dart';
import 'package:movie/customwidgets/custom_stfstate.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'action.dart';
import 'state.dart';
import 'package:webview_flutter/webview_flutter.dart';

Effect<MyListsPageState> buildEffect() {
  return combineEffects(<Object, Effect<MyListsPageState>>{
    Lifecycle.initState: _onInit,
    Lifecycle.deactivate: _onDeactivate,
    Lifecycle.dispose: _onDispose,
    MyListsPageAction.action: _onAction,
    MyListsPageAction.cellTapped: _cellTapped
  });
}

void _onAction(Action action, Context<MyListsPageState> ctx) {}

Future _onInit(Action action, Context<MyListsPageState> ctx) async {
  final ticker = ctx.stfState as CustomstfState;
  ctx.state.animationController =
      AnimationController(vsync: ticker, duration: Duration(milliseconds: 300));
  ctx.state.cellAnimationController = AnimationController(
      vsync: ticker, duration: Duration(milliseconds: 1000));
  String id = ctx.state.accountId;
  ctx.state.scrollController = ScrollController(keepScrollOffset: false)
    ..addListener(() async {
      bool isBottom = ctx.state.scrollController.position.pixels ==
          ctx.state.scrollController.position.maxScrollExtent;
      if (isBottom) {
        _loadMore(action, ctx);
      }
    });
  bool shouldLoad = true;
  if (id == null) {
    shouldLoad = false;
    var token = await ApiHelper.createRequestTokenV4();
    if (token != null) {
      var url = 'https://www.themoviedb.org/auth/access?request_token=$token';
      await Navigator.of(ctx.context)
          .push(MaterialPageRoute(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'User Permission',
              style: TextStyle(color: Colors.black),
            ),
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black),
          ),
          body: WebView(
            initialUrl: url,
          ),
        );
      }));
      var result = await ApiHelper.createAccessTokenV4(token);
      if (result) {
        var prefs = await SharedPreferences.getInstance();
        id = prefs.getString('accountIdV4');
        ctx.dispatch(MyListsPageActionCreator.setAccount(id));
        shouldLoad = true;
      }
    }
  }
  if (shouldLoad && id != null) {
    var r = await ApiHelper.getAccountListsV4(id);
    if (r != null) ctx.dispatch(MyListsPageActionCreator.setList(r));
  }
}

void _onDispose(Action action, Context<MyListsPageState> ctx) {
  ctx.state.cellAnimationController.stop();
  ctx.state.scrollController.dispose();
  ctx.state.animationController.dispose();
  ctx.state.cellAnimationController.dispose();
}

void _onDeactivate(Action action, Context<MyListsPageState> ctx) {
  ctx.state.cellAnimationController.stop();
  ctx.state.animationController.stop();
}

Future _loadMore(Action action, Context<MyListsPageState> ctx) async {
  var t = ctx.state.myList;
  if (t != null) {
    if (t.page != t.totalPages) {
      int page = t.page + 1;
      var r =
          await ApiHelper.getAccountListsV4(ctx.state.accountId, page: page);
      if (r != null) ctx.dispatch(MyListsPageActionCreator.loadMore(r));
    }
  }
}

Future _cellTapped(Action action, Context<MyListsPageState> ctx) async {
  await Navigator.of(ctx.context)
      .pushNamed('ListDetailPage', arguments: {'listId': action.payload});
}
