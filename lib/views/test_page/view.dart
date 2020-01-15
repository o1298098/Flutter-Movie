import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/globalbasestate/action.dart';
import 'package:movie/globalbasestate/store.dart';

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
    return SizedBox(
      height: Adapt.px(900),
      child: ListView(
        shrinkWrap: true,
        children: documents.map(_buildListItem).toList(),
      ),
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
      backgroundColor: Color(0xFFF0F0F0),
      appBar: AppBar(
        backgroundColor: state.themeColor,
        title: Text('${state?.locale?.languageCode}'),
      ),
      body: Column(
        children: <Widget>[
          _buildBody(viewService.context),
          InkWell(
            onTap: () {
              GlobalStore.store
                  .dispatch(GlobalActionCreator.onchangeThemeColor());
              GlobalStore.store
                  .dispatch(GlobalActionCreator.changeLocale(Locale('zh')));
            },
            //dispatch(TestPageActionCreator.googleSignIn()),
            child: Container(
              padding: EdgeInsets.all(Adapt.px(30)),
              color: Colors.amber,
              child: Text(I18n.of(viewService.context).account),
            ),
          ),
          SizedBox(height: Adapt.px(30)),
          InkWell(
            onTap: () => dispatch(TestPageActionCreator.inputTapped()),
            //dispatch(TestPageActionCreator.googleSignIn()),
            child: Container(
              padding: EdgeInsets.all(Adapt.px(30)),
              color: Colors.amber,
              child: Text('input'),
            ),
          ),
          SizedBox(height: Adapt.px(30)),
          Container(
            width: Adapt.px(100),
            height: Adapt.px(100),
            decoration: BoxDecoration(
              color: Color(0xFFF0F0F0),
              boxShadow: [
                BoxShadow(
                    color: Colors.white,
                    offset: Offset(-Adapt.px(8), -Adapt.px(8)),
                    blurRadius: Adapt.px(10)),
                BoxShadow(
                    color: Colors.grey[300],
                    offset: Offset(Adapt.px(10), Adapt.px(10)),
                    blurRadius: Adapt.px(10))
              ],
            ),
          )
        ],
      ));
}
