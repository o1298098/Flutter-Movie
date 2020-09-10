import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  const ExpandableText(this.text,
      {Key key, this.maxLines = 2, this.style, this.onTap})
      : assert(text != null),
        super(key: key);

  final String text;
  final int maxLines;
  final TextStyle style;
  final Function(bool) onTap;

  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
    if (widget.onTap != null) widget.onTap(_readMore);
  }

  @override
  Widget build(BuildContext context) {
    final colorClickableText = Colors.blue;
    TextSpan link = TextSpan(
        text: _readMore ? "... more" : " less",
        style: TextStyle(
          color: colorClickableText,
        ),
        recognizer: TapGestureRecognizer()..onTap = _onTapLink);
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        final text = TextSpan(text: widget.text, style: widget.style);
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: TextDirection.rtl,
          maxLines: widget.maxLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        int endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        var textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(
            text: _readMore ? widget.text.substring(0, endIndex) : widget.text,
            style: widget.style,
            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
            style: widget.style,
          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}
