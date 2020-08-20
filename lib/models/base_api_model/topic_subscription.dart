import 'dart:convert' show json;

class TopicSubscription {
  int id;
  String cloudMessagingToken;
  String localCode;
  String topicId;

  TopicSubscription.fromParams(
      {this.id, this.cloudMessagingToken, this.localCode, this.topicId});

  factory TopicSubscription(jsonStr) => jsonStr == null
      ? null
      : jsonStr is String
          ? new TopicSubscription.fromJson(json.decode(jsonStr))
          : new TopicSubscription.fromJson(jsonStr);

  TopicSubscription.fromJson(jsonRes) {
    id = jsonRes['id'];
    cloudMessagingToken = jsonRes['cloudMessagingToken'];
    localCode = jsonRes['localCode'];
    topicId = jsonRes['topicId'];
  }

  @override
  String toString() {
    return '{"id": $id,"cloudMessagingToken": ${cloudMessagingToken != null ? '${json.encode(cloudMessagingToken)}' : 'null'},"localCode": ${localCode != null ? '${json.encode(localCode)}' : 'null'},"topicId": ${topicId != null ? '${json.encode(topicId)}' : 'null'}}';
  }
}
