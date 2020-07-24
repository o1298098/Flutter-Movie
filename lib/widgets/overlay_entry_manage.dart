import 'package:flutter/material.dart';

class OverlayEntryManage extends StatefulWidget {
  final Widget child;
  const OverlayEntryManage({Key key, this.child}) : super(key: key);
  @override
  OverlayEntryManageState createState() => OverlayEntryManageState();
}

class OverlayEntryManageState extends State<OverlayEntryManage> {
  OverlayEntry _currentOverlayEntry;
  void setOverlayEntry(OverlayEntry overlayEntry) {
    _currentOverlayEntry = overlayEntry;
  }

  Future<bool> _onWillPop() {
    if (_currentOverlayEntry != null) {
      _currentOverlayEntry?.remove();
      _currentOverlayEntry = null;
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: () => _onWillPop(), child: widget.child);
  }
}
