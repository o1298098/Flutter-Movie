import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/api/tmdb_api.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/response_model.dart';
import 'package:movie/models/search_result.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchBarDelegate extends SearchDelegate<SearchResult> {
  SearchResultModel searchResultModel;
  List<String> searchHistory;
  SharedPreferences prefs;
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Future<ResponseModel<SearchResultModel>> _getData() {
    if (query != '' && query != null)
      return TMDBApi.instance.searchMulit(query);
    else
      return null;
  }

  Future<List<String>> _getHistory() async {
    if (prefs == null) prefs = await SharedPreferences.getInstance();
    searchHistory = prefs.getStringList('searchHistory') ?? [];
    return searchHistory;
  }

  @override
  Widget buildResults(BuildContext context) {
    if (prefs != null && query != '') {
      int index = searchHistory.indexOf(query);
      if (index < 0) {
        searchHistory.insert(0, query);
        prefs.setStringList('searchHistory', searchHistory);
      }
    }
    return FutureBuilder<ResponseModel<SearchResultModel>>(
      future: _getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context,
          AsyncSnapshot<ResponseModel<SearchResultModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Container(
              child: Center(
                child: Text('No Result'),
              ),
            );
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container(
              margin: EdgeInsets.only(top: Adapt.px(30)),
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.black),
              ),
            );
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return _ResultList(
              query: query,
              results: snapshot.data?.result?.results ?? [],
            );
        }
        return null;
      },
    );
  }

  Widget _buildHistoryList() {
    return FutureBuilder<List<String>>(
      future: _getHistory(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return _buildHistoryList();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container(
              margin: EdgeInsets.only(top: Adapt.px(30)),
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black)),
            );
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding:
                          EdgeInsets.fromLTRB(Adapt.px(30), Adapt.px(30), 0, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'History',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: Adapt.px(35)),
                          ),
                          searchHistory.length > 0
                              ? SizedBox(
                                  height: Adapt.px(40),
                                  child: IconButton(
                                    padding: EdgeInsets.all(0),
                                    icon: Icon(Icons.delete_outline),
                                    onPressed: () {
                                      if (prefs != null &&
                                          searchHistory.length > 0) {
                                        searchHistory = [];
                                        prefs.remove('searchHistory');
                                        query = '';
                                        showSuggestions(context);
                                      }
                                    },
                                  ),
                                )
                              : SizedBox()
                        ],
                      )),
                  searchHistory != null && searchHistory.length > 0
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: Adapt.px(30)),
                          width: Adapt.screenW(),
                          child: Wrap(
                              spacing: Adapt.px(20),
                              children: searchHistory.take(10).map((s) {
                                return ActionChip(
                                  avatar: Icon(
                                    Icons.history,
                                    color: Colors.grey[500],
                                  ),
                                  // backgroundColor: Colors.grey[200],
                                  label: Text(s),
                                  //labelStyle: TextStyle(color: Colors.black87),
                                  onPressed: () {
                                    query = s;
                                    showResults(context);
                                  },
                                );
                              }).toList()),
                        )
                      : Container(
                          padding: EdgeInsets.only(left: Adapt.px(30)),
                          child: Text('no search history'),
                        ),
                ],
              ),
            );
        }
        return null;
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<ResponseModel<SearchResultModel>>(
      future: _getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context,
          AsyncSnapshot<ResponseModel<SearchResultModel>> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return _buildHistoryList();
          case ConnectionState.active:
          case ConnectionState.waiting:
            return Container(
              margin: EdgeInsets.only(top: Adapt.px(30)),
              alignment: Alignment.topCenter,
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.black)),
            );
          case ConnectionState.done:
            if (snapshot.hasError) return Text('Error: ${snapshot.error}');
            return _SuggestionList(
              query: query,
              suggestions: snapshot.data?.result?.results ?? [],
              onSelected: (String suggestion) {
                query = suggestion;
                showResults(context);
              },
            );
        }
        return null;
      },
    );
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);

    assert(theme != null);
    final _lightTheme = theme.copyWith(
      inputDecorationTheme:
          InputDecorationTheme(hintStyle: TextStyle(color: Colors.grey)),
      primaryColor: Colors.white,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.light,
      primaryTextTheme: theme.textTheme,
    );
    final _darkTheme = theme.copyWith(
      inputDecorationTheme:
          InputDecorationTheme(hintStyle: TextStyle(color: Colors.grey)),
      primaryColor: Color(0xFF303030),
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.grey),
      primaryColorBrightness: Brightness.dark,
      primaryTextTheme: theme.textTheme,
    );
    final MediaQueryData _mediaQuery = MediaQuery.of(context);
    final ThemeData _newtheme =
        _mediaQuery.platformBrightness == Brightness.light
            ? _lightTheme
            : _darkTheme;
    return _newtheme;
  }
}

