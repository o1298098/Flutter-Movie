import 'package:flutter/material.dart';
import 'package:movie/actions/stream_link_convert/stream_link_convert_factory.dart';
import 'package:movie/style/themestyle.dart';

class HostDialog extends StatefulWidget {
  final String selectedHost;
  final Function(String) onSelected;
  const HostDialog({this.selectedHost, this.onSelected});
  @override
  _HostDialogState createState() => _HostDialogState();
}

class _HostDialogState extends State<HostDialog> {
  String _selectedHost;

  @override
  void initState() {
    _selectedHost = widget.selectedHost;
    super.initState();
  }

  _onSelected(String host) {
    if (_selectedHost == host)
      _selectedHost = null;
    else
      _selectedHost = host;
    setState(() {});
    if (widget.onSelected != null) widget.onSelected(_selectedHost);
  }

  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _backGroundColor = _theme.brightness == Brightness.light
        ? const Color(0xFF25272E)
        : _theme.primaryColorDark;
    return SimpleDialog(
      contentPadding: const EdgeInsets.all(24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: _backGroundColor,
      title: Text(
        'Prefer Host',
        style: TextStyle(color: const Color(0xFFFFFFFF)),
      ),
      children: [
        Wrap(
          runSpacing: 8,
          spacing: 8,
          children: StreamLinkConvertFactory.instance.hosts
              .map(
                (e) => _WrapCell(
                  title: e,
                  selected: e == _selectedHost,
                  onTap: _onSelected,
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}

class _WrapCell extends StatelessWidget {
  final String title;
  final bool selected;
  final Function(String) onTap;
  const _WrapCell({this.title, this.onTap, this.selected = false});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(title),
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
