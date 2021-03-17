import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/customcliper_path.dart';
import 'package:movie/models/country_phone_code.dart';
import 'package:movie/style/themestyle.dart';
import 'package:toast/toast.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    LoginPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    resizeToAvoidBottomInset: false,
    body: Stack(
      children: <Widget>[
        _BackGround(controller: state.animationController),
        _LoginBody(
          animationController: state.animationController,
          submitAnimationController: state.submitAnimationController,
          emailLogin: state.emailLogin,
          accountFocusNode: state.accountFocusNode,
          pwdFocusNode: state.pwdFocusNode,
          accountTextController: state.accountTextController,
          passWordTextController: state.passWordTextController,
          phoneTextController: state.phoneTextController,
          codeTextContraller: state.codeTextContraller,
          countryCode: state.countryCode,
          countryCodes: state.countryCodes,
          dispatch: dispatch,
        ),
        _AppBar(),
      ],
    ),
  );
}

class _BackGround extends StatelessWidget {
  final AnimationController controller;
  const _BackGround({this.controller});
  @override
  Widget build(BuildContext context) {
    final double headerHeight = Adapt.screenH() / 3;
    return Column(children: [
      ClipPath(
        clipper: CustomCliperPath(
            height: headerHeight,
            width: Adapt.screenW(),
            radius: Adapt.px(1000)),
        child: Container(
            height: headerHeight,
            width: Adapt.screenW(),
            decoration: BoxDecoration(
                color: Colors.black87,
                image: DecorationImage(
                    colorFilter:
                        ColorFilter.mode(Colors.black, BlendMode.color),
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(
                        'https://image.tmdb.org/t/p/original/mAkPFEWkwKz9nmKyCiuETfTdpgX.jpg'))),
            alignment: Alignment.center,
            child: Container(
              color: Color.fromRGBO(20, 20, 20, 0.8),
              alignment: Alignment.center,
              height: headerHeight,
              width: Adapt.screenW(),
              child: SlideTransition(
                  position: Tween(begin: Offset(0, -1), end: Offset.zero)
                      .animate(CurvedAnimation(
                    parent: controller,
                    curve: Interval(
                      0.0,
                      0.4,
                      curve: Curves.ease,
                    ),
                  )),
                  child: Image.asset(
                    'images/tmdb_blue.png',
                    width: Adapt.px(150),
                    height: Adapt.px(150),
                    color: Colors.white,
                  )),
            )),
      ),
      Expanded(child: SizedBox()),
      Container(
          height: Adapt.px(200),
          width: Adapt.screenW(),
          padding: EdgeInsets.only(bottom: Adapt.px(20)),
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: controller,
                  curve: Interval(
                    0.7,
                    1.0,
                    curve: Curves.ease,
                  ),
                )),
                child: Text('Powered by The Movie DB')),
          )),
    ]);
  }
}

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0.0,
      left: 0.0,
      right: 0.0,
      child: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
    );
  }
}

class _EmailEntry extends StatelessWidget {
  final AnimationController controller;
  final TextEditingController accountTextController;
  final TextEditingController passWordTextController;
  final FocusNode accountFocusNode;
  final FocusNode pwdFocusNode;
  final Function(String) onSubmit;
  const _EmailEntry(
      {this.controller,
      this.accountFocusNode,
      this.pwdFocusNode,
      this.accountTextController,
      this.passWordTextController,
      this.onSubmit});
  @override
  Widget build(BuildContext context) {
    final accountCurve = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.3,
        0.5,
        curve: Curves.ease,
      ),
    );
    final passwordCurve = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.ease,
      ),
    );
    final _theme = ThemeStyle.getTheme(context);

    return Column(children: [
      SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset.zero).animate(accountCurve),
        child: FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0).animate(accountCurve),
            child: Padding(
              padding: EdgeInsets.all(Adapt.px(40)),
              child: TextField(
                focusNode: accountFocusNode,
                controller: accountTextController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                style: TextStyle(fontSize: Adapt.px(35)),
                cursorColor: _theme.iconTheme.color,
                decoration: InputDecoration(
                    fillColor: Colors.transparent,
                    hintText: 'Account',
                    floatingLabelBehavior: FloatingLabelBehavior.auto,
                    filled: true,
                    prefixStyle: TextStyle(fontSize: Adapt.px(35)),
                    focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(color: Colors.black87))),
                onSubmitted: (s) {
                  accountFocusNode.nextFocus();
                },
              ),
            )),
      ),
      SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset.zero).animate(passwordCurve),
        child: FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(passwordCurve),
          child: Padding(
            padding: EdgeInsets.all(Adapt.px(40)),
            child: TextField(
              focusNode: pwdFocusNode,
              controller: passWordTextController,
              style: TextStyle(fontSize: Adapt.px(35)),
              cursorColor: _theme.iconTheme.color,
              obscureText: true,
              decoration: InputDecoration(
                  fillColor: Colors.transparent,
                  hintText: 'PassWord',
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  filled: true,
                  prefixStyle: TextStyle(fontSize: Adapt.px(35)),
                  focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(color: Colors.black87))),
              onSubmitted: onSubmit,
            ),
          ),
        ),
      ),
    ]);
  }
}