Widget _buildSuggestionCell(SearchResult s, ValueChanged<String> tapped) {
  IconData iconData = s.mediaType == 'movie'
      ? Icons.movie
      : s.mediaType == 'tv' ? Icons.live_tv : Icons.person;
  String name = s.mediaType == 'movie' ? s.title : s.name;
  return Container(
      height: Adapt.px(100),
      child: ListTile(
        leading: Icon(iconData),
        title: new Text(name),
        onTap: () => tapped(name),
      ));
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<SearchResult> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final SearchResult suggestion = suggestions[i];
        return _buildSuggestionCell(suggestion, onSelected);
      },
    );
  }
}

Random _random = Random(DateTime.now().millisecondsSinceEpoch);

Widget _buildResultCell(SearchResult s, BuildContext ctx) {
  IconData iconData = s.mediaType == 'movie'
      ? Icons.movie
      : s.mediaType == 'tv' ? Icons.live_tv : Icons.person;
  String imageurl = s.mediaType != 'person' ? s.posterPath : s.profilePath;
  String name = s.mediaType == "movie" ? s.title : s.name;
  return GestureDetector(
    child: Padding(
      padding: EdgeInsets.only(bottom: Adapt.px(20)),
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Adapt.px(240),
              height: Adapt.px(350),
              decoration: BoxDecoration(
                  color: Color.fromRGBO(
                      _random.nextInt(255),
                      _random.nextInt(255),
                      _random.nextInt(255),
                      _random.nextDouble()),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: CachedNetworkImageProvider(imageurl == null
                          ? ImageUrl.emptyimage
                          : ImageUrl.getUrl(imageurl, ImageSize.w300)))),
            ),
            SizedBox(
              width: Adapt.px(20),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: Adapt.px(20),
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      iconData,
                      size: Adapt.px(40),
                    ),
                    SizedBox(
                      width: Adapt.px(10),
                    ),
                    Container(
                      width: Adapt.screenW() - Adapt.px(370),
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: Adapt.px(30)),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                s.mediaType != 'person'
                    ? Container(
                        width: Adapt.screenW() - Adapt.px(320),
                        child: Text(
                          s.overview ?? 'no description',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 7,
                          style: TextStyle(
                              fontSize: Adapt.px(26), wordSpacing: 1.2),
                        ),
                      )
                    : Container(
                        width: Adapt.screenW() - Adapt.px(320),
                        child: Wrap(
                          spacing: Adapt.px(10),
                          children: s.knownFor.map((d) {
                            return Chip(
                              backgroundColor: Colors.grey[200],
                              label: Text(
                                d.title ?? '',
                                style: TextStyle(fontSize: Adapt.px(24)),
                              ),
                            );
                          }).toList(),
                        )),
              ],
            )
          ],
        ),
      ),
    ),
    onTap: () async {
      switch (s.mediaType) {
        case 'movie':
          return await Navigator.of(ctx).pushNamed('detailpage', arguments: {
            'id': s.id,
            'bgpic': s.posterPath,
            'title': s.title,
            'posterpic': s.posterPath
          });
        case 'tv':
          return await Navigator.of(ctx).pushNamed('tvShowDetailPage',
              arguments: {
                'id': s.id,
                'bgpic': s.backdropPath,
                'name': s.name,
                'posterpic': s.posterPath
              });
        case 'person':
          return await Navigator.of(ctx).pushNamed('peopledetailpage',
              arguments: {
                'peopleid': s.id,
                'profilePath': s.profilePath,
                'profileName': s.name
              });
        default:
          return null;
      }
    },
  );
}

class _ResultList extends StatefulWidget {
  const _ResultList({this.results, this.query});

  final List<SearchResult> results;
  final String query;

  @override
  _ResultListState createState() => _ResultListState();
}

class _ResultListState extends State<_ResultList> {
  ScrollController scrollController;
  List<SearchResult> results;
  String query;
  int pageindex;
  int totalpage;
  bool isloading;

  Future loadData() async {
    bool isBottom = scrollController.position.pixels ==
        scrollController.position.maxScrollExtent;
    if (isBottom && totalpage > pageindex) {
      setState(() {
        isloading = true;
      });
      pageindex++;
      final r = await TMDBApi.instance.searchMulit(query, page: pageindex);
      if (r != null) {
        setState(() {
          if (r.success) {
            pageindex = r.result.page;
            totalpage = r.result.totalPages;
            results.addAll(r.result.results);
          }
          isloading = false;
        });
      }
    }
  }

  Widget _buildFooter() {
    return Offstage(
        offstage: !isloading,
        child: Container(
          height: Adapt.px(80),
          alignment: Alignment.center,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.black)),
        ));
  }

  @override
  void initState() {
    results = widget.results;
    query = widget.query;
    pageindex = 1;
    totalpage = 2;
    isloading = false;
    scrollController = ScrollController()..addListener(loadData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
      child: ListView(
          controller: scrollController,
          children: results
              .map((result) => _buildResultCell(result, context))
              .toList()
                ..add(_buildFooter())),
    );
  }
}
