import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/Adapt.dart';
import 'package:movie/actions/imageurl.dart';
import 'package:movie/customwidgets/shimmercell.dart';
import 'package:movie/generated/i18n.dart';
import 'package:movie/models/enums/imagesize.dart';
import 'package:shimmer/shimmer.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  void _bioReadMore() async {
    if (state.biography == null || state.biography.isEmpty) return;
    await showGeneralDialog(
        context: viewService.context,
        barrierLabel: 'bio',
        barrierColor: Colors.black45,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        pageBuilder: (context, animation, secAnimation) {
          return Center(
            child: Material(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Adapt.px(20))),
              child: Container(
                padding: EdgeInsets.all(Adapt.px(30)),
                width: Adapt.screenW() - Adapt.px(60),
                height: Adapt.screenH() - Adapt.px(400),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Text(
                      state?.biography == null ||
                              state?.biography?.isEmpty == true
                          ? "We don't have a biography for ${state.profileName}"
                          : state.biography,
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontSize: Adapt.px(30),
                          height: 1.2,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  Widget _buildnamecell() {
    if (state.profileName == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          height: Adapt.px(50),
          width: Adapt.px(300),
          color: Colors.grey[200],
        ),
      ));
    else
      return Hero(
        tag: 'Actor' + state.peopleid.toString(),
        child: Material(
          color: Colors.transparent,
          child: Text(
            state.profileName ?? '',
            style: TextStyle(
                color: Colors.black,
                fontSize: Adapt.px(50),
                fontWeight: FontWeight.w700),
          ),
        ),
      );
  }

  Widget _buildBiography() {
    if (state.biography == null)
      return SizedBox(
          child: Shimmer.fromColors(
        baseColor: Colors.grey[200],
        highlightColor: Colors.grey[100],
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: Adapt.px(60)),
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
              SizedBox(
                height: Adapt.px(10),
              ),
              Container(
                color: Colors.grey[200],
                height: Adapt.px(30),
              ),
            ],
          ),
        ),
      ));
    else
      return Text(
        state?.biography == null || state?.biography?.isEmpty == true
            ? "We don't have a biography for ${state.profileName}"
            : state.biography,
        maxLines: 10,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: Adapt.px(30)),
      );
  }

  Widget _buildYearsOld() {
    if (state.birthday != null) {
      int yearold = DateTime.now().year - DateTime.parse(state.birthday).year;
      return Text(
        '$yearold years old',
        style: TextStyle(color: Colors.grey[600], fontSize: Adapt.px(32)),
      );
    } else
      return SizedBox(
        height: Adapt.px(35),
      );
  }

  return Container(
      key: ValueKey('header'),
      //padding: EdgeInsets.all(Adapt.px(30)),
      width: Adapt.screenW(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
              tag: 'people${state.peopleid}',
              child: Material(
                child: Container(
                  height: Adapt.px(900),
                  decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 20,
                            offset: Offset(0, 5),
                            color: Colors.black38),
                      ],
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(Adapt.px(50)),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                            ImageUrl.getUrl(state.profilePath, ImageSize.w300)),
                      )),
                ),
              )),
          SizedBox(
            height: Adapt.px(50),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            child: _buildnamecell(),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            child: _buildYearsOld(),
          ),
          SizedBox(
            height: Adapt.px(50),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    I18n.of(viewService.context).biography,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: Adapt.px(40)),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  InkWell(
                      onTap: () => _bioReadMore(),
                      child: Text(
                        'Read more',
                        style: TextStyle(color: Colors.grey[500]),
                      ))
                ],
              )),
          SizedBox(
            height: Adapt.px(30),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: Adapt.px(30)),
            child: _buildBiography(),
          ),
          SizedBox(
            height: Adapt.px(50),
          )
        ],
      ));
}
