import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';

class LoadingLayout extends StatelessWidget {
  final String title;
  final bool show;
  const LoadingLayout({this.show, @required this.title});
  @override
  Widget build(BuildContext context) {
    return show
        ? Material(
            color: Colors.transparent,
            child: Container(
              width: Adapt.screenW(),
              height: Adapt.screenH(),
              color: const Color(0x20000000),
              child: Center(
                child: Container(
                  width: Adapt.px(300),
                  height: Adapt.px(300),
                  decoration: BoxDecoration(
                    color: const Color(0xAA000000),
                    borderRadius: BorderRadius.circular(
                      Adapt.px(20),
                    ),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(const Color(0xFFFFFFFF)),
                        ),
                        SizedBox(height: Adapt.px(30)),
                        Text(
                          title,
                          style: TextStyle(
                            color: const Color(0xFFFFFFFF),
                            fontSize: 14,
                          ),
                        )
                      ]),
                ),
              ),
            ),
          )
        : SizedBox();
  }
}
