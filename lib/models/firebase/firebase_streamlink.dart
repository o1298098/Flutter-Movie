import 'package:movie/models/enums/streamlink_type.dart';

class StreamLinkModel {
  String linkName;
  String streamLink;
  StreamLinkType type;
  bool selected;

  StreamLinkModel.fromParams(
      {this.linkName,
      this.streamLink,
      this.selected,
      this.type});

  factory StreamLinkModel(Map mapRes) => mapRes == null
      ? StreamLinkModel.fromParams(selected: false)
      : new StreamLinkModel.fromMap(mapRes);

  StreamLinkModel.fromMap(mapRes) {
    linkName = mapRes['linkName'];
    streamLink = mapRes['streamLink'];
    type = mapRes['streamLinkType'] == 'YouTube'
        ? StreamLinkType.youtube
        : StreamLinkType.other;
    selected = false;
  }

  @override
  String toString() {
    return '{"linkName": $linkName,"streamLink": $streamLink ,"selected ": $selected,"type":$type }';
  }
}
