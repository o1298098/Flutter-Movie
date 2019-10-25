import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/share_card.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:movie/models/sortcondition.dart';
import 'package:movie/models/videolist.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    ListDetailPageState state, Dispatch dispatch, ViewService viewService) {
  String _covertDuration(int d) {
    String result = '';
    Duration duration = Duration(minutes: d);
    int h = duration.inHours;
    int countedMin = h * 60;
    int m = duration.inMinutes - countedMin;
    result += h > 0 ? '$h H ' : '';
    result += '$m M';
    return result;
  }

  Widget _buildIconButton(IconData icon, void onPress()) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      onPressed: onPress,
    );
  }

  Widget _buildInfoCell(String value, String title,
      {Widget valueChild,
      Color labelColor = Colors.black,
      Color titleColor = Colors.black}) {
    var titleStyle = TextStyle(
        fontSize: Adapt.px(26), color: titleColor, fontWeight: FontWeight.bold);
    var valueStyle = TextStyle(
        color: labelColor, fontWeight: FontWeight.bold, fontSize: Adapt.px(28));
    return SizedBox(
      width: Adapt.px(160),
      child: Column(
        children: <Widget>[
          valueChild == null
              ? Text(
                  value ?? '',
                  style: valueStyle,
                )
              : valueChild,
          SizedBox(
            height: Adapt.px(8),
          ),
          Text(
            title,
            style: titleStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoGroup() {
    var d = state.listDetailModel;
    int _itemcout = d['itemCount'];
    double _totalRated = d['totalRated'];
    return Container(
      padding: EdgeInsets.symmetric(vertical: Adapt.px(20)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(Adapt.px(40))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          _buildInfoCell(_itemcout.toString() ?? '0', 'ITEMS'),
          Container(
            color: Colors.grey[300],
            width: Adapt.px(1),
            height: Adapt.px(60),
          ),
          _buildInfoCell('', 'RATING',
              valueChild: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    (_totalRated / _itemcout).toStringAsFixed(1) ?? '0.0',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: Adapt.px(28)),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.black,
                    size: Adapt.px(20),
                  )
                ],
              )),
          Container(
            color: Colors.grey[300],
            width: Adapt.px(1),
            height: Adapt.px(60),
          ),
          _buildInfoCell(_covertDuration(d['runTime'] ?? 0), 'RUNTIME'),
          Container(
            color: Colors.grey[300],
            width: Adapt.px(1),
            height: Adapt.px(60),
          ),
          _buildInfoCell(
              '\$${((d['revenue'] ?? 0) / 1000000000).toStringAsFixed(1)} B',
              'REVENUE'),
        ],
      ),
    );
  }

  Widget _buildShimmerHeader() {
    Color baseColor = Color(0xFF505050);
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.all(Adapt.px(30)),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: Color(0xFF707070),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.only(top: Adapt.px(100)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: Adapt.px(100),
                      height: Adapt.px(100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Adapt.px(50)),
                          color: baseColor),
                    ),
                    SizedBox(
                      width: Adapt.px(20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'A list by',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Adapt.px(30)),
                        ),
                        SizedBox(
                          height: Adapt.px(5),
                        ),
                        Container(
                          width: Adapt.px(120),
                          height: Adapt.px(28),
                          color: baseColor,
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    _buildIconButton(Icons.edit, () {}),
                    _buildIconButton(Icons.share, () {}),
                    _buildIconButton(Icons.sort, () {}),
                  ],
                ),
                SizedBox(
                  height: Adapt.px(20),
                ),
                Text('About this list',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: Adapt.px(30))),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(60),
                  height: Adapt.px(26),
                  color: baseColor,
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(60),
                  height: Adapt.px(26),
                  color: baseColor,
                ),
                SizedBox(
                  height: Adapt.px(10),
                ),
                Container(
                  width: Adapt.screenW() - Adapt.px(200),
                  height: Adapt.px(26),
                  color: baseColor,
                ),
                SizedBox(
                  height: Adapt.px(30),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildShareCardHeader() {
    var d = state.listDetailModel;
    int _itemCount = d['itemCount'];
    double cellwidth = Adapt.px(145);
    double _totalRated = d['totalRated'];
    return Column(
      children: <Widget>[
        SizedBox(
          height: Adapt.px(20),
        ),
        Text(d.documentID,
            style: TextStyle(
                color: Colors.white,
                fontSize: Adapt.px(45),
                fontWeight: FontWeight.bold)),
        SizedBox(
          height: Adapt.px(20),
        ),
        Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: Adapt.px(150),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: Adapt.px(80),
                      height: Adapt.px(80),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Adapt.px(40)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.user.photoUrl))),
                    ),
                    SizedBox(
                      height: Adapt.px(10),
                    ),
                    Text(
                      'A list by',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Adapt.px(30)),
                    ),
                    SizedBox(
                      height: Adapt.px(5),
                    ),
                    SizedBox(
                      width: Adapt.px(130),
                      child: Text(
                        state.user.displayName ?? '',
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: Adapt.px(20),
              ),
              Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      _buildInfoCell(
                        _itemCount?.toString() ?? '0',
                        'ITEMS',
                        labelColor: Colors.white,
                        titleColor: Colors.white,
                      ),
                      SizedBox(
                        width: Adapt.px(20),
                      ),
                      _buildInfoCell(
                        (_totalRated / _itemCount).toStringAsFixed(1) ?? '0.0',
                        'RATING',
                        labelColor: Colors.white,
                        titleColor: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Adapt.px(20),
                  ),
                  Row(
                    children: <Widget>[
                      _buildInfoCell(
                        _covertDuration(d['runTime'] ?? 0),
                        'RUNTIME',
                        labelColor: Colors.white,
                        titleColor: Colors.white,
                      ),
                      SizedBox(
                        width: Adapt.px(20),
                      ),
                      _buildInfoCell(
                        '\$${((d['revenue'] ?? 0) / 1000000000).toStringAsFixed(1)} B',
                        'REVENUE',
                        labelColor: Colors.white,
                        titleColor: Colors.white,
                      ),
                    ],
                  )
                ],
              )
            ]),
      ],
    );
  }

  Widget _buildHeader() {
    var d = state.listDetailModel;
    if (d != null)
      return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          fit: BoxFit.cover,
          //colorFilter: ColorFilter.mode(Colors.black87, BlendMode.color),
          image: CachedNetworkImageProvider(
              state?.listDetailModel['backGroundUrl']),
        )),
        child: Container(
          alignment: Alignment.bottomLeft,
          padding: EdgeInsets.all(Adapt.px(30)),
          color: Colors.black.withOpacity(0.7),
          child: SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: Adapt.px(100)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: <Widget>[
                    Container(
                      width: Adapt.px(100),
                      height: Adapt.px(100),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Adapt.px(50)),
                          image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                  state.user.photoUrl))),
                    ),
                    SizedBox(
                      width: Adapt.px(20),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'A list by',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: Adapt.px(30)),
                        ),
                        SizedBox(
                          height: Adapt.px(5),
                        ),
                        SizedBox(
                          width: Adapt.px(200),
                          child: Text(
                            state.user.displayName ?? '',
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ),
                    Expanded(
                      child: Container(),
                    ),
                    //_buildIconButton(Icons.edit, () {}),
                    _buildIconButton(Icons.share, () {
                      showDialog(
                          context: viewService.context,
                          builder: (ctx) {
                            return ShareCard(
                              backgroundImage:
                                  state.listDetailModel['backGroundUrl'],
                              qrValue:
                                  "https://www.themoviedb.org/list/${state.listDetailModel.documentID}",
                              header: _buildShareCardHeader(),
                            );
                          });
                    }),
                    PopupMenuButton<SortCondition>(
                      offset: Offset(0, Adapt.px(100)),
                      icon: Icon(Icons.sort, color: Colors.white),
                      onSelected: (selected) => dispatch(
                          ListDetailPageActionCreator.sortChanged(selected)),
                      itemBuilder: (ctx) {
                        return state.sortBy.map((s) {
                          var unSelectedStyle = TextStyle(color: Colors.grey);
                          var selectedStyle = TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold);
                          return PopupMenuItem<SortCondition>(
                            value: s,
                            child: Row(
                              children: <Widget>[
                                Text(
                                  s.name,
                                  style: s.isSelected
                                      ? selectedStyle
                                      : unSelectedStyle,
                                ),
                                Expanded(
                                  child: Container(),
                                ),
                                s.isSelected ? Icon(Icons.check) : SizedBox()
                              ],
                            ),
                          );
                        }).toList();
                      },
                    )
                  ]),
                  SizedBox(
                    height: Adapt.px(20),
                  ),
                  Text('About this list',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: Adapt.px(30))),
                  Container(
                    width: Adapt.screenW() - Adapt.px(60),
                    height: Adapt.px(120),
                    child: Text(
                      d['description'] ?? '',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: TextStyle(
                          color: Colors.white, fontSize: Adapt.px(26)),
                    ),
                  ),
                  SizedBox(
                    height: Adapt.px(30),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    else
      return _buildShimmerHeader();
  }

  Widget _buildListCell(DocumentSnapshot d) {
    return GestureDetector(
      //onTap: () => dispatch(ListDetailPageActionCreator.cellTapped(d)),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[200],
            image: DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(
                    ImageUrl.getUrl(d['photourl'], ImageSize.w300)))),
        child: Column(
          children: <Widget>[
            Container(
                padding: EdgeInsets.all(Adapt.px(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: Colors.white,
                      size: Adapt.px(30),
                    ),
                    Text(
                      d['rated'].toStringAsFixed(1),
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    var d = state.listDetailModel;
    var width = Adapt.screenW() / 3;
    var height = Adapt.px(300);
    return StreamBuilder<QuerySnapshot>(
      stream: state.listDetailModel.reference.collection('Media').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData)
          return SliverGrid.extent(
            childAspectRatio: 2 / 3,
            maxCrossAxisExtent: width,
            crossAxisSpacing: Adapt.px(10),
            mainAxisSpacing: Adapt.px(10),
            children: <Widget>[
              ShimmerCell(width, height, 0),
              ShimmerCell(width, height, 0),
              ShimmerCell(width, height, 0),
              ShimmerCell(width, height, 0),
              ShimmerCell(width, height, 0),
              ShimmerCell(width, height, 0),
              ShimmerCell(width, height, 0),
              ShimmerCell(width, height, 0),
              ShimmerCell(width, height, 0),
            ],
          );
        return SliverGrid.extent(
          childAspectRatio: 2 / 3,
          maxCrossAxisExtent: width,
          crossAxisSpacing: Adapt.px(10),
          mainAxisSpacing: Adapt.px(10),
          children: snapshot.data.documents.map(_buildListCell).toList(),
        );
      },
    );
  }

  return Scaffold(
    body: CustomScrollView(
      controller: state.scrollController,
      slivers: <Widget>[
        SliverAppBar(
          backgroundColor: Color.fromRGBO(50, 50, 50, 1),
          pinned: true,
          title: Text(
            state?.listDetailModel?.documentID ?? '',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          expandedHeight: Adapt.px(550),
          flexibleSpace: FlexibleSpaceBar(
            background: _buildHeader(),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Adapt.px(100)),
            child: _buildInfoGroup(),
          ),
        ),
        _buildBody(),
        SliverToBoxAdapter(
          child: SizedBox(
            height: Adapt.px(30),
          ),
        )
      ],
    ),
  );
}
