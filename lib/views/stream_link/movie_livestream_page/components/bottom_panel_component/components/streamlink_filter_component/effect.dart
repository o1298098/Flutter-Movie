import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart' hide Action;
import 'package:movie/models/models.dart';
import 'action.dart';
import 'state.dart';

Effect<StreamLinkFilterState> buildEffect() {
  return combineEffects(<Object, Effect<StreamLinkFilterState>>{
    StreamLinkFilterAction.action: _onAction,
    StreamLinkFilterAction.selectedLinkTap: _selectedLinkTap,
    StreamLinkFilterAction.hostTap: _hostTap,
    StreamLinkFilterAction.languageTap: _languageTap,
    StreamLinkFilterAction.qualityTap: _qualityTap,
    StreamLinkFilterAction.sortTap: _sortTap,
  });
}

void _onAction(Action action, Context<StreamLinkFilterState> ctx) {}

void _selectedLinkTap(Action action, Context<StreamLinkFilterState> ctx) {
  final MovieStreamLink _link = action.payload;
  ctx.dispatch(StreamLinkFilterActionCreator.setSelectedLink(_link));
  Navigator.of(ctx.context).pop();
}

void _hostTap(Action action, Context<StreamLinkFilterState> ctx) {
  final String _host = action.payload;
  ctx.dispatch(StreamLinkFilterActionCreator.setHost(_host));
  _updateFilter(action, ctx);
}

void _languageTap(Action action, Context<StreamLinkFilterState> ctx) {
  final String _language = action.payload;
  ctx.dispatch(StreamLinkFilterActionCreator.setLanguage(_language));
  _updateFilter(action, ctx);
}

void _qualityTap(Action action, Context<StreamLinkFilterState> ctx) {
  final String _qualityTap = action.payload;
  ctx.dispatch(StreamLinkFilterActionCreator.setQuality(_qualityTap));
  _updateFilter(action, ctx);
}

void _sortTap(Action action, Context<StreamLinkFilterState> ctx) {
  final String _sort = action.payload[0];
  final bool _asc = action.payload[1] ?? true;
  ctx.dispatch(StreamLinkFilterActionCreator.setSort(_sort, _asc));
  _updateFilter(action, ctx);
}

void _updateFilter(Action action, Context<StreamLinkFilterState> ctx) {
  List<MovieStreamLink> _list = ctx.state.streamLinks.list;
  if (ctx.state.selectHost != null)
    _list = _list
        .where((e) => e.streamLink.contains(ctx.state.selectHost))
        .toList();
  if (ctx.state.selectLanguage != null)
    _list = _list
        .where((e) => e.language.name == ctx.state.selectLanguage)
        .toList();
  if (ctx.state.selectQuality != null)
    _list =
        _list.where((e) => e.quality.name == ctx.state.selectQuality).toList();
  if (ctx.state.sort != null) {
    final _sort = ctx.state.sort;
    final _asc = ctx.state.sortAsc ?? true;
    switch (_sort) {
      case 'Domain':
        _asc
            ? _list.sort((a, b) => a.streamLink.compareTo(b.streamLink))
            : _list.sort((a, b) => b.streamLink.compareTo(a.streamLink));
        break;
      case 'Language':
        _asc
            ? _list.sort((a, b) => a.language.name.compareTo(b.language.name))
            : _list.sort((a, b) => b.language.name.compareTo(a.language.name));
        break;
      case 'Quality':
        _asc
            ? _list.sort((a, b) => a.quality.id.compareTo(b.quality.id))
            : _list.sort((a, b) => b.quality.id.compareTo(a.quality.id));
        break;
      case 'UpdateTime':
        _asc
            ? _list.sort((a, b) => a.updateTime.compareTo(b.updateTime))
            : _list.sort((a, b) => b.updateTime.compareTo(a.updateTime));
        break;
    }
  }
  ctx.dispatch(StreamLinkFilterActionCreator.setFilterList(_list));
}
