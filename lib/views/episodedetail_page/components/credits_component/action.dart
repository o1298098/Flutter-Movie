import 'package:fish_redux/fish_redux.dart';

enum CreditsAction { action, castTapped }

class CreditsActionCreator {
  static Action onAction() {
    return const Action(CreditsAction.action);
  }

  static Action onCastTapped(
      int peopleid, String profilePath, String profileName, String character) {
    return Action(CreditsAction.castTapped,
        payload: [peopleid, profilePath, profileName, character]);
  }
}
