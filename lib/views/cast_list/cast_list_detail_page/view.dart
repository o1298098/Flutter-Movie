import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/models/base_api_model/cast_list_detail.dart';
import 'package:movie/models/enums/imagesize.dart';

import 'state.dart';

Widget buildView(
    CastListDetailState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
    appBar: AppBar(
      title: Text(state.castList?.name ?? ''),
    ),
    body: ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        itemBuilder: (_, index) {
          final _d = state.listDetail.data[index];
          return _CastCell(
            data: _d,
          );
        },
        separatorBuilder: (_, index) => SizedBox(height: 20),
        itemCount: state.listDetail?.data?.length ?? 0),
  );
}

class _CastCell extends StatelessWidget {
  final BaseCast data;
  const _CastCell({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: CachedNetworkImageProvider(
                ImageUrl.getUrl(data.profileUrl, ImageSize.w300),
              ),
            ),
          ),
        ),
        SizedBox(width: 10),
        Text(data?.name ?? '')
      ]),
    );
  }
}
