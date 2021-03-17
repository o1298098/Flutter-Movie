import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/creditcard_verify.dart';
import 'package:movie/widgets/loading_layout.dart';
import 'package:movie/style/themestyle.dart';
import 'dart:math' as math;

import 'action.dart';
import 'state.dart';

Widget buildView(
    CreateCardState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: _theme.primaryColorDark,
            appBar: AppBar(
              backgroundColor: _theme.primaryColorDark,
              brightness: _theme.brightness,
              iconTheme: _theme.iconTheme,
              elevation: 0.0,
              centerTitle: false,
              title: Text(
                'Add Card',
                style: TextStyle(color: _theme.textTheme.bodyText1.color),
              ),
              actions: [
                _ScanButton(
                  onTap: () => dispatch(CreateCardActionCreator.scan()),
                )
              ],
            ),
            body: Container(
              margin: EdgeInsets.only(top: Adapt.px(20)),
              decoration: BoxDecoration(
                color: _theme.backgroundColor,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(Adapt.px(60)),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Adapt.px(430)),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: Adapt.px(40), vertical: Adapt.px(50)),
                    child: Text(
                      'Type in your card details:',
                      style: TextStyle(
                          fontSize: Adapt.px(45), fontWeight: FontWeight.w600),
                    ),
                  ),
                  _InputPanel(
                    cardNumberController: state.cardNumberController,
                    holderNameController: state.holderNameController,
                    expriedDateController: state.expriedDateController,
                    cvvController: state.cvvController,
                    swiperController: state.swiperController,
                    cardNumberFocusNode: state.cardNumberFocusNode,
                    holderNameFocusNode: state.holderNameFocusNode,
                    expriedDaterFocusNode: state.expriedDaterFocusNode,
                    cvvFocusNode: state.cvvFocusNode,
                    onSubmitted: () =>
                        dispatch(CreateCardActionCreator.nextTapped()),
                  ),
                  SizedBox(height: Adapt.px(10)),
                  _ButtonGroup(
                    currectIndex: state.inputIndex,
                    onBackPressed: () =>
                        dispatch(CreateCardActionCreator.backTapped()),
                    onNextPressed: () =>
                        dispatch(CreateCardActionCreator.nextTapped()),
                  )
                ],
              ),
            ),
          ),
          Container(
              padding: EdgeInsets.only(top: Adapt.padTopH() + Adapt.px(180)),
              child: Material(
                color: null,
                child: _CardCell(
                  controller: state.animationController,
                  cardNumberController: state.cardNumberController,
                  holderNameController: state.holderNameController,
                  expriedDateController: state.expriedDateController,
                  cvvController: state.cvvController,
                ),
              )),
          LoadingLayout(
            title: 'Saving',
            show: state.loading,
          )
        ],
      );
    },
  );
}

class _ScanButton extends StatelessWidget {
  final Function onTap;
  const _ScanButton({this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: Adapt.px(120),
        height: Adapt.px(50),
        decoration: BoxDecoration(
            color: _theme.backgroundColor,
            borderRadius: BorderRadius.circular(Adapt.px(25))),
        margin: EdgeInsets.only(
            right: Adapt.px(40), top: Adapt.px(15), bottom: Adapt.px(15)),
        child: Icon(
          Icons.camera_alt,
          color: const Color(0xFFA0A0A0),
        ),
      ),
    );
  }
}

class _CardCell extends StatelessWidget {
  final AnimationController controller;
  final TextEditingController cardNumberController;
  final TextEditingController holderNameController;
  final TextEditingController expriedDateController;
  final TextEditingController cvvController;
  const _CardCell(
      {this.controller,
      this.cardNumberController,
      this.expriedDateController,
      this.holderNameController,
      this.cvvController});
  @override
  Widget build(BuildContext context) {
    final animation = Tween<double>(begin: 0, end: 180.0).animate(
        CurvedAnimation(
            parent: controller, curve: Interval(0, 1, curve: Curves.ease)));
    return AnimatedBuilder(
        animation: animation,
        builder: (_, __) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
            child: Transform(
              alignment: Alignment.center,
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.0025)
                ..rotateY(math.pi * animation.value / 180),
              child: animation.value < 90
                  ? _CardFrontPanel(
                      controller: controller,
                      cardNumberController: cardNumberController,
                      holderNameController: holderNameController,
                      expriedDateController: expriedDateController,
                    )
                  : _CardBackPanel(
                      cardNumberController: cardNumberController,
                      cvvController: cvvController,
                    ),
            ),
          );
        });
  }
}

