import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/country_phone_code.dart';

enum CreateAddressAction { action, setRegion, save }

class CreateAddressActionCreator {
  static Action onAction() {
    return const Action(CreateAddressAction.action);
  }

  static Action setRegion(CountryPhoneCode region) {
    return Action(CreateAddressAction.setRegion, payload: region);
  }

  static Action onSave() {
    return const Action(CreateAddressAction.save);
  }
}
