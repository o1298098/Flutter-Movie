import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/searchresult.dart';
import 'package:loader_search_bar/loader_search_bar.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    SearchBarState state, Dispatch dispatch, ViewService viewService) {
  
  Widget _buildMovieSuggestion(SearchResult s) {
    return ListTile(
      leading: Icon(Icons.movie),
      title: new Text(s.title),
    );
  }

  Widget _buildTVSuggestion(SearchResult s) {
    return ListTile(
      leading: Icon(Icons.live_tv),
      title: new Text(s.name),
    );
  }

  Widget _buildPersonSuggestion(SearchResult s) {
    return ListTile(
      leading: Icon(Icons.person),
      title: new Text(s.name),
    );
  }

  Widget _buildSuggestion(SearchResult s) {
    Widget cell;
    switch (s.mediaType) {
      case 'movie':
        cell = _buildMovieSuggestion(s);
        break;
      case 'tv':
        cell = _buildTVSuggestion(s);
        break;
      case 'person':
        cell = _buildPersonSuggestion(s);
        break;
      default:
        cell = _buildMovieSuggestion(s);
        break;
    }
    return Container(
      height: Adapt.px(100),
      child: cell,
    );
  }

  return SearchBar(
    searchHint: I18n.of(viewService.context).searchbartxt,
    defaultBar: AppBar(),
    attrs: SearchBarAttrs(),
  );
  /*SearchWidget<SearchResult>(
    dataList: state.searchResultModel.results.take(8).toList() ?? [],
    hideSearchBoxWhenItemSelected: false,
    listContainerHeight: Adapt.px(105)*8,
    queryBuilder: (String query, List<SearchResult> list) {
      return list;
    },
    popupListItemBuilder: (SearchResult item) {
      return Container();
    },
    selectedItemBuilder:
        (SearchResult selectedItem, VoidCallback deleteSelectedItem) {
      return Container(child: Text(selectedItem.id.toString()),);
    },
    // widget customization
    noItemsFoundWidget: Container(child: Center(child: Text('None'),),),
    textFieldBuilder: (TextEditingController controller, FocusNode focusNode) {
      dispatch(SearchBarActionCreator.onSetFocus(focusNode));
      return Hero(
          tag: 'searchbar',
          child: Material(
              color: Colors.transparent,
              child: Container(
                  margin:
                      EdgeInsets.only(left: Adapt.px(30), right: Adapt.px(10)),
                  height: Adapt.px(80),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Adapt.px(40)),
                    color: Colors.grey[200],
                  ),
                  child: TextField(
                      onChanged: (s) {
                         dispatch(SearchBarActionCreator.onTextChanged(s));
                      },
                      focusNode: focusNode,
                      controller: controller,
                      keyboardAppearance: Brightness.light,
                      cursorColor: Colors.grey,
                      decoration: new InputDecoration(
                          hintText: I18n.of(viewService.context).searchbartxt,
                          hintStyle: TextStyle(
                              color: Colors.grey, fontSize: Adapt.px(28)),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,
                          ),
                          enabledBorder: new UnderlineInputBorder(
                              borderSide:
                                  new BorderSide(color: Colors.transparent)),
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.transparent)))))));
    },
  );*/
  
}
