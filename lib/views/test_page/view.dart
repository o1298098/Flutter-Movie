import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'state.dart';

Widget buildView(
    TestPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    backgroundColor: Color(0xFFF0F0F0),
    appBar: AppBar(
      backgroundColor: state.themeColor,
      title: Text('${state?.locale?.languageCode}'),
    ),
    body: Column(children: [
      SizedBox(
        height: 200,
        child: StreamBuilder<FetchResult>(
          stream: state.testData2,
          builder: (_, snapShot) {
            switch (snapShot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return Center(child: Text('waiting'));
              case ConnectionState.active:
              case ConnectionState.done:
                print(snapShot.data);
                return Center(
                    child: Text(snapShot.data?.data?.toString() ?? ''));
              default:
                return Center(child: Text('waiting'));
            }
          },
        ),
      ),
    ]),
  );
}

class _StripeTest extends StatefulWidget {
  @override
  _StripeTestState createState() => _StripeTestState();
}

class _StripeTestState extends State<_StripeTest> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
