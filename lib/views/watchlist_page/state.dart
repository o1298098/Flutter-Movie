import 'package:fish_redux/fish_redux.dart';

class WatchlistPageState implements Cloneable<WatchlistPageState> {

  @override
  WatchlistPageState clone() {
    return WatchlistPageState();
  }
}

WatchlistPageState initState(Map<String, dynamic> args) {
  return WatchlistPageState();
}
