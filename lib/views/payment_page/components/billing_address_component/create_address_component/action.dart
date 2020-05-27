import 'package:fish_redux/fish_redux.dart';

//TODO replace with your own action
enum CreateAddressAction { action }

class CreateAddressActionCreator {
  static Action onAction() {
    return const Action(CreateAddressAction.action);
  }
}