class _PhoneNumberEntry extends StatelessWidget {
  final TextEditingController phoneTextController;
  final TextEditingController codeTextContraller;
  final List<CountryPhoneCode> countryCodes;
  final String countryCode;
  final Function(String) countryCodeTap;
  final Function sendVerificationCode;
  const _PhoneNumberEntry(
      {this.phoneTextController,
      this.codeTextContraller,
      this.countryCodeTap,
      this.countryCode,
      this.countryCodes,
      this.sendVerificationCode});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Adapt.px(40)),
      child: Column(children: [
        SizedBox(height: Adapt.px(40)),
        TextField(
          controller: phoneTextController,
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            hintText: 'Phone Number',
            prefixIcon: InkWell(
                onTap: () => showDialog(
                    context: context,
                    builder: (_) => _CountryCodeDialog(
                          countries: countryCodes,
                          onCellTap: countryCodeTap,
                        )),
                child: SizedBox(
                  width: Adapt.px(60),
                  child: Center(
                    child: Text(
                      countryCode,
                    ),
                  ),
                )),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            filled: true,
            prefixStyle: TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
            ),
          ),
        ),
        SizedBox(height: Adapt.px(80)),
        Theme(
          child: TextField(
            controller: codeTextContraller,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            cursorColor: Colors.black,
            decoration: InputDecoration(
              fillColor: Colors.transparent,
              hintText: 'Verification Code',
              prefixIcon: Icon(Icons.sms),
              suffixIcon: _SmsSendCell(
                phone: phoneTextController,
                onPress: sendVerificationCode,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.auto,
              filled: true,
              prefixStyle:
                  TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black87),
              ),
            ),
          ),
          data: Theme.of(context).copyWith(
            primaryColor: Colors.black87,
          ),
        ),
        SizedBox(height: Adapt.px(40))
      ]),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final AnimationController controller;
  final Function onSubimt;
  const _SubmitButton({this.controller, this.onSubimt});
  @override
  Widget build(BuildContext context) {
    final submitWidth = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.0,
        0.5,
        curve: Curves.ease,
      ),
    );
    final loadCurved = CurvedAnimation(
      parent: controller,
      curve: Interval(
        0.5,
        1.0,
        curve: Curves.ease,
      ),
    );
    return AnimatedBuilder(
      animation: controller,
      builder: (ctx, w) {
        double buttonWidth = Adapt.screenW() * 0.8;
        return Container(
          margin: EdgeInsets.only(top: Adapt.px(60)),
          height: Adapt.px(100),
          child: Stack(
            children: <Widget>[
              Container(
                height: Adapt.px(100),
                width: Tween<double>(begin: buttonWidth, end: Adapt.px(100))
                    .animate(submitWidth)
                    .value,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(Adapt.px(50)),
                    ),
                  ),
                  child: Text('Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: Tween<double>(begin: Adapt.px(35), end: 0.0)
                              .animate(submitWidth)
                              .value)),
                  onPressed: onSubimt,
                ),
              ),
              ScaleTransition(
                scale: Tween(begin: 0.0, end: 1.0).animate(loadCurved),
                child: Container(
                  width: Adapt.px(100),
                  height: Adapt.px(100),
                  padding: EdgeInsets.all(Adapt.px(20)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(50))),
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

class _LoginBody extends StatelessWidget {
  final Dispatch dispatch;
  final AnimationController animationController;
  final AnimationController submitAnimationController;
  final TextEditingController phoneTextController;
  final TextEditingController codeTextContraller;
  final TextEditingController accountTextController;
  final TextEditingController passWordTextController;
  final FocusNode accountFocusNode;
  final FocusNode pwdFocusNode;
  final List<CountryPhoneCode> countryCodes;
  final String countryCode;
  final bool emailLogin;
  const _LoginBody(
      {this.accountFocusNode,
      this.accountTextController,
      this.animationController,
      this.codeTextContraller,
      this.dispatch,
      this.emailLogin,
      this.passWordTextController,
      this.phoneTextController,
      this.pwdFocusNode,
      this.submitAnimationController,
      this.countryCode,
      this.countryCodes});
  @override
  Widget build(BuildContext context) {
    final cardCurve = CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0,
        0.4,
        curve: Curves.ease,
      ),
    );
    final submitCurve = CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.5,
        0.7,
        curve: Curves.ease,
      ),
    );

    return Center(
      child: SlideTransition(
        position:
            Tween(begin: Offset(0, 1), end: Offset.zero).animate(cardCurve),
        child: Card(
          elevation: 10,
          child: Container(
            height: Adapt.screenH() / 2,
            width: Adapt.screenW() * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                /*IndexedStack(
                  index: state.emailLogin ? 0 : 1,
                  children: <Widget>[
                    _buildEmailEntry(),
                    _buildPhoneNumberEntry(),
                  ],
                ),*/
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  child: emailLogin
                      ? _EmailEntry(
                          onSubmit: (s) =>
                              dispatch(LoginPageActionCreator.onLoginClicked()),
                          controller: animationController,
                          accountFocusNode: accountFocusNode,
                          pwdFocusNode: pwdFocusNode,
                          accountTextController: accountTextController,
                          passWordTextController: passWordTextController,
                        )
                      : _PhoneNumberEntry(
                          phoneTextController: phoneTextController,
                          codeTextContraller: codeTextContraller,
                          countryCode: countryCode,
                          countryCodes: countryCodes,
                          sendVerificationCode: () => dispatch(
                              LoginPageActionCreator.sendVerificationCode()),
                          countryCodeTap: (str) => dispatch(
                              LoginPageActionCreator.countryCodeChange(str)),
                        ),
                ),
                SlideTransition(
                    position: Tween(begin: Offset(0, 1), end: Offset.zero)
                        .animate(submitCurve),
                    child: FadeTransition(
                      opacity: Tween(begin: 0.0, end: 1.0).animate(submitCurve),
                      child: _SubmitButton(
                        controller: submitAnimationController,
                        onSubimt: () =>
                            dispatch(LoginPageActionCreator.onLoginClicked()),
                      ),
                    )),
                Container(
                    padding: EdgeInsets.fromLTRB(
                        Adapt.px(50), Adapt.px(20), Adapt.px(50), Adapt.px(20)),
                    alignment: Alignment.centerRight,
                    child: FadeTransition(
                      opacity:
                          Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                        parent: animationController,
                        curve: Interval(
                          0.7,
                          1.0,
                          curve: Curves.ease,
                        ),
                      )),
                      child: GestureDetector(
                        onTap: () =>
                            dispatch(LoginPageActionCreator.onSignUp()),
                        child: Text(
                          'Sign up for an account',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )),
                Container(
                  alignment: Alignment.bottomRight,
                  height: Adapt.px(120),
                  child: FadeTransition(
                    opacity:
                        Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                      parent: animationController,
                      curve: Interval(
                        0.7,
                        1.0,
                        curve: Curves.ease,
                      ),
                    )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          onTap: () => dispatch(
                              LoginPageActionCreator.switchLoginMode()),
                          child: Image.asset(
                            emailLogin
                                ? 'images/phone_sms.png'
                                : 'images/email_login.png',
                            width: Adapt.px(50),
                          ),
                        ),
                        SizedBox(width: Adapt.px(20)),
                        InkWell(
                          onTap: () =>
                              dispatch(LoginPageActionCreator.onGoogleSignIn()),
                          child: Image.asset(
                            'images/google.png',
                            width: Adapt.px(50),
                          ),
                        ),
                        SizedBox(width: Adapt.px(20)),
                        Icon(
                          FontAwesomeIcons.facebook,
                          color: Colors.blue[700],
                          size: Adapt.px(45),
                        ),
                        SizedBox(width: Adapt.px(50)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SmsSendCell extends StatefulWidget {
  final Function onPress;
  final TextEditingController phone;
  const _SmsSendCell({this.phone, this.onPress});
  @override
  _SmsSendCellState createState() => _SmsSendCellState();
}

class _SmsSendCellState extends State<_SmsSendCell> {
  bool _isWaiting = false;
  int _counter = 0;
  Timer _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return _isWaiting
        ? Container(
            width: Adapt.px(90),
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(vertical: Adapt.px(15)),
            padding: EdgeInsets.all(Adapt.px(10)),
            decoration: BoxDecoration(
                border: Border.all(color: _theme.iconTheme.color),
                borderRadius: BorderRadius.circular(Adapt.px(10))),
            child: Text('$_counter s'),
          )
        : InkWell(
            onTap: () {
              if (widget.phone.text.length > 8) {
                widget.onPress();
                _isWaiting = true;
                _counter = 60;
                setState(() {});
                _timer = Timer.periodic(Duration(seconds: 1), (timer) {
                  if (_counter > 1)
                    setState(() {
                      _counter--;
                    });
                  else {
                    _isWaiting = false;
                    setState(() {});
                    timer.cancel();
                  }
                });
              } else
                Toast.show('Invalid phone number', context,
                    gravity: Toast.CENTER);
            },
            child: Icon(Icons.send));
  }
}

class _CountryCodeDialog extends StatefulWidget {
  final List<CountryPhoneCode> countries;
  final Function(String) onCellTap;
  const _CountryCodeDialog({@required this.countries, this.onCellTap});
  @override
  _CountryCodeDialogState createState() => _CountryCodeDialogState();
}

class _CountryCodeDialogState extends State<_CountryCodeDialog> {
  final _width = Adapt.screenW() - Adapt.px(80);
  List<CountryPhoneCode> _countries;
  TextEditingController _controller;
  @override
  void initState() {
    _countries = widget.countries;
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(30))),
      contentPadding: EdgeInsets.zero,
      title: Theme(
        child: TextField(
          controller: _controller,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            fillColor: Colors.transparent,
            hintText: 'Search',
            prefixIcon: Icon(Icons.search),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            filled: true,
            prefixStyle: TextStyle(color: Colors.black, fontSize: Adapt.px(35)),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
            ),
          ),
          onChanged: (str) {
            _countries = widget.countries
                .where((e) => e.name.toUpperCase().contains(str.toUpperCase()))
                .toList();
            setState(() {});
          },
        ),
        data: Theme.of(context).copyWith(
          primaryColor: Colors.black87,
        ),
      ),
      children: <Widget>[
        Container(
          height: Adapt.screenH() / 2,
          width: _width,
          child: ListView.separated(
            padding: EdgeInsets.all(Adapt.px(40)),
            separatorBuilder: (_, __) => Divider(
              height: 25,
            ),
            itemCount: _countries.length,
            itemBuilder: (_, index) {
              final d = _countries[index];
              return _CountryCell(
                data: d,
                onTap: widget.onCellTap,
              );
            },
          ),
        )
      ],
    );
  }
}

class _CountryCell extends StatelessWidget {
  final CountryPhoneCode data;
  final Function(String) onTap;
  _CountryCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _width = Adapt.screenW() - Adapt.px(80);
    final _textStyle = TextStyle(fontSize: Adapt.px(28));
    return InkWell(
      key: ValueKey(data.name),
      onTap: () {
        onTap(data.dialCode);
        Navigator.of(context).pop();
      },
      child: Container(
        child: Row(
          children: <Widget>[
            Text(data.flag, style: _textStyle),
            SizedBox(width: Adapt.px(20)),
            Container(
              constraints: BoxConstraints(maxWidth: _width - Adapt.px(340)),
              child: Text(data.name, style: _textStyle),
            ),
            Text(' (${data.dialCode})', style: _textStyle),
          ],
        ),
      ),
    );
  }
}
