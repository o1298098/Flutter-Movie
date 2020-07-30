import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie/models/base_api_model/base_cast_list.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CastListState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      actions: [
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () => dispatch(CastListActionCreator.addCastList()))
      ],
    ),
    body: StreamBuilder<FetchResult>(
      stream: state.castList,
      builder: (_, snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: Text('waiting'));
          case ConnectionState.active:
          case ConnectionState.done:
            final _castList = CastListModel.fromMap(snapShot.data.data);
            final List<BaseCastList> _list = _castList.list
              ..sort((a, b) => a.updateTime.isBefore(b.updateTime) ? 1 : 0);
            return _CastListView(
              data: _list,
              onSelected: (d) =>
                  dispatch(CastListActionCreator.onCastListTap(d)),
            );

          case ConnectionState.none:
          default:
            return Center(child: Text('empty'));
        }
      },
    ),
  );
}

class _CastListView extends StatefulWidget {
  final List<BaseCastList> data;
  final Function(BaseCastList) onSelected;
  const _CastListView({this.data, this.onSelected});
  @override
  _CastListViewState createState() => _CastListViewState();
}

class _CastListViewState extends State<_CastListView> {
  void _onSelected(BaseCastList selected) {
    if (widget.onSelected != null) widget.onSelected(selected);
    setState(() {});
  }

  @override
  void didUpdateWidget(_CastListView oldWidget) {
    //if (oldWidget.data != widget.data) initSelected();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        itemBuilder: (_, index) {
          return _CastListCell(
            data: widget.data[index],
            onTap: _onSelected,
          );
        },
        separatorBuilder: (_, index) => SizedBox(height: 10),
        itemCount: widget.data.length);
  }
}

class _CastListCell extends StatelessWidget {
  final BaseCastList data;
  final Function(BaseCastList) onTap;
  const _CastListCell({this.data, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(data),
      child: Container(
        padding: EdgeInsets.all(10),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(
            data.name ?? '',
            style: TextStyle(fontSize: 18),
          ),
          Text(data.castCount.toString())
        ]),
      ),
    );
  }
}
