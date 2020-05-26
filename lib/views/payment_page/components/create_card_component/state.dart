import 'package:fish_redux/fish_redux.dart';

class CreateCardState implements Cloneable<CreateCardState> {

  @override
  CreateCardState clone() {
    return CreateCardState();
  }
}

CreateCardState initState(Map<String, dynamic> args) {
  return CreateCardState();
}
