import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    TestPageState state, Dispatch dispatch, ViewService viewService) {
  Widget _buildListItem(DocumentSnapshot d) {
    return Container(
      margin: EdgeInsets.all(Adapt.px(20)),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(Adapt.px(15))),
      child: ListTile(
        title: Text(d.data['name']),
        trailing: Text(d.data['value'].toString()),
        onTap: () {
          d.reference.updateData({'value': d.data['value'] + 1});
        },
      ),
    );
  }

  Widget _buildList(List<DocumentSnapshot> documents) {
    return ListView(
      shrinkWrap: true,
      children: documents.map(_buildListItem).toList(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: state.testData,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(snapshot.data.documents);
      },
    );
  }

  return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          _buildBody(viewService.context),
          InkWell(
            onTap: () => dispatch(TestPageActionCreator.googleSignIn()),
            child: Container(
              padding: EdgeInsets.all(Adapt.px(30)),
              color: Colors.amber,
              child: Text('google sign in'),
            ),
          )
        ],
      ));
}
