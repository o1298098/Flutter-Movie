import 'dart:convert' show json;
import 'braintree_item_type.dart';

class StatusHistory {
  double amount;
  String timestamp;
  String user;
  ItemType source;
  ItemType status;

  StatusHistory.fromParams(
      {this.amount, this.timestamp, this.user, this.source, this.status});

  StatusHistory.fromJson(jsonRes) {
    amount = jsonRes['Amount'];
    timestamp = jsonRes['Timestamp'];
    user = jsonRes['User'];
    source = jsonRes['Source'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Source']);
    status = jsonRes['Status'] == null
        ? null
        : new ItemType.fromJson(jsonRes['Status']);
  }

  @override
  String toString() {
    return '{"Amount": $amount,"Timestamp": ${timestamp != null ? '${json.encode(timestamp)}' : 'null'},"User": ${user != null ? '${json.encode(user)}' : 'null'},"Source": $source,"Status": $status}';
  }
}
