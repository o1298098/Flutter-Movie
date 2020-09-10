import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/widgets/customcliper_path.dart';
import 'state.dart';

Widget buildView(
    AccountPageState state, Dispatch dispatch, ViewService viewService) {
  return Builder(
    builder: (context) {
      return Scaffold(
        key: state.scafoldState,
        body: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Stack(
              children: <Widget>[
                const _BackGround(),
                SafeArea(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: Adapt.px(60)),
                      viewService.buildComponent('header'),
                      SizedBox(height: Adapt.px(50)),
                      viewService.buildComponent('body'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

class _BackGround extends StatelessWidget {
  const _BackGround();
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomCliperPath(
        height: Adapt.px(380),
        width: Adapt.screenW(),
        radius: Adapt.px(2000),
      ),
      child: Container(
        height: Adapt.px(380),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              const Color(0xFF6495ED),
              const Color(0xFF6A5ACD),
            ],
            stops: <double>[0.0, 1.0],
          ),
        ),
      ),
    );
  }
}
