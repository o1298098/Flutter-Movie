import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/arrow_clipper.dart';
import 'package:movie/widgets/host_dialog.dart';
import 'package:movie/widgets/language_dialog.dart';

class OptionMenu extends StatelessWidget {
  final bool useVideoSourceApi;
  final bool streamInBrowser;
  final String languageCode;
  final String host;
  final Function closeMenu;
  final Function(bool) onUseApiTap;
  final Function(bool) onStreamInBrowserTap;
  final Function(String) onLanguageSelected;
  final Function(String) onHostSelected;
  final Function reportTap;
  final Function streamLinkRequestTap;
  const OptionMenu({
    this.closeMenu,
    this.useVideoSourceApi = false,
    this.streamInBrowser = false,
    this.languageCode,
    this.host,
    this.onHostSelected,
    this.onLanguageSelected,
    this.onUseApiTap,
    this.onStreamInBrowserTap,
    this.reportTap,
    this.streamLinkRequestTap,
  });
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    final double _width = 260;
    final double _arrowSize = 20.0;
    return Positioned(
      bottom: 80,
      right: Adapt.px(40),
      width: _width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(right: Adapt.px(75)),
                alignment: Alignment.bottomRight,
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
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: _backGroundColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(children: [
                  _OptionItem(
                    onTap: () {
                      closeMenu();
                      showDialog(
                        context: context,
                        builder: (_) => HostDialog(
                          onSelected: onHostSelected,
                          selectedHost: host,
                        ),
                      );
                    },
                    icon: Icons.web,
                    title: 'Prefer Host',
                  ),
                  _OptionItem(
                    onTap: () {
                      closeMenu();
                      showDialog(
                        context: context,
                        builder: (_) => LanguageDialog(
                          onTap: onLanguageSelected,
                          selected: languageCode,
                        ),
                      );
                    },
                    icon: Icons.language,
                    title: 'Default Language',
                  ),
                  _OptionCheckItem(
                    icon: Icons.settings_applications,
                    title: 'VideoSource Api',
                    selected: useVideoSourceApi,
                    onTap: onUseApiTap,
                  ),
                  _OptionCheckItem(
                    icon: Icons.open_in_browser,
                    title: 'Stream in browser',
                    selected: streamInBrowser,
                    onTap: onStreamInBrowserTap,
                  ),
                  _OptionItem(
                    onTap: streamLinkRequestTap,
                    icon: Icons.link,
                    title: 'Request StreamLink',
                  ),
                  _OptionItem(
                    icon: Icons.flag,
                    title: 'Report',
                    onTap: reportTap,
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function onTap;
  const _OptionItem({@required this.title, @required this.icon, this.onTap});
  @override
  Widget build(BuildContext context) {
    final Color _baseColor = const Color(0xFFFFFFFF);
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Icon(
              icon,
              color: _baseColor,
              size: 16,
            ),
            SizedBox(width: 20),
            Text(
              title,
              style: TextStyle(color: _baseColor, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _OptionCheckItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool selected;
  final Function(bool) onTap;
  const _OptionCheckItem(
      {@required this.title,
      @required this.icon,
      this.selected = false,
      this.onTap});
  @override
  _OptionCheckItemState createState() => _OptionCheckItemState();
}

class _OptionCheckItemState extends State<_OptionCheckItem> {
  final Color _baseColor = const Color(0xFFFFFFFF);
  bool _selected = false;
  @override
  void initState() {
    _selected = widget.selected;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  _changed() {
    _selected = !_selected;
    setState(() {});
    if (widget.onTap != null) widget.onTap(_selected);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _changed,
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Icon(
              widget.icon,
              color: _baseColor,
              size: 16,
            ),
            const SizedBox(width: 20),
            Text(
              widget.title,
              style: TextStyle(color: _baseColor, fontSize: 14),
            ),
            const Spacer(),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  border: Border.all(color: _baseColor)),
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: _selected
                    ? Icon(
                        Icons.check,
                        size: 10.0,
                        color: _baseColor,
                      )
                    : SizedBox(
                        width: 10,
                        height: 10,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
