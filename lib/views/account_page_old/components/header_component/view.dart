import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';
import 'package:movie/actions/adapt.dart';
import 'package:movie/views/account_page_old/action.dart';

import 'state.dart';

Widget buildView(
    HeaderState state, Dispatch dispatch, ViewService viewService) {
  return Row(
    children: <Widget>[
      SizedBox(width: Adapt.px(40)),
      Container(
        width: Adapt.px(100),
        height: Adapt.px(100),
        decoration: BoxDecoration(
          color: Color(0xFF8499FD),
          shape: BoxShape.circle,
          image: state.user?.firebaseUser?.photoUrl != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                      state.user?.firebaseUser?.photoUrl),
                )
              : null,
        ),
      ),
      SizedBox(width: Adapt.px(20)),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${state.user?.firebaseUser?.displayName ?? 'Guest'}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: Adapt.px(35),
            ),
          ),
          SizedBox(height: Adapt.px(10)),
          GestureDetector(
            onTap: () =>
                dispatch(AccountPageActionCreator.navigatorPush('premiumPage')),
            child: (state.user?.isPremium ?? false)
                ? Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: Adapt.px(10),
                      vertical: Adapt.px(10),
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFC107),
                      borderRadius: BorderRadius.circular(
                        Adapt.px(10),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Premium',
                        style: TextStyle(
                          fontSize: Adapt.px(20),
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: Adapt.px(10), vertical: Adapt.px(10)),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(Adapt.px(10))),
                    child: Text(
                      'Get Premium >',
                      style: TextStyle(
                        color: const Color(0xFF000000),
                        fontSize: Adapt.px(20),
                      ),
                    ),
                  ),
          )
        ],
      ),
      Expanded(child: SizedBox()),
      state.user == null
          ? InkWell(
              onTap: () => dispatch(AccountPageActionCreator.onLogin()),
              child: Container(
                  height: Adapt.px(60),
                  margin: EdgeInsets.only(
                      right: Adapt.px(30),
                      top: Adapt.px(13),
                      bottom: Adapt.px(13)),
                  padding: EdgeInsets.symmetric(
                      horizontal: Adapt.px(20), vertical: Adapt.px(10)),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Adapt.px(30)),
                      border:
                          Border.all(color: const Color(0xFFFFFFFF), width: 2)),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                        color: const Color(0xFFFFFFFF), fontSize: Adapt.px(26)),
                  )))
          : PopupMenuButton<String>(
              padding: EdgeInsets.zero,
              offset: Offset(0, Adapt.px(100)),
              icon: Icon(
                Icons.more_vert,
                color: const Color(0xFFFFFFFF),
                size: Adapt.px(50),
              ),
              onSelected: (selected) {
                switch (selected) {
                  case 'signOut':
                    dispatch(AccountPageActionCreator.onLogout());
                    break;
                  case 'notifications':
                    dispatch(AccountPageActionCreator.notificationsTapped());
                    break;
                  case 'newDesign':
                    Navigator.of(viewService.context)
                        .pushNamed('testAccountPage');
                }
              },
              itemBuilder: (ctx) {
                return [
                  PopupMenuItem<String>(
                    value: 'newDesign',
                    child: const _DropDownItem(
                      title: 'new design',
                      icon: Icons.pageview,
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'notifications',
                    child: const _DropDownItem(
                      title: 'Notifications',
                      icon: Icons.notifications_none,
                    ),
                  ),
                  PopupMenuItem<String>(
                    value: 'signOut',
                    child: const _DropDownItem(
                      title: 'Sign Out',
                      icon: Icons.exit_to_app,
                    ),
                  ),
                ];
              },
            ),
      SizedBox(width: Adapt.px(10))
    ],
  );
}

class _DropDownItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const _DropDownItem({@required this.title, this.icon});
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[Icon(icon), SizedBox(width: 10), Text(title)],
    );
  }
}
