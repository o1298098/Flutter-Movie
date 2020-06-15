import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';

class LinearGradientProgressIndicator extends StatelessWidget {
  final double value;
  final double width;
  final List<Color> colors;
  const LinearGradientProgressIndicator(
      {this.value,
      this.width = 80,
      this.colors = const [
        const Color(0xFF90CAF9),
        const Color(0xFFE1BEE7),
      ]})
      : assert(colors.length > 0 && colors != null),
        assert(value != null && value <= 1);
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return Container(
      width: width + Adapt.px(12),
      height: Adapt.px(22),
      padding: EdgeInsets.all(Adapt.px(6)),
      decoration: BoxDecoration(
          color: _theme.brightness == Brightness.light
              ? const Color(0xFFF0F0F0)
              : const Color(0xFF606060),
          borderRadius: BorderRadius.circular(Adapt.px(11))),
      child: Row(children: [
        Container(
          width: value * width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: colors),
            borderRadius: BorderRadius.circular(
              Adapt.px(7.5),
            ),
          ),
        )
      ]),
    );
  }
}