class _CardFrontPanel extends StatefulWidget {
  final AnimationController controller;
  final TextEditingController cardNumberController;
  final TextEditingController holderNameController;
  final TextEditingController expriedDateController;
  const _CardFrontPanel({
    this.controller,
    this.cardNumberController,
    this.expriedDateController,
    this.holderNameController,
  });
  @override
  _CardFrontPanelState createState() => _CardFrontPanelState();
}

class _CardFrontPanelState extends State<_CardFrontPanel> {
  String _cardNumber = 'XXXXXXXXXXXXXXXX';
  String _hoster = 'XXX XXX';
  String _expried = 'MMYY';
  String _cardType = '-';
  final CreditCardVerify _cardVerify = CreditCardVerify();

  final _creditCardTheme = {
    'Visa': ['images/visa_logo.png', const Color(0xFF8085C1)],
    'JCB': ['images/jcb_logo.png', const Color(0xFFE394A2)],
    'Discover': ['images/discover_logo.png', const Color(0XFF66AA9E)],
    'MasterCard': ['images/mastercard_logo.png', const Color(0xFF252529)],
    '-': ['images/visa_logo.png', const Color(0xFF556677)],
  };
  @override
  void initState() {
    _setCreditCardNumber();
    _setHolder();
    _setExpriedDate();
    widget.cardNumberController.addListener(_setCreditCardNumber);
    widget.holderNameController.addListener(_setHolder);
    widget.expriedDateController.addListener(_setExpriedDate);
    super.initState();
  }

  @override
  void dispose() {
    widget.cardNumberController.removeListener(_setCreditCardNumber);
    widget.holderNameController.removeListener(_setHolder);
    widget.expriedDateController.removeListener(_setExpriedDate);
    super.dispose();
  }

  _setCreditCardNumber() {
    if (widget.cardNumberController.text.isEmpty)
      _cardNumber = 'XXXXXXXXXXXXXXXX';
    else {
      String _text = widget.cardNumberController.text;
      int _lenght = _text.length;
      if (_lenght < 16) {
        for (int i = 0; i < 16 - _lenght; i++) {
          _text = _text + 'X';
        }
      }
      _cardNumber = _text;
      _cardType = _cardVerify.verify(widget.cardNumberController.text);
    }
    setState(() {});
  }

  _setHolder() {
    if (widget.holderNameController.text.isEmpty)
      _hoster = 'XXX XXX';
    else
      _hoster = widget.holderNameController.text;
    setState(() {});
  }

