import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:gzx_dropdown_menu/gzx_dropdown_menu.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/customwidgets/sliverappbar_delegate.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/style/themestyle.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    DiscoverPageState state, Dispatch dispatch, ViewService viewService) {
  final _adapter = viewService.buildAdapter();

  return Builder(builder: (context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);

    return Scaffold(
      key: state.scaffoldKey,
      endDrawer: Drawer(
        child: viewService.buildComponent('filter'),
      ),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: _theme.brightness == Brightness.light
            ? SystemUiOverlayStyle.dark
            : SystemUiOverlayStyle.light,
        child: SafeArea(
          child: Stack(
            key: state.stackKey,
            children: <Widget>[
              CustomScrollView(
                controller: state.scrollController,
                slivers: <Widget>[
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: SliverAppBarDelegate(
                        minHeight: 40,
                        maxHeight: 40,
                        child: GZXDropDownHeader(
                          borderColor: _theme.backgroundColor,
                          color: _theme.backgroundColor,
                          items: [
                            GZXDropDownHeaderItem(state.filterTabNames[0]),
                            GZXDropDownHeaderItem(
                                I18n.of(viewService.context).filter,
                                iconData: Icons.filter_list,
                                iconSize: 13),
                          ],
                          style: TextStyle(
                            fontSize: Adapt.px(24),
                          ),
                          dropDownStyle: TextStyle(
                            fontSize: Adapt.px(24),
                          ),
                          iconDropDownColor: Colors.black,
                          stackKey: state.stackKey,
                          controller: state.dropdownMenuController,
                          onItemTap: (index) {
                            if (index == 1) {
                              state.scaffoldKey.currentState.openEndDrawer();
                            }
                          },
                        )),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                        (BuildContext ctx, int index) {
                      return _adapter.itemBuilder(ctx, index);
                    }, childCount: _adapter.itemCount),
                  ),
                  _ShimmerList(isbusy: state.isbusy)
                ],
              ),
              GZXDropDownMenu(
                animationMilliseconds: 250,
                controller: state.dropdownMenuController,
                menus: [
                  GZXDropdownMenuBuilder(
                    dropDownHeight: 40 * state.sortType.length.toDouble(),
                    dropDownWidget: _ConditionList(
                        items: state.sortType,
                        onTap: (value) {
                          int e = state.sortType.indexOf(value);
                          state.filterTabNames[0] = state.sortType[e].name;
                          dispatch(DiscoverPageActionCreator.onSortChanged(
                              state.sortType[e].value));
                          dispatch(DiscoverPageActionCreator.onRefreshData());

                          state.dropdownMenuController.hide();
                        }),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  });
}

class _ShimmerCell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: Adapt.px(400),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: Adapt.px(260),
              height: Adapt.px(400),
              color: Colors.grey[200],
            ),
            Container(
              padding: EdgeInsets.all(Adapt.px(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: Adapt.px(80),
                        height: Adapt.px(80),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(Adapt.px(40))),
                      ),
                      SizedBox(
                        width: Adapt.px(10),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: Adapt.screenW() - Adapt.px(450),
                            height: Adapt.px(25),
                            color: Colors.grey[200],
                          ),
                          SizedBox(
                            height: Adapt.px(10),
                          ),
                          Container(
                            width: Adapt.px(120),
                            height: Adapt.px(20),
                            color: Colors.grey[200],
                          ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: Adapt.px(20),
                  ),
                  Container(
                    width: Adapt.screenW() - Adapt.px(360),
                    height: Adapt.px(20),
                    color: Colors.grey[200],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Adapt.px(10)),
                    width: Adapt.screenW() - Adapt.px(360),
                    height: Adapt.px(20),
                    color: Colors.grey[200],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Adapt.px(10)),
                    width: Adapt.screenW() - Adapt.px(360),
                    height: Adapt.px(20),
                    color: Colors.grey[200],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Adapt.px(10)),
                    width: Adapt.screenW() - Adapt.px(360),
                    height: Adapt.px(20),
                    color: Colors.grey[200],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Adapt.px(10)),
                    width: Adapt.screenW() - Adapt.px(360),
                    height: Adapt.px(20),
                    color: Colors.grey[200],
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class _ShimmerList extends StatelessWidget {
  final bool isbusy;
  _ShimmerList({this.isbusy});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return SliverToBoxAdapter(
      child: Offstage(
        offstage: isbusy,
        child: Shimmer.fromColors(
          baseColor: _theme.primaryColorDark,
          highlightColor: _theme.primaryColorLight,
          child: Container(
            margin: EdgeInsets.only(
                top: Adapt.px(10),
                bottom: Adapt.px(30),
                left: Adapt.px(30),
                right: Adapt.px(30)),
            child: Column(
              children: <Widget>[
                _ShimmerCell(),
                SizedBox(height: Adapt.px(30)),
                _ShimmerCell(),
                SizedBox(height: Adapt.px(30)),
                _ShimmerCell(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ConditionList extends StatelessWidget {
  final dynamic items;
  final Function(dynamic) onTap;
  const _ConditionList({@required this.items, this.onTap});
  @override
  Widget build(BuildContext context) {
    final ThemeData _theme = ThemeStyle.getTheme(context);
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      separatorBuilder: (BuildContext context, int index) =>
          Divider(height: 1.0),
      itemBuilder: (BuildContext context, int index) {
        SortCondition goodsSortCondition = items[index];
        return GestureDetector(
          onTap: () {
            for (var value in items) {
              value.isSelected = false;
            }
            goodsSortCondition.isSelected = true;
            onTap(goodsSortCondition);
          },
          child: Container(
            color: _theme.backgroundColor,
            height: 40,
            child: Row(
              children: <Widget>[
                SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    goodsSortCondition.name,
                    style: TextStyle(
                      color: goodsSortCondition.isSelected
                          ? _theme.textTheme.bodyText1.color
                          : Colors.grey,
                    ),
                  ),
                ),
                goodsSortCondition.isSelected
                    ? Icon(
                        Icons.check,
                        color: _theme.iconTheme.color,
                        size: 16,
                      )
                    : SizedBox(),
                SizedBox(
                  width: 16,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
