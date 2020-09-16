import 'package:flutter/material.dart';
import 'package:movie/actions/app_language.dart';
import 'package:movie/models/models.dart';
import 'package:movie/style/themestyle.dart';

class LanguageDialog extends StatefulWidget {
  final Function(String) onTap;
  final String selected;
  const LanguageDialog({this.onTap, this.selected});
  @override
  _LanguageDialogState createState() => _LanguageDialogState();
}

class _LanguageDialogState extends State<LanguageDialog> {
  final List<Item> _data = AppLanguage.instance.supportLanguages
      .where((e) => e.name != 'System Default')
      .toList();
  String _selectedCode;
  @override
  void initState() {
    _selectedCode = widget.selected;
    super.initState();
  }

  _onSelected(String code) {
    if (_selectedCode == code)
      _selectedCode = null;
    else
      _selectedCode = code;
    setState(() {});
    if (widget.onTap != null) widget.onTap(_selectedCode);
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 0.0,
      backgroundColor: _backGroundColor,
      titleTextStyle: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 18),
      title: Text(
        'Default Language',
      ),
      children: [
        Container(
          height: _size.height / 2,
          width: _size.width,
          child: ListView.separated(
            padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 5.0),
            separatorBuilder: (_, __) => SizedBox(height: 10),
            physics: BouncingScrollPhysics(),
            itemCount: _data.length,
            itemBuilder: (_, index) {
              final _language = _data[index];
              return _LangageListCell(
                onTap: _onSelected,
                selected: _selectedCode == _language.value,
                language: _language,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _LangageListCell extends StatelessWidget {
  final Function(String) onTap;
  final Item language;
  final bool selected;
  const _LangageListCell({this.onTap, this.language, this.selected = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(language.value);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color:
                    selected ? const Color(0xFFFFFFFF) : Colors.transparent)),
        child: Text(
          language.name,
          style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 14),
        ),
      ),
    );
  }
}
