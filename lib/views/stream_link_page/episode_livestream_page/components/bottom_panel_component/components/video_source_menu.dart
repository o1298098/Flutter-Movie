import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/models/base_api_model/tvshow_stream_link.dart';
import 'package:movie/style/themestyle.dart';

import 'arrow_clipper.dart';

class VideoSourceMenu extends StatelessWidget {
  final List<TvShowStreamLink> links;
  final Function(TvShowStreamLink) onTap;
  const VideoSourceMenu({this.links, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    final double _width = 160;
    final double _arrowSize = 20.0;
    final double _menuHeight = 200.0;
    return Positioned(
      bottom: 80,
      left: Adapt.px(275) - _width / 2,
      width: _width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ClipPath(
                  clipper: ArrowClipper(),
                  child: Container(
                    width: _arrowSize,
                    height: _arrowSize,
                    color: _backGroundColor,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Container(
                height: _menuHeight,
                decoration: BoxDecoration(
                  color: _backGroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: links.length > 0
                    ? ListView.separated(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        separatorBuilder: (_, __) =>
                            Divider(color: const Color(0xFF505050)),
                        itemBuilder: (_, index) => _LinkCell(
                          data: links[index],
                          onTap: onTap,
                        ),
                        itemCount: links.length,
                      )
                    : Center(
                        child: SizedBox(
                          width: 120,
                          child: FlatButton(
                            onPressed: () {},
                            child: Text(
                              'request stream link',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: const Color(0xFFFFFFFF)),
                            ),
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LinkCell extends StatelessWidget {
  final TvShowStreamLink data;
  final Function(TvShowStreamLink) onTap;
  const _LinkCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(data),
      child: Container(
        height: Adapt.px(50),
        child: Row(
          children: [
            Text(
              data.language.name,
              style: TextStyle(color: const Color(0xFFFFFFFF)),
            ),
            Spacer(),
            Text(
              data.quality.name,
              style: TextStyle(color: const Color(0xFFFFFFFF)),
            ),
          ],
        ),
      ),
    );
  }
}