  _setExpriedDate() {
    if (widget.expriedDateController.text.isEmpty)
      _expried = 'MMYY';
    else {
      int _lenght = widget.expriedDateController.text.length;
      String _text = widget.expriedDateController.text;
      if (_lenght < 4) {
        for (int i = 0; i < 4 - _lenght; i++) {
          if (_lenght + i < 2)
            _text = _text + 'M';
          else
            _text = _text + 'Y';
        }
      }
      _expried = _text;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Stack(children: [
      AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          child: Container(
            key: ValueKey('value$_cardType'),
            width: Adapt.screenW() - Adapt.px(80),
            height: Adapt.px(380),
            padding: EdgeInsets.all(Adapt.px(40)),
            alignment: Alignment.topRight,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  blurRadius: Adapt.px(20),
                  color: _theme.brightness == Brightness.light
                      ? _theme.primaryColorDark
                      : const Color(0x00000000),
                  offset: Offset(0, Adapt.px(10)),
                ),
              ],
              color: _creditCardTheme[_cardType][1],
              borderRadius: BorderRadius.circular(Adapt.px(30)),
            ),
            child: _cardType == '-'
                ? Container(
                    height: Adapt.px(60),
                    width: Adapt.px(60),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF667788),
                    ),
                  )
                : Image.asset(
                    _creditCardTheme[_cardType][0],
                    alignment: Alignment.centerRight,
                    width: Adapt.px(120),
                    height: Adapt.px(50),
                  ),
          )),
      Container(
          width: Adapt.screenW() - Adapt.px(80),
          height: Adapt.px(380),
          padding: EdgeInsets.all(Adapt.px(40)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: Adapt.px(50)),
              const Spacer(),
              Container(
                padding: EdgeInsets.all(Adapt.px(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _cardNumber.substring(0, 4),
                      style: TextStyle(
                          color: Color(0xFFFFFFFF), fontSize: Adapt.px(40)),
                    ),
                    Text(
                      _cardNumber.substring(4, 8),
                      style: TextStyle(
                          color: Color(0xFFFFFFFF), fontSize: Adapt.px(40)),
                    ),
                    Text(
                      _cardNumber.substring(8, 12),
                      style: TextStyle(
                          color: Color(0xFFFFFFFF), fontSize: Adapt.px(40)),
                    ),
                    Text(
                      _cardNumber.substring(12, 16),
                      style: TextStyle(
                          color: Color(0xFFFFFFFF), fontSize: Adapt.px(40)),
                    )
                  ],
                ),
              ),
              Expanded(child: SizedBox()),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Padding(
                    padding: EdgeInsets.only(left: Adapt.px(8)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HOLDER NAME',
                          style: TextStyle(
                              color: const Color(0xFFFFFFFF),
                              fontSize: Adapt.px(20)),
                        ),
                        SizedBox(height: Adapt.px(8)),
                        Text(
                          _hoster,
                          style: TextStyle(color: const Color(0xFFD0D0D0)),
                        )
                      ],
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'EXPRIED DATE',
                      style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: Adapt.px(20)),
                    ),
                    SizedBox(height: Adapt.px(8)),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${_expried.substring(0, 2)}/${_expried.substring(2, 4)}',
                            style: TextStyle(color: const Color(0xFFD0D0D0)),
                          )
                        ])
                  ],
                ),
              ]),
            ],
          ))
    ]);
  }
}

class _CardBackPanel extends StatefulWidget {
  final TextEditingController cardNumberController;
  final TextEditingController cvvController;
  const _CardBackPanel({this.cvvController, this.cardNumberController});
  @override
  _CardBackPanelState createState() => _CardBackPanelState();
}

class _CardBackPanelState extends State<_CardBackPanel> {
  String _cvv = 'XXX';
  final CreditCardVerify _cardVerify = CreditCardVerify();
  String _cardType;
  final _creditCardTheme = {
    'Visa': ['images/visa_logo.png', const Color(0xFF8085C1)],
    'JCB': ['images/jcb_logo.png', const Color(0xFFE394A2)],
    'Discover': ['images/discover_logo.png', const Color(0XFF66AA9E)],
    'MasterCard': ['images/mastercard_logo.png', const Color(0xFF252529)],
    '-': ['images/visa_logo.png', const Color(0xFF556677)],
  };
  @override
  void initState() {
    _cardType = _cardVerify.verify(widget.cardNumberController.text);
    _setCVV();
    widget.cvvController.addListener(_setCVV);
    super.initState();
  }

  @override
  void dispose() {
    widget.cvvController.removeListener(_setCVV);
    super.dispose();
  }

