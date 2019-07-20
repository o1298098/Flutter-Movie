import 'package:fish_redux/fish_redux.dart';

class MyListsPageState implements Cloneable<MyListsPageState> {

  @override
  MyListsPageState clone() {
    return MyListsPageState();
  }
}

MyListsPageState initState(Map<String, dynamic> args) {
  return MyListsPageState();
}
