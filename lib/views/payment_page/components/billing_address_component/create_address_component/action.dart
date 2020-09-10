import 'package:fish_redux/fish_redux.dart';
import 'package:movie/models/country_phone_code.dart';

enum CreateAddressAction { action, setRegion, save, delete, loading }

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

  static Action onDelete() {
    return const Action(CreateAddressAction.delete);
  }

  static Action onLoading(bool loading) {
    return Action(CreateAddressAction.loading, payload: loading);
  }
}
