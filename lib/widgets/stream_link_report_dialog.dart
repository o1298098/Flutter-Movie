import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/actions/api/base_api.dart';
import 'package:movie/models/base_api_model/stream_link_report.dart';

class StreamLinkReportDialog extends StatefulWidget {
  final StreamLinkReport report;
  StreamLinkReportDialog({Key key, @required this.report}) : super(key: key);
  @override
  _StreamLinkReportDialogState createState() => _StreamLinkReportDialogState();
}

class _StreamLinkReportDialogState extends State<StreamLinkReportDialog> {
  String _radioGroup;
  TextEditingController _textEditingController;
  FocusNode _textFoucsNode;
  final _baseApi = BaseApi.instance;
  final List<String> _radioValues = [
    'this video can\'t play',
    'content doesn\'t match',
    'too slow to play',
    'sexual content',
    'other'
  ];
  @override
  initState() {
    _textEditingController = TextEditingController();
    _textFoucsNode = FocusNode();
    super.initState();
  }

  @override
  dispose() {
    _textEditingController.dispose();
    _textFoucsNode.dispose();
    super.dispose();
  }

  _onRadioChanged(String d) {
    setState(() {
      _radioGroup = d;
    });

    if (_radioGroup == 'other')
      Future.delayed(
          Duration(milliseconds: 100), () => _textFoucsNode.requestFocus());
    else if (_textEditingController.text.isNotEmpty)
      _textEditingController.text = '';
  }

  _submit() {
    if (_radioGroup != null) {
      if (_radioGroup == 'other')
        widget.report.content = _textEditingController.text;
      else
        widget.report.content = _radioGroup;
      _baseApi.sendStreamLinkReport(widget.report);
    }
    Navigator.of(context).pop();
  }

  Widget _buildRadioCell(String d) {
    return ListTile(
      onTap: () => _onRadioChanged(d),
      leading: Radio(
        groupValue: _radioGroup,
        value: d,
        onChanged: _onRadioChanged,
      ),
      title: Text(d),
    );
  }

  Widget _buildOtherTextField() {
    return Padding(
        padding: EdgeInsets.symmetric(horizontal: Adapt.px(50)),
        child: TextField(
          focusNode: _textFoucsNode,
          autofocus: true,
          controller: _textEditingController,
          enabled: _radioGroup == 'other',
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Adapt.px(20))),
      contentPadding: EdgeInsets.zero,
      title: Text('Report a problem'),
      children: <Widget>[
        Divider(),
        Material(
          color: Colors.transparent,
          child: Container(
            width: Adapt.px(600),
            height: Adapt.px(650),
            child: ListView(
              children: _radioValues.map(_buildRadioCell).toList()
                ..add(_buildOtherTextField()),
            ),
          ),
        ),
        Divider(),
        Padding(
            padding: EdgeInsets.symmetric(vertical: Adapt.px(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                    onTap: () => _submit(),
                    child: Text(
                      'OK',
                      style: TextStyle(fontSize: Adapt.px(35)),
                    )),
                SizedBox(width: Adapt.px(60)),
              ],
            ))
      ],
    );
  }
}
