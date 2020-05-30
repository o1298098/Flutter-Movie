import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'dart:math' as math;

import 'action.dart';
import 'state.dart';

Widget buildView(
    CreateCardState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      final _theme = ThemeStyle.getTheme(context);
      return Scaffold(
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
            IconButton(
                icon: Icon(
                  Icons.camera_alt,
                  color: const Color(0xFF9E9E9E),
                ),
                onPressed: () {})
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
              SizedBox(height: Adapt.px(100)),
              _CardCell(
                controller: state.animationController,
                cardNumberController: state.cardNumberController,
                hosterNameController: state.hosterNameController,
                expriedDateController: state.expriedDateController,
                cvvController: state.cvvController,
              ),
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
                hosterNameController: state.hosterNameController,
                expriedDateController: state.expriedDateController,
                cvvController: state.cvvController,
                swiperController: state.swiperController,
              ),
              SizedBox(height: Adapt.px(30)),
              Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      dispatch(CreateCardActionCreator.nextTapped());
                    },
                    child: Container(
                        height: Adapt.px(80),
                        width: Adapt.px(120),
                        margin: EdgeInsets.only(right: Adapt.px(60)),
                        decoration: BoxDecoration(
                            color: Color(0xFF303030),
                            borderRadius: BorderRadius.circular(Adapt.px(20))),
                        child: Center(
                            child: Text(
                          'Next',
                          style: TextStyle(color: const Color(0xFFFFFFFF)),
                        ))),
                  ))
            ],
          ),
        ),
      );
    },
  );
}

class _CardCell extends StatelessWidget {
  final AnimationController controller;
  final TextEditingController cardNumberController;
  final TextEditingController hosterNameController;
  final TextEditingController expriedDateController;
  final TextEditingController cvvController;
  const _CardCell(
      {this.controller,
      this.cardNumberController,
      this.expriedDateController,
      this.hosterNameController,
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
                      hosterNameController: hosterNameController,
                      expriedDateController: expriedDateController,
                    )
                  : _CardBackPanel(
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
  final TextEditingController hosterNameController;
  final TextEditingController expriedDateController;
  const _CardFrontPanel(
      {this.controller,
      this.cardNumberController,
      this.expriedDateController,
      this.hosterNameController});
  @override
  _CardFrontPanelState createState() => _CardFrontPanelState();
}

class _CardFrontPanelState extends State<_CardFrontPanel> {
  String _cardNumber = 'XXXXXXXXXXXXXXXX';
  String _hoster = 'XXX XXX';
  String _expried = 'MMYY';
  @override
  void initState() {
    _setCreditCardNumber();
    _setHoster();
    _setExpriedDate();
    widget.cardNumberController.addListener(_setCreditCardNumber);
    widget.hosterNameController.addListener(_setHoster);
    widget.expriedDateController.addListener(_setExpriedDate);
    super.initState();
  }

  @override
  void dispose() {
    widget.cardNumberController.removeListener(_setCreditCardNumber);
    widget.hosterNameController.removeListener(_setHoster);
    widget.expriedDateController.removeListener(_setExpriedDate);
    super.dispose();
  }

  _setCreditCardNumber() {
    if (widget.cardNumberController.text.isEmpty)
      _cardNumber = 'XXXXXXXXXXXXXXXX';
    else {
      int _lenght = widget.cardNumberController.text.length;
      String _text = widget.cardNumberController.text;
      if (_lenght < 16) {
        for (int i = 0; i < 16 - _lenght; i++) {
          _text = _text + 'X';
        }
      }
      _cardNumber = _text;
    }
    setState(() {});
  }

  _setHoster() {
    if (widget.cardNumberController.text.isEmpty)
      _hoster = 'XXX XXX';
    else
      _hoster = widget.hosterNameController.text;
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
    return Container(
        width: Adapt.screenW() - Adapt.px(80),
        height: Adapt.px(380),
        padding: EdgeInsets.all(Adapt.px(40)),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: Adapt.px(20),
              color: _theme.primaryColorDark,
              offset: Offset(0, Adapt.px(10)),
            ),
          ],
          color: const Color(0xFF252529),
          borderRadius: BorderRadius.circular(Adapt.px(30)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Image.asset(
              'images/mastercard_logo.png',
              width: Adapt.px(80),
            ),
            Spacer(),
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
                        'HOSTER NAME',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF), fontSize: Adapt.px(20)),
                      ),
                      SizedBox(height: Adapt.px(8)),
                      Text(
                        _hoster,
                        style: TextStyle(color: Color(0xFF9E9E9E)),
                      )
                    ],
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'EXPRIED DATE',
                    style: TextStyle(
                        color: Color(0xFFFFFFFF), fontSize: Adapt.px(20)),
                  ),
                  SizedBox(height: Adapt.px(8)),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${_expried.substring(0, 2)}/${_expried.substring(2, 4)}',
                          style: TextStyle(color: Color(0xFF9E9E9E)),
                        )
                      ])
                ],
              ),
            ]),
          ],
        ));
  }
}

class _CardBackPanel extends StatefulWidget {
  final TextEditingController cvvController;
  const _CardBackPanel({this.cvvController});
  @override
  _CardBackPanelState createState() => _CardBackPanelState();
}

class _CardBackPanelState extends State<_CardBackPanel> {
  String _cvv = 'XXX';

  @override
  void initState() {
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
                color: Colors.grey,
                offset: Offset(0, Adapt.px(10)))
          ],
          color: const Color(0xFF252529),
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
                        left: Radius.circular(Adapt.px(10))),
                    color: Color(0xFF9E9E9E)),
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
                'images/mastercard_logo.png',
                width: Adapt.px(80),
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
  final TextEditingController hosterNameController;
  final TextEditingController expriedDateController;
  final TextEditingController cvvController;
  final SwiperController swiperController;
  const _InputPanel(
      {this.cardNumberController,
      this.cvvController,
      this.expriedDateController,
      this.hosterNameController,
      this.swiperController});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Adapt.px(160),
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
              _child = _CustomTextField(
                title: 'Card Number',
                maxLength: 16,
                inputType: TextInputType.number,
                controller: cardNumberController,
              );
              break;
            case 1:
              _child = _CustomTextField(
                title: 'Hoster Name',
                controller: hosterNameController,
              );
              break;
            case 2:
              _child = _CustomTextField(
                title: 'Expried date',
                maxLength: 4,
                inputType: TextInputType.datetime,
                controller: expriedDateController,
              );
              break;
            case 3:
              _child = _CustomTextField(
                title: 'CVV',
                maxLength: 3,
                inputType: TextInputType.number,
                controller: cvvController,
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
  const _CustomTextField(
      {this.title,
      this.width,
      this.controller,
      this.maxLength,
      this.inputType});
  @override
  Widget build(BuildContext context) {
    final _intputBorder = OutlineInputBorder(
        borderRadius: BorderRadius.circular(Adapt.px(20)),
        borderSide: BorderSide(color: const Color(0xFF9E9E9E)));
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
            cursorColor: const Color(0xFF9E9E9E),
            maxLength: maxLength,
            keyboardType: inputType,
            decoration: InputDecoration(
              counter: SizedBox(),
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
