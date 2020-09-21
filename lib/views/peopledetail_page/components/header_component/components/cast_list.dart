import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:movie/actions/api/graphql_client.dart';
import 'package:movie/globalbasestate/store.dart';
import 'package:movie/models/base_api_model/base_cast_list.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';
import 'package:movie/style/themestyle.dart';
import 'package:movie/views/cast_list/cast_list_page/components/cast_list_create.dart';
import 'package:toast/toast.dart';

class CastList extends StatefulWidget {
  final BaseCast cast;
  const CastList({Key key, @required this.cast}) : super(key: key);
  @override
  _CastListState createState() => _CastListState();
}

class _CastListState extends State<CastList> {
  Stream<FetchResult> _data;
  BaseCast _cast;
  BaseCastList _selectedList;
  @override
  void initState() {
    _cast = widget.cast;
    _onInit();
    super.initState();
  }

  void _onSelected(BaseCastList selected) {
    _selectedList = selected;
  }

  void _onInit() {
    final _user = GlobalStore.store.getState().user;
    if (_user?.firebaseUser != null)
      _data = BaseGraphQLClient.instance
          .castListSubscription(_user.firebaseUser.uid);
  }

  void _onAdd() async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: (_) => CastListCreate()));
  }

  void _onOk(BuildContext c) async {
    if (_selectedList == null) return;
    final _user = GlobalStore.store.getState().user;
    if (_user?.firebaseUser == null) return Toast.show('Please login', c);
    _cast.listId = _selectedList.id;

    BaseGraphQLClient.instance.addCast(_selectedList, _cast);

    Navigator.of(c).pop();
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    final _theme = ThemeStyle.getTheme(context);
    return SimpleDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 0.0,
      title: _Title(onAdd: _onAdd),
      children: [
        Container(
          height: _size.height / 2,
          width: _size.width,
          child: StreamBuilder<FetchResult>(
            stream: _data,
            builder: (_, snapShot) {
              switch (snapShot.connectionState) {
                case ConnectionState.waiting:
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(_theme.iconTheme.color),
                  ));
                case ConnectionState.active:
                case ConnectionState.done:
                  final _castList = CastListModel.fromMap(snapShot.data.data);
                  final List<BaseCastList> _list = _castList.list
                    ..sort(
                        (a, b) => a.updateTime.isBefore(b.updateTime) ? 1 : 0);
                  return _CastListView(
                    data: _list,
                    onSelected: _onSelected,
                  );

                case ConnectionState.none:
                default:
                  return Center(
                      child: Text(
                    'Empty List',
                    style: TextStyle(fontSize: 18),
                  ));
              }
            },
          ),
        ),
        _ButtonPanel(
          onSubmit: () => _onOk(context),
          onCancel: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  final Function onAdd;
  const _Title({this.onAdd});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Cast Lists'),
        GestureDetector(
          onTap: onAdd,
          child: Icon(Icons.add_circle),
        ),
      ],
    );
  }
}

class _CastListView extends StatefulWidget {
  final List<BaseCastList> data;
  final Function(BaseCastList) onSelected;
  const _CastListView({this.data, this.onSelected});
  @override
  _CastListViewState createState() => _CastListViewState();
}

class _CastListViewState extends State<_CastListView> {
  BaseCastList _selected;

  void _onSelected(BaseCastList selected) {
    _selected = selected;
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
    initSelected();
    super.initState();
  }

  initSelected() {
    if (widget.data.length > 0) _onSelected(widget.data[0]);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        itemBuilder: (_, index) {
          return _CastListCell(
            data: widget.data[index],
            selected: widget.data[index].id == _selected.id,
            onTap: _onSelected,
          );
        },
        separatorBuilder: (_, index) => SizedBox(height: 10),
        itemCount: widget.data.length);
  }
}

class _CastListCell extends StatelessWidget {
  final BaseCastList data;
  final bool selected;
  final Function(BaseCastList) onTap;
  const _CastListCell({this.data, this.selected, this.onTap});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    return GestureDetector(
        onTap: () => onTap(data),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: selected
              ? BoxDecoration(
                  border: Border.all(color: _theme.iconTheme.color),
                  borderRadius: BorderRadius.circular(5),
                )
              : null,
          child: Text(
            data.name ?? '',
            style: TextStyle(fontSize: 18),
          ),
        ));
  }
}

class _ButtonPanel extends StatelessWidget {
  final Function onSubmit;
  final Function onCancel;
  const _ButtonPanel({this.onSubmit, this.onCancel});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _Button(
            text: 'cancel',
            onPress: onCancel,
          ),
          SizedBox(width: 24),
          _Button(
            text: 'ok',
            onPress: onSubmit,
          ),
        ],
      ),
    );
  }
}

class _Button extends StatelessWidget {
  final String text;
  final Function onPress;
  const _Button({this.onPress, this.text});
  @override
  Widget build(BuildContext context) {
    final _theme = ThemeStyle.getTheme(context);
    final _textStyle = TextStyle(
        fontSize: 16,
        color: _theme.brightness == Brightness.light
            ? const Color(0xFFFFFFFF)
            : const Color(0xFF000000));
    return InkWell(
      onTap: onPress,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        constraints: BoxConstraints(minWidth: 80),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: _theme.iconTheme.color),
        child: Center(
          child: Text(
            text,
            style: _textStyle,
          ),
        ),
      ),
    );
  }
}