  _setCVV() {
    if (widget.cvvController.text.isEmpty)
      _cvv = 'XXX';
    else {
      int _lenght = widget.cvvController.text.length;
      String _text = widget.cvvController.text;
      if (_lenght < 3) {
        for (int i = 0; i < 3 - _lenght; i++) {
          _text = _text + 'X';
        }
      }
      _cvv = _text;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()..rotateY(math.pi),
      child: Container(
        width: Adapt.screenW() - Adapt.px(80),
        height: Adapt.px(380),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: Adapt.px(20),
                color: _theme.brightness == Brightness.light
                    ? _theme.primaryColorDark
                    : const Color(0x00000000),
                offset: Offset(0, Adapt.px(10)))
          ],
          color: _creditCardTheme[_cardType][1],
          borderRadius: BorderRadius.circular(Adapt.px(30)),
        ),
        child: Container(
          child: Column(children: [
            SizedBox(height: Adapt.px(40)),
            Container(
              height: Adapt.px(80),
              color: const Color(0xFF000000),
            ),
            SizedBox(height: Adapt.px(30)),
            Row(children: [
              SizedBox(width: Adapt.px(30)),
              Container(
                width: Adapt.screenW() - Adapt.px(350),
                height: Adapt.px(60),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(Adapt.px(10)),
                    ),
                    color: Color(0xFFD0D0D0)),
              ),
              Container(
                width: Adapt.px(80),
                height: Adapt.px(60),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(Adapt.px(10))),
                  color: Color(0xFFFFFFFF),
                ),
                child: Center(child: Text(_cvv)),
              ),
            ]),
            Expanded(child: SizedBox()),
            Container(
              padding: EdgeInsets.only(right: Adapt.px(30)),
              alignment: Alignment.topRight,
              child: Image.asset(
                _creditCardTheme[_cardType][0],
                alignment: Alignment.centerRight,
                height: Adapt.px(50),
                width: Adapt.px(120),
              ),
            ),
            SizedBox(height: Adapt.px(30))
          ]),
        ),
      ),
    );
  }
}

class _InputPanel extends StatelessWidget {
  final TextEditingController cardNumberController;
  final TextEditingController holderNameController;
  final TextEditingController expriedDateController;
  final TextEditingController cvvController;

  final FocusNode cardNumberFocusNode;
  final FocusNode holderNameFocusNode;
  final FocusNode expriedDaterFocusNode;
  final FocusNode cvvFocusNode;
  final SwiperController swiperController;
  final Function onSubmitted;
  const _InputPanel(
      {this.cardNumberController,
      this.cvvController,
      this.expriedDateController,
      this.holderNameController,
      this.swiperController,
      this.cardNumberFocusNode,
      this.cvvFocusNode,
      this.expriedDaterFocusNode,
      this.holderNameFocusNode,
      this.onSubmitted});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(190),
      child: Swiper(
        controller: swiperController,
        physics: NeverScrollableScrollPhysics(),
        viewportFraction: 0.9,
        loop: false,
        fade: 0.2,
        itemCount: 4,
        itemBuilder: (_, index) {
          Widget _child;
          switch (index) {
            case 0:
              _child = _CreditCardTextField(
                controller: cardNumberController,
                focusNode: cardNumberFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: onSubmitted,
              );
              break;
            case 1:
              _child = _CustomTextField(
                title: 'Holder Name',
                controller: holderNameController,
                focusNode: holderNameFocusNode,
                onSubmitted: onSubmitted,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z ]"))
                ],
              );
              break;
            case 2:
              _child = _CustomTextField(
                title: 'Expried Date',
                maxLength: 4,
                inputType: TextInputType.number,
                controller: expriedDateController,
                focusNode: expriedDaterFocusNode,
                textInputAction: TextInputAction.next,
                onSubmitted: onSubmitted,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d+'))
                ],
              );
              break;
            case 3:
              _child = _CustomTextField(
                title: 'CVV',
                maxLength: 3,
                inputType: TextInputType.number,
                controller: cvvController,
                focusNode: cvvFocusNode,
                onSubmitted: onSubmitted,
                textInputAction: TextInputAction.done,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'\d+'))
                ],
              );
              break;
            default:
              _child = SizedBox();
              break;
          }
          return _child;
        },
      ),
    );
  }
}

