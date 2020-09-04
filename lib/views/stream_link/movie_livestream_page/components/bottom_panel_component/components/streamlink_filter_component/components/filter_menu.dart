import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/app_language.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/widgets/arrow_clipper.dart';

class FilterMenu extends StatefulWidget {
  final String selectedHost;
  final String selectedLanguage;
  final String selectedQuality;
  final Function(String) hostTap;
  final Function(String) languageTap;
  final Function(String) qualityTap;
  const FilterMenu({
    this.selectedHost,
    this.selectedQuality,
    this.selectedLanguage,
    this.hostTap,
    this.languageTap,
    this.qualityTap,
  });
  @override
  _FilterMenuState createState() => _FilterMenuState();
}

class _FilterMenuState extends State<FilterMenu> {
  String _selectedHost;
  String _selectedLanguage;
  String _selectedQuality;
  @override
  void initState() {
    _selectedHost = widget.selectedHost;
    _selectedLanguage = widget.selectedLanguage;
    _selectedQuality = widget.selectedQuality;
    super.initState();
  }

  _hostTap(String host) {
    String _value;
    if (_selectedHost != host) _value = host;
    setState(() {
      _selectedHost = _value;
    });
    widget.hostTap(_value);
  }

  _languageTap(String language) {
    String _value;
    if (_selectedLanguage != language) _value = language;
    setState(() {
      _selectedLanguage = _value;
    });
    widget.languageTap(_value);
  }

  _qualityTap(String quality) {
    String _value;
    if (_selectedQuality != quality) _value = quality;
    setState(() {
      _selectedQuality = _value;
    });
    widget.qualityTap(_value);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    final double _width = Adapt.screenW() - 40;
    final double _arrowSize = 15.0;
    final Color _fontColor = const Color(0xFFFFFFFF);
    return Positioned(
      top: Adapt.px(120) + 25,
      right: 20,
      width: _width,
      child: Material(
        color: Colors.transparent,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(right: 56),
              alignment: Alignment.bottomRight,
              child: ClipPath(
                clipper: ArrowClipper(mode: 'up'),
                child: Container(
                  width: _arrowSize,
                  height: _arrowSize,
                  color: _backGroundColor,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: _arrowSize / 2 - 1),
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: _backGroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hosts',
                    style: TextStyle(color: _fontColor),
                  ),
                  SizedBox(height: 10),
                  _HostOption(
                    onTap: _hostTap,
                    selectedHost: _selectedHost,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Languages',
                    style: TextStyle(color: _fontColor),
                  ),
                  SizedBox(height: 10),
                  _LanguageOption(
                    onTap: _languageTap,
                    selectedLanguage: _selectedLanguage,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Quality',
                    style: TextStyle(color: _fontColor),
                  ),
                  SizedBox(height: 10),
                  _QualityOption(
                      onTap: _qualityTap, selectedQuality: _selectedQuality),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HostOption extends StatelessWidget {
  final String selectedHost;
  final Function(String) onTap;
  const _HostOption({this.selectedHost, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _hosts = [
      "streamtape",
      "upstream",
      "uptostream",
      "dood",
      "mediafire",
      "cloudvideo",
      "onlystream",
      "clipwatching",
      "vidfast",
      "vidoza",
      "vidlox",
      "gounlimited",
      "supervideo",
      "bitporno",
    ];
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: _hosts
          .map(
            (e) => _WrapCell(
              title: e,
              selected: e == selectedHost,
              onTap: () => onTap(e),
            ),
          )
          .toList(),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onTap;
  const _LanguageOption({this.selectedLanguage, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: AppLanguage.instance.supportLanguages
          .where((e) => e.name != 'System Default')
          .map(
            (e) => _WrapCell(
              title: e.name,
              selected: e.name == selectedLanguage,
              onTap: () => onTap(e.name),
            ),
          )
          .toList(),
    );
  }
}

class _QualityOption extends StatelessWidget {
  final String selectedQuality;
  final Function(String) onTap;
  const _QualityOption({this.selectedQuality, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _hosts = [
      "4K",
      "1080p",
      "720p",
      "480p",
      "360p",
      "240p",
    ];
    return Wrap(
      runSpacing: 8,
      spacing: 8,
      children: _hosts
          .map(
            (e) => _WrapCell(
              title: e,
              selected: e == selectedQuality,
              onTap: () => onTap(e),
            ),
          )
          .toList(),
    );
  }
}

class _WrapCell extends StatelessWidget {
  final String title;
  final bool selected;
  final Function onTap;
  const _WrapCell({this.title, this.onTap, this.selected = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          border: Border.all(
            color: const Color(0xFFFFFFFF),
          ),
          borderRadius: BorderRadius.circular(8),
          color: selected ? const Color(0xFFFFFFFF) : null,
        ),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: selected ? const Color(0xFF25272E) : const Color(0xFFFFFFFF),
          ),
        ),
      ),
    );
  }
}
