import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movie/models/enums/streamlink_type.dart';

class StreamLinkModel {
  String linkName;
  String streamLink;
  Timestamp createTime;
  StreamLinkType type;
  bool selected;

  StreamLinkModel.fromParams(
      {this.linkName,
      this.streamLink,
      this.createTime,
      this.selected,
      this.type});

  factory StreamLinkModel(Map mapRes) => mapRes == null
      ? StreamLinkModel.fromParams(selected: false)
      : new StreamLinkModel.fromMap(mapRes);

  StreamLinkModel.fromMap(mapRes) {
    linkName = mapRes['linkName'];
    streamLink = mapRes['streamLink'];
    createTime = mapRes['createTime'];
    type = mapRes['streamLinkType'] == 'YouTube'
        ? StreamLinkType.youtube
        : StreamLinkType.other;
    selected = false;
  }

  @override
  String toString() {
    return '{"linkName": $linkName,"streamLink": $streamLink,"createTime ": $createTime ,"selected ": $selected,"type":$type }';
  }
}