class _CustomTextField extends StatelessWidget {
  final String title;
  final double width;
  final int maxLength;
  final TextInputType inputType;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final List<TextInputFormatter> inputFormatters;
  final String errorText;
  final Function onSubmitted;
  const _CustomTextField(
      {this.title,
      this.width,
      this.controller,
      this.focusNode,
      this.maxLength,
      this.inputType,
      this.inputFormatters,
      this.textInputAction,
      this.onSubmitted,
      this.errorText});
  @override
  Widget build(BuildContext context) {
    final _intputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(Adapt.px(20)),
        borderSide: BorderSide(color: const Color(0xFF9E9E9E)));
    final _errorBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(Adapt.px(20)),
        borderSide: BorderSide(color: const Color(0xFFFF00000)));
    return Container(
      width: width ?? Adapt.screenW(),
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: TextStyle(
                  fontSize: Adapt.px(30), color: const Color(0xFF9E9E9E))),
          SizedBox(height: Adapt.px(20)),
          TextField(
            controller: controller,
            focusNode: focusNode,
            cursorColor: const Color(0xFF9E9E9E),
            maxLength: maxLength,
            keyboardType: inputType,
            inputFormatters: inputFormatters,
            textInputAction: textInputAction,
            //onSubmitted: (s) => onSubmitted,
            onEditingComplete: onSubmitted,
            decoration: InputDecoration(
              counter: SizedBox(),
              errorText: errorText,
              errorBorder: _errorBorder,
              focusedErrorBorder: _errorBorder,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: Adapt.px(30), vertical: Adapt.px(20)),
              enabledBorder: _intputBorder,
              disabledBorder: _intputBorder,
              focusedBorder: _intputBorder,
            ),
          ),
        ],
      ),
    );
  }
}

class _CreditCardTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputAction textInputAction;

  final Function onSubmitted;

  const _CreditCardTextField(
      {this.controller,
      this.focusNode,
      this.textInputAction,
      this.onSubmitted});
  @override
  _CreditCardTextFieldState createState() => _CreditCardTextFieldState();
}

class _CreditCardTextFieldState extends State<_CreditCardTextField> {
  final CreditCardVerify _cardVerify = CreditCardVerify();
  bool error;
  @override
  void initState() {
    error = false;
    widget.controller.addListener(_checkCardNumber);
    super.initState();
  }

  @override
  void dispose() {
    widget.controller.removeListener(_checkCardNumber);
    super.dispose();
  }

  _checkCardNumber() {
    error = _cardVerify.verify(widget.controller.text) == '-' &&
        widget.controller.text.length == 16;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return _CustomTextField(
      title: 'Card Number',
      maxLength: 16,
      inputType: TextInputType.number,
      controller: widget.controller,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction,
      onSubmitted: widget.onSubmitted,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'\d+'))],
      errorText: error ? 'invalid card number' : null,
    );
  }
}

class _ButtonGroup extends StatelessWidget {
  final int currectIndex;
  final Function onNextPressed;
  final Function onBackPressed;
  const _ButtonGroup(
      {this.currectIndex, this.onBackPressed, this.onNextPressed});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        currectIndex != 0
            ? GestureDetector(
                onTap: onBackPressed,
                child: Container(
                  height: Adapt.px(80),
                  width: Adapt.px(80),
                  margin: EdgeInsets.only(left: Adapt.px(60)),
                  decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFE0E0E0)),
                      borderRadius: BorderRadius.circular(Adapt.px(20))),
                  child: Icon(
                    Icons.chevron_left,
                    color: const Color(0xFFE0E0E0),
                  ),
                ),
              )
            : SizedBox(),
        Expanded(child: SizedBox()),
        GestureDetector(
          onTap: onNextPressed,
          child: Container(
            height: Adapt.px(80),
            width: Adapt.px(120),
            margin: EdgeInsets.only(right: Adapt.px(60)),
            decoration: BoxDecoration(
              color: Color(0xFF303030),
              borderRadius: BorderRadius.circular(Adapt.px(20)),
            ),
            child: Center(
              child: Text(
                currectIndex != 3 ? 'Next' : 'Done',
                style: TextStyle(color: const Color(0xFFFFFFFF)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
