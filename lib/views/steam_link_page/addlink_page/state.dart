import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/globalbasestate/state.dart';
import 'package:movie/models/enums/media_type.dart';
import 'package:movie/models/enums/streamlink_type.dart';

class AddLinkPageState implements GlobalBaseState, Cloneable<AddLinkPageState> {
  String name;
  String streamLink;
  int id;
  String photoUrl;
  MediaType type;
  String linkName;
  DocumentSnapshot linkData;
  StreamLinkType streamLinkType;

  TextEditingController linkNameTextController;
  TextEditingController streamLinkTextController;
  @override
  AddLinkPageState clone() {
    return AddLinkPageState()
      ..user = user
      ..name = name
      ..photoUrl = photoUrl
      ..id = id
      ..streamLink = streamLink
      ..type = type
      ..linkName = linkName
      ..linkData = linkData
      ..streamLinkType = streamLinkType
      ..linkNameTextController = linkNameTextController
      ..streamLinkTextController = streamLinkTextController;
  }

  @override
  Locale locale;

  @override
  Color themeColor;

  @override
  FirebaseUser user;
}

AddLinkPageState initState(Map<String, dynamic> args) {
  return AddLinkPageState()
    ..streamLinkType = StreamLinkType.other
    ..name = args['name'] ?? ''
    ..id = args['id']
    ..photoUrl = args['photourl'] ?? ''
    ..type = args['type'];
}
