import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie/models/base_api_model/base_cast_list.dart';
import 'package:movie/style/themestyle.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    CastListState state, Dispatch dispatch, ViewService viewService) {
  final _theme = ThemeStyle.getTheme(viewService.context);
  return Scaffold(
    appBar: AppBar(
      title: Text(
        'Cast Lists',
        style: TextStyle(color: _theme.textTheme.bodyText1.color),
      ),
      backgroundColor: _theme.backgroundColor,
      elevation: 0.0,
      brightness: _theme.brightness,
      iconTheme: _theme.iconTheme,
      actions: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => dispatch(CastListActionCreator.addCastList()),
        )
      ],
    ),
    backgroundColor: _theme.backgroundColor,
    body: StreamBuilder<FetchResult>(
      stream: state.castList,
      builder: (_, snapShot) {
        switch (snapShot.connectionState) {
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(_theme.iconTheme.color),
              ),
            );
          case ConnectionState.active:
          case ConnectionState.done:
            final _castList = CastListModel.fromMap(snapShot.data.data);
            final List<BaseCastList> _list = _castList.list
              ..sort((a, b) => a.updateTime.isBefore(b.updateTime) ? 1 : 0);
            return _CastListView(
              data: _list,
              onSelected: (d) =>
                  dispatch(CastListActionCreator.onCastListTap(d)),
              onEdit: (d) => dispatch(CastListActionCreator.onCastListEdit(d)),
            );
          case ConnectionState.none:
          default:
            return Center(
              child: Text('Empty List'),
            );
        }
      },
    ),
  );
}

class _CastListView extends StatelessWidget {
  final List<BaseCastList> data;
  final Function(BaseCastList) onSelected;
  final Function(BaseCastList) onEdit;
  const _CastListView({this.data, this.onSelected, this.onEdit});

  void _onSelected(BaseCastList selected) {
    if (onSelected != null) onSelected(selected);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      itemBuilder: (_, index) {
        return _CastListCell(
          data: data[index],
          onTap: _onSelected,
          onEdit: onEdit,
        );
      },
      separatorBuilder: (_, index) => SizedBox(height: 10),
      itemCount: data.length,
    );
  }
}

class _CastListCell extends StatelessWidget {
  final BaseCastList data;
  final Function(BaseCastList) onTap;
  final Function(BaseCastList) onEdit;
  const _CastListCell({this.data, this.onTap, this.onEdit});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: () => onTap(data),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: _theme.primaryColorDark),
          ),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(20),
                  ),
                  color: _theme.primaryColorDark,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(data.backgroundUrl ==
                                null ||
                            data.backgroundUrl?.isEmpty == true
                        ? 'https://img.freepik.com/free-vector/people-waving-hand-illustration-concept_52683-29825.jpg?size=626&ext=jpg'
                        : data.backgroundUrl),
                  ),
                ),
              ),
              SizedBox(width: 15),
              SizedBox(
                width: _size.width - 220,
                child: Text(
                  data.name ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Spacer(),
              Text('${data.castCount ?? 0}'),
              //SizedBox(width: 15),
              IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: const Color(0xFF717171),
                  ),
                  onPressed: () => onEdit(data))
            ],
          ),
        ),
      ),
    );
  }
}
