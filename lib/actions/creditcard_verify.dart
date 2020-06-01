class CreditCardVerify {
  final RegExp _visaExp = RegExp(r'^4[0-9]{6,}$');

  final RegExp _mastercardExp = RegExp(
      r'(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}');

  final RegExp _jcbExp = RegExp(r'(^3[0-9]{15}$)|(^(2131|1800)[0-9]{11}$)');

  final RegExp _discoverExp = RegExp(r'^6011-?\d{4}-?\d{4}-?\d{4}$');

  String verify(String text) {
    if (_visaExp.hasMatch(text)) {
      return 'Visa';
    } else if (_mastercardExp.hasMatch(text)) {
      return 'MasterCard';
    } else if (_jcbExp.hasMatch(text)) {
      return 'JCB';
    } else if (_discoverExp.hasMatch(text)) {
      return 'Discover';
    } else
      return '-';
  }
}
